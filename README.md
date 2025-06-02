# PC Stats 
A Libre Hardware Monitor Dashboard

---

## 📌 Overview  
**PC Stats Monitor** is a real-time hardware monitoring solution that provides detailed insights into your system's performance. Built with Django and leveraging **LibreHardwareMonitor**, it delivers a clean, web-based dashboard accessible from any device on your local network.  

### 🔍 Key Features  
✅ **Real-time monitoring** of CPU, GPU, RAM, Disk and Network Usage  
✅ **Temperature & power tracking** for critical components  
✅ **Historical max values** to track peak performance  
✅ **Responsive & customizable UI** with interactive charts  
✅ **Network transfer statistics** (upload/download speeds)  
✅ **Lightweight & efficient**, running as a background service  

---

## ⚙️ Technical Details  

### 📦 Backend Stack  
- **Framework**: Django (Python)  
- **Real-time Updates**: Django Channels  
- **Data Collection**:  
  - **LibreHardwareMonitor** (for hardware sensors)  
  - **psutil** (for system-level metrics)  

### 🖥️ Frontend Stack  
- **HTML5 / CSS3 / JavaScript**  
- **Chart.js** for dynamic visualizations  
- **Responsive design** (works on desktop & mobile)  

### 📋 Requirements  
- **Python 3.10+**  
- **LibreHardwareMonitor** (running as a service)  
- **Windows OS** (optimized for Windows 10/11)  

---

## 🚀 Installation Guide  

### 1️⃣ Prerequisites  
- Ensure **Python 3.10+** is installed ([Download Python](https://www.python.org/downloads/))  
- Install **LibreHardwareMonitor** ([GitHub](https://github.com/LibreHardwareMonitor/LibreHardwareMonitor))  

### 2️⃣ Automated Installation  
1. **Download** the project files.  
2. **Run `PcStats Install.bat` as Administrator.**  
3. Follow the on-screen instructions—the script will:  
   - Install Python dependencies (`Django`, `psutil`, `requests`, etc.)  
   - Extract the application to `C:\Pc Stats`  
   - Configure LibreHardwareMonitor settings  
   - Generate device mappings (`device_category_map.json`)  
   - Set up a **startup shortcut** for automatic launch  
4. Once installed, the dashboard will open at:  
   🔗 **`http://[YOUR-IP]:8046`**  

### 3️⃣ Manual Configuration (if needed)  
- Ensure **LibreHardwareMonitor** is running with:  
  - **Remote Web Server** enabled (`Options > Remote Web Server > Enable`)  
  - **Port set to `8085`** (default)  
  - **Running at startup** (recommended)  

---

## 🗑️ Uninstallation Guide  
To completely remove PC Stats Monitor:  
1. **Run `PcStats Uninstall.bat` as Administrator.**  
2. The script will:  
   - Terminate running processes  
   - Delete the installation folder (`C:\Pc Stats`)  
   - Remove startup entries  
   - Clean up all components  

---

## 💖 Support & Donations  
If you find this tool useful and want to support further development, consider **buying me a coffee!**  

[![Donate via PayPal](https://img.shields.io/badge/Donate-PayPal-blue?style=for-the-badge&logo=paypal)](https://www.paypal.com/donate/?hosted_button_id=WAMMNFAM2V9S8)  

Your support helps keep this project **free and actively maintained!**  

---

## 🛠️ Troubleshooting  
🔹 **Dashboard not loading?**  
   - Ensure **LibreHardwareMonitor** is running.  
   - Check if **ports `8046` (dashboard) and `8085` (LHM API)** are accessible.  
   - Verify **firewall exceptions** for Python and LibreHardwareMonitor.  

🔹 **Missing sensor data?**  
   - Re-run `list_sensors.py` to regenerate device mappings.  
   - Ensure **LibreHardwareMonitor** has proper admin rights.  

---


**Enjoy monitoring your system with ease!** 🚀  


![screencapture-192-168-2-50-8046-2025-06-02-22_49_43](https://github.com/user-attachments/assets/3ea477d8-f359-4ab4-99e1-5852ec8de74b)
![screencapture-192-168-2-50-8046-2025-06-02-22_49_19](https://github.com/user-attachments/assets/2b37a75b-9982-4524-ab1f-4d9418714b67)
![screencapture-192-168-3-2-8046-2025-05-30-14_13_30](https://github.com/user-attachments/assets/fdfc478b-51a8-4e1c-95d8-91deb350342d)
![screencapture-192-168-3-2-8046-2025-05-30-14_13_13](https://github.com/user-attachments/assets/79de61bf-a326-46ff-b7a4-e7ada192dc0d)
