# PC Stats Monitor  
### Comprehensive Hardware Monitoring Dashboard  

![Dashboard Preview](https://via.placeholder.com/800x400/2a2a2a/ffffff?text=PC+Stats+Monitor+Dashboard)  

---

## 📌 Overview  
**PC Stats Monitor** is a professional, real-time hardware monitoring solution that provides detailed insights into your system's performance. Built with Django and leveraging **LibreHardwareMonitor**, it delivers a clean, web-based dashboard accessible from any device on your local network.  

### 🔍 Key Features  
✅ **Real-time monitoring** of CPU, GPU, RAM, disk, and network usage  
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

![screencapture-192-168-3-2-8046-2025-05-30-14_13_13](https://github.com/user-attachments/assets/b4e31809-60b2-4dfe-812e-8ca988f6fcab)
![screencapture-192-168-3-2-8046-2025-05-30-14_13_46](https://github.com/user-attachments/assets/c8869dd0-e6b7-4f32-a13c-c63b00078d02)
![screencapture-192-168-3-2-8046-2025-05-30-14_13_30](https://github.com/user-attachments/assets/2a2d8a0c-a6db-469b-8b4f-c301b6bb3293)
