@echo off
setlocal

rem Get the directory of the script
set "CUR_DIR=%~dp0"
set "CUR_DIR=%CUR_DIR:~0,-1%"  rem remove trailing backslash

rem Get current user PATH
for /f "tokens=2* delims= " %%A in ('reg query "HKCU\Environment" /v Path 2^>nul') do set "USER_PATH=%%B"

rem Check if CUR_DIR is already in PATH
echo %USER_PATH% | find /i "%CUR_DIR%" >nul
if %errorlevel%==0 (
    echo Folder already in PATH: %CUR_DIR%
    goto :EOF
)

rem Append to PATH for current user
if defined USER_PATH (
    setx Path "%USER_PATH%;%CUR_DIR%"
) else (
    setx Path "%CUR_DIR%"
)

echo Added to PATH for current user: %CUR_DIR%
echo You may need to open a new terminal for changes to take effect.

endlocal
pause
