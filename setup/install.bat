@echo off
rem Install course tools on this PC. Right-click this file and choose "Run as administrator".
net session >nul 2>&1
if %errorlevel% neq 0 (
  echo [ERROR] Please right-click install.bat and choose "Run as administrator".
  pause
  exit /b 1
)
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0install.ps1"
pause
