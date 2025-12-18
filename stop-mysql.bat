@echo off
echo Stopping MySQL3307 Service...
net stop MySQL3307
if %errorlevel% == 0 (
    echo MySQL3307 stopped successfully!
) else (
    echo Failed to stop MySQL3307. Make sure you run this as Administrator.
)
pause
