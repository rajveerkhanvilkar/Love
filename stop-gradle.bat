@echo off
echo ========================================
echo STOPPING STUCK GRADLE PROCESSES
echo ========================================
echo.

echo [1/3] Killing all Java/Gradle processes...
taskkill /F /IM java.exe 2>nul
taskkill /F /IM javaw.exe 2>nul
taskkill /F /IM gradle.exe 2>nul
timeout /t 2 /nobreak >nul

echo.
echo [2/3] Stopping Gradle daemons...
cd /d "%~dp0\android"
call gradlew --stop 2>nul
timeout /t 2 /nobreak >nul

echo.
echo [3/3] Cleaning up lock files...
cd /d "%~dp0"
del /f /s /q "android\.gradle\*.lock" 2>nul
del /f /s /q "android\*.lock" 2>nul
del /f /s /q "%USERPROFILE%\.gradle\caches\*.lock" 2>nul

echo.
echo ========================================
echo ALL GRADLE PROCESSES STOPPED!
echo ========================================
echo.
echo Next steps:
echo 1. Close Android Studio completely
echo 2. Wait 10 seconds
echo 3. Reopen Android Studio
echo 4. Let Gradle sync (should work now)
echo.
echo If sync is still stuck, run: nuclear-gradle-reset.bat
echo.
pause
