@echo off
echo Restarting MySQL3307 Service...
net stop MySQL3307
timeout /t 2 /nobreak >nul
net start MySQL3307
if %errorlevel% == 0 (
    echo MySQL3307 restarted successfully!
) else (
    echo Failed to restart MySQL3307. Make sure you run this as Administrator.
)
pause
