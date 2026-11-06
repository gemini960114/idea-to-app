@echo off
rem Check that every course tool can be found. Run this in a NEW window after install.bat finishes.
setlocal
set OK=1
for %%T in (git gh uv node npm pandoc ffmpeg soffice) do (
  where %%T >nul 2>&1 && (echo [OK]      %%T) || (echo [MISSING] %%T & set OK=0)
)
if exist "C:\Tools\skills\project-report\SKILL.md" (echo [OK]      project-report skill) else (echo [MISSING] project-report skill & set OK=0)
echo.
git --version
gh --version | findstr /b "gh"
uv --version
node --version
pandoc --version | findstr /b "pandoc"
ffmpeg -version | findstr /b "ffmpeg"
echo.
if "%OK%"=="1" (echo All tools found.) else (echo Some tools are missing. Re-run install.bat as administrator.)
pause
