@echo off
echo Starting MySQL3307 Service...
net start MySQL3307
if %errorlevel% == 0 (
    echo MySQL3307 started successfully!
) else (
    echo Failed to start MySQL3307. Make sure you run this as Administrator.
)
pause
