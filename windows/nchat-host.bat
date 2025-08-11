@echo off
set PORT=1234
echo Starting ncat chat server on port %PORT%...
:loop
ncat --ssl -l --keep-open -p %PORT%
echo Connection closed. Waiting for new connection...
goto loop