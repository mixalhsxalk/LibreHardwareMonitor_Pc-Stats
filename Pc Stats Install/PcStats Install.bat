@echo off
:: Admin Check
openfiles >nul 2>&1
if errorlevel 1 (
    echo [*] Relaunching as Administrator...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

color 0E
title PC Stats Setup
cls
echo =============================================================
echo                   PC STATS INSTALLER
echo =============================================================
timeout /t 2 >nul

set "SCRIPT_DIR=%~dp0"
set REQUIREMENTS=%SCRIPT_DIR%requirements.txt
set ARCHIVE=%SCRIPT_DIR%PcStats.zip
set EXTRACT_PATH=C:\Pc Stats
set LHM_EXE=LibreHardwareMonitor.exe
set VBS_TARGET="C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\Run_PcStats_Hidden.lnk"

:: STEP 1 - Check Python
where python >nul 2>&1
if errorlevel 1 (
    echo Python not found on system.
    echo Opening download page for Python 3.10.11...
    start https://www.python.org/ftp/python/3.10.11/python-3.10.11-amd64.exe
    echo After installation completes,please restart this installer.
    pause
    exit /b

) else (
    echo Python found.
)
timeout /t 1 >nul

:: STEP 2 - Check LHM Installation
echo.
set /p HASLHM="Have you installed LibreHardwareMonitor already? (Y/N): "
if /i not "%HASLHM%"=="Y" (
    echo Opening LibreHardwareMonitor GitHub page...
    start https://github.com/LibreHardwareMonitor/LibreHardwareMonitor
    echo After installing it, this script will restart.
    pause
    start "" "%~f0"
    exit /b
)
timeout /t 1 >nul

:: STEP 3 - Install Python Requirements

:: Check if Python is available
where python >nul 2>&1
if errorlevel 1 (
    echo [!] Python was not found on your system.
    echo     Please install Python and then rerun this install script.
    pause
    exit /b
)

if not exist "%REQUIREMENTS%" (
    echo [!] The file 'requirements.txt' was not found at: %REQUIREMENTS%
    echo     Please make sure it exists in the same folder as this script.
    pause
    exit /b
)

echo.
echo [*] Upgrading pip to the latest version...
python -m pip install --upgrade pip
if errorlevel 1 (
    echo [!] pip upgrade failed.
    echo     Please check your Python/pip installation and rerun this install script.
    pause
    exit /b
)
timeout /t 1 >nul

:: Process each line in requirements.txt
for /f "usebackq delims=" %%p in ("%REQUIREMENTS%") do (
    call :InstallPkg %%p
    if errorlevel 1 (
        pause
        exit /b
    )
)
timeout /t 2 >nul

:: STEP 4 - Extract Django Project
echo.
powershell -Command "Expand-Archive -LiteralPath '%ARCHIVE%' -DestinationPath '%EXTRACT_PATH%' -Force"
if errorlevel 1 (
    echo [!] Project extraction failed. Please check if PcStats.zip exists and is not corrupted.
    pause
    exit /b
)
echo [*] Django project extracted to: %EXTRACT_PATH%
timeout /t 2 >nul

:: STEP 5 - Configure LibreHardwareMonitor
echo.
echo [*] Please configure Libre Hardware Monitor:
echo     -Open Libre Hardware Monitor and go to Options. Then Enable [x] Start Minimized and [x] Run on Windows Startup.
echo     -Open Libre Hardware Monitor and go to Options / Remote Web Server / Interface-Port and check if the Port is 8085.
echo     -Open Libre Hardware Monitor and go to Options / Remote Web Server and Enable [x] Run
echo.
pause
timeout /t 1 >nul

:: STEP 6 - Update list_sensors.py
echo.
set "LIST_SCRIPT=%SCRIPT_DIR%list_sensors.py"
if not exist "%LIST_SCRIPT%" (
    echo [!] list_sensors.py not found at: %LIST_SCRIPT%
    pause
    exit /b
)

echo Using script path: %LIST_SCRIPT%

:: Get valid IPv4 address only
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /i "IPv4"') do (
    echo %%a | findstr "192.168. 10. 172. 127." >nul
    if not errorlevel 1 (
        set IP=%%a
        goto :gotip
    )
)

:gotip
set IP=%IP:~1%
echo Detected IP: %IP%

echo [*] Updating LHM_URL in list_sensors.py...
powershell -Command "(Get-Content '%LIST_SCRIPT%') -replace 'LHM_URL\s*=.*', 'LHM_URL = \"http://%IP%:8085/data.json\"' | Set-Content -Encoding UTF8 '%LIST_SCRIPT%'"

:: STEP 7 - Run list_sensors.py to generate JSON
echo [*] Running list_sensors.py to generate device_category_map.json...
python "%LIST_SCRIPT%"
if errorlevel 1 (
    echo [!] Python script failed.
    pause
    exit /b
)

if exist "%SCRIPT_DIR%device_category_map.json" (
    move /Y "%SCRIPT_DIR%device_category_map.json" "%EXTRACT_PATH%\device_category_map.json" >nul
    echo [*] JSON saved to %EXTRACT_PATH%
) else (
    echo [!] JSON file not generated.
    pause
    exit /b
)
timeout /t 1 >nul

:: STEP 8 - Create a shortcut to PcStats_hidden.vbs in Startup folder and run it
set "VBS_SOURCE=C:\Pc Stats\PcStats_hidden.vbs"
set "SHORTCUT_PATH=C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\Run_PcStats_Hidden.lnk"

echo Creating shortcut to %VBS_SOURCE% in Startup folder...

powershell -NoProfile -Command ^
"$WshShell = New-Object -ComObject WScript.Shell; ^
$Shortcut = $WshShell.CreateShortcut('%SHORTCUT_PATH%'); ^
$Shortcut.TargetPath = 'wscript.exe'; ^
$Shortcut.Arguments = '\"%VBS_SOURCE%\"'; ^
$Shortcut.WorkingDirectory = 'C:\Pc Stats'; ^
$Shortcut.WindowStyle = 7; ^
$Shortcut.Save()"

if errorlevel 1 (
    echo [!] Failed to create startup shortcut.
    pause
    exit /b
) else (
    echo [*] Startup shortcut created successfully.
)

timeout /t 1 >nul

:: Run the shortcut
start "" "%SHORTCUT_PATH%"

:: STEP 9 - Show final dashboard info and launch
echo.
echo [*] Web Dashboard will be available at:
echo     http://%IP%:8046
start "" http://%IP%:8046
@echo off
echo We are Done.
echo If you like my project, buy me a beer:
powershell -Command "Write-Host 'https://www.paypal.com/donate/?hosted_button_id=WAMMNFAM2V9S8' -ForegroundColor Cyan"

pause >nul
exit /b

:InstallPkg
python -m pip install %~1 >nul 2>&1
if errorlevel 1 (
    echo     [!] Failed to install: %~1. Please check the package name or your internet connection.
    pause
    exit /b
)
echo     [*] Installed: %~1
goto :eof