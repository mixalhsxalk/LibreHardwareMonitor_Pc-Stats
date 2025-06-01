@echo off
:: Check for admin rights
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [*] Requesting administrative privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

chcp 65001 >nul
color 0C
title Pc Stats Uninstaller

echo.
echo =============================================
echo        Pc Stats Uninstaller Script          
echo =============================================
echo.

:: Step 1: Kill Python background processes
echo [*] Checking for running Python background servers...
tasklist /FI "IMAGENAME eq python.exe" 2>NUL | find /I "python.exe" >NUL
if "%ERRORLEVEL%"=="0" (
    echo [!] Python process detected. Attempting to terminate...
    taskkill /F /IM python.exe >nul 2>&1
    echo [✓] Python process terminated.
) else (
    echo [✓] No Python process found.
)
timeout /t 2 >nul

:: Step 2: Delete Pc Stats folder
set "INSTALL_DIR=C:\Pc Stats"
if exist "%INSTALL_DIR%" (
    echo [*] Removing folder: "%INSTALL_DIR%"...
    rmdir /s /q "%INSTALL_DIR%"
    if exist "%INSTALL_DIR%" (
        echo [!] Failed to remove %INSTALL_DIR%.
        echo [!] Please check if it is in use or try again manually.
        pause
        exit /b 1
    ) else (
        echo [✓] Folder removed successfully.
    )
) else (
    echo [✓] Installation folder not found. Skipping...
)
timeout /t 2 >nul

:: Step 3: Delete VBS startup launcher
set "VBS_FILE=C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\Run_PcStats_Hidden.lnk"
if exist "%VBS_FILE%" (
    echo [*] Removing startup launcher: "%VBS_FILE%"...
    del /f /q "%VBS_FILE%"
    if exist "%VBS_FILE%" (
        echo [!] Failed to delete %VBS_FILE%.
        echo [!] Please check if it is in use or try again manually.
        pause
        exit /b 1
    ) else (
        echo [✓] Startup file deleted successfully.
    )
) else (
    echo [✓] Startup launcher not found. Skipping...
)
timeout /t 2 >nul

:: Completion
echo.
echo =============================================
echo [✓] Uninstallation completed successfully.
echo =============================================
timeout /t 3 >nul
exit /b 0
