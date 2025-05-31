import requests
import tkinter as tk
from tkinter import ttk, messagebox
import json
import os

# LibreHardwareMonitor JSON endpoint
LHM_URL = "http://192.168.3.2:8085/data.json"
OUTPUT_FILE = os.path.join(os.path.dirname(__file__), "device_category_map.json")
CATEGORY_OPTIONS = ["MB", "CPU", "GPU", "RAM", "Storage", "Network","Battery"]

def fetch_lhm_data():
    try:
        response = requests.get(LHM_URL, timeout=2)
        response.raise_for_status()
        return response.json()
    except Exception as e:
        print(f"Error: Could not access LibreHardwareMonitor API: {e}")
        return None

def extract_unique_devices(data):
    devices = set()

    def traverse(node, path=""):
        if "Text" in node:
            text = node["Text"]
            full_path = f"{path}/{text}" if path else text
            path_parts = full_path.split("/")
            if "Sensor" in path_parts:
                idx = path_parts.index("Sensor")
                if idx + 2 < len(path_parts):
                    devices.add(path_parts[idx + 2])
        for child in node.get("Children", []):
            traverse(child, f"{path}/{node.get('Text', '')}")

    traverse(data)
    return sorted(devices)

def launch_selector(devices):
    root = tk.Tk()
    root.title("Device Category Selector")
    root.geometry("500x600")
    root.resizable(False, True)

    tk.Label(root, text="Assign a category to each device:", font=("Arial", 12, "bold")).pack(pady=10)

    container = tk.Frame(root)
    container.pack(fill="both", expand=True)

    canvas = tk.Canvas(container)
    scrollbar = tk.Scrollbar(container, orient="vertical", command=canvas.yview)
    scrollable_frame = tk.Frame(canvas)

    scrollable_frame.bind(
        "<Configure>",
        lambda e: canvas.configure(scrollregion=canvas.bbox("all"))
    )

    canvas.create_window((0, 0), window=scrollable_frame, anchor="nw")
    canvas.configure(yscrollcommand=scrollbar.set)
    canvas.pack(side="left", fill="both", expand=True)
    scrollbar.pack(side="right", fill="y")

    selected_categories = {}

    for i, device in enumerate(devices):
        tk.Label(scrollable_frame, text=device, anchor="w", width=40).grid(row=i, column=0, sticky="w", padx=10, pady=4)
        combo = ttk.Combobox(scrollable_frame, values=CATEGORY_OPTIONS, state="readonly", width=15)
        combo.current(0)
        combo.grid(row=i, column=1, padx=10)
        selected_categories[device] = combo

    def save_and_close():
        mapping = {
            device: combo.get()
            for device, combo in selected_categories.items()
            if combo.get() != "MB"
        }
        with open(OUTPUT_FILE, "w") as f:
            json.dump(mapping, f, indent=2)
        messagebox.showinfo("Saved", f"Mapping saved to:\n{OUTPUT_FILE}")
        root.destroy()

    tk.Button(root, text="Save & Close", command=save_and_close, font=("Arial", 11)).pack(pady=10)
    root.mainloop()

def main():
    print("Connecting to LibreHardwareMonitor...")
    data = fetch_lhm_data()
    if data:
        devices = extract_unique_devices(data)
        if not devices:
            print("No devices found.")
            return
        print(f"Found {len(devices)} unique devices.")
        launch_selector(devices)

if __name__ == "__main__":
    main()
