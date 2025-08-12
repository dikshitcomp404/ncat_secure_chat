@echo off
set PORT=1234
set /p HOST=Enter VM host IP: 
echo Connecting to %HOST% on port %PORT%...
:loop
ncat --ssl %HOST% %PORT%
echo Disconnected. Reconnecting in 3 seconds...
timeout /t 3 >nul
goto loop
