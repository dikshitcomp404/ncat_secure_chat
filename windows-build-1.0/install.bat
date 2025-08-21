@echo off
setlocal

echo "Checking for Nmap/Ncat installation..."

:: Check if ncat.exe is in PATH
where ncat >nul 2>&1
if errorlevel 1 (
    echo "Ncat not found. Installing Nmap (which includes Ncat) with winget..."
    winget install -e --id Insecure.Nmap
    if errorlevel 1 (
        echo "Failed to install Nmap via winget. Please install manually from https://nmap.org/download.html"
        exit /b 1
    )
) else (
    echo "Ncat already installed."
)

:: Create nchat dir in %USERPROFILE%
set NCHAT_DIR=%USERPROFILE%\nchat
if not exist "%NCHAT_DIR%" (
    mkdir "%NCHAT_DIR%"
)

:: Copy scripts if not already there
echo "Copying scripts..."
copy /Y "%~dp0nchat-host.bat" "%NCHAT_DIR%\"
echo "nchat-host.bat copied to %NCHAT_DIR%"
copy /Y "%~dp0nchat-connect.bat" "%NCHAT_DIR%\"
echo "nchat-connect.bat copied to %NCHAT_DIR%"



:: Add to PATH if not already present
echo "Resolving the enviroment variable 'Path' for both nchat as well as nmap"
echo %PATH% | find /i "%NCHAT_DIR%" >nul
if errorlevel 1 (
    echo "Adding %NCHAT_DIR% to PATH..."
    setx PATH "%PATH%;%NCHAT_DIR%"
) else (
    echo "%NCHAT_DIR% is already in PATH."
)

set "Nmap_DIR=C:\Program Files (x86)\Nmap"
echo %PATH% | find /i "%Nmap_DIR%" >nul
if errorlevel 1 (
    echo "Adding %NCHAT_DIR% to PATH..."
    setx PATH "%PATH%;%Nmap_DIR%"
) else (
    echo "%Nmap_DIR% is already in PATH."
)


echo.
echo "Installation complete! Open a new terminal and run:"
echo   "nchat-host   (to host)"
echo   "nchat-client (to connect)"
echo.

endlocal
