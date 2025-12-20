@echo off
echo Fixing Java version in build.gradle...

cd /d "%~dp0\android\app"

powershell -Command "$content = Get-Content 'build.gradle' -Raw; $content = $content -replace 'VERSION_21', 'VERSION_17'; $content = $content -replace '21', '17'; Set-Content 'build.gradle' -Value $content -NoNewline"

echo Done!
echo.
echo Now run: BUILD_ABSOLUTE_FINAL.bat
pause
