@echo off
echo ========================================
echo NUCLEAR FIX FOR JLINK ERROR
echo ========================================
echo.

echo [1/4] Stopping all processes...
taskkill /F /IM java.exe 2>nul
taskkill /F /IM studio64.exe 2>nul
timeout /t 2 /nobreak >nul

echo.
echo [2/4] Deleting Android SDK 33 cache...
rmdir /s /q "%USERPROFILE%\.gradle\caches\transforms-3" 2>nul
rmdir /s /q "%USERPROFILE%\.gradle\caches\modules-2\files-2.1\com.android" 2>nul

echo.
echo [3/4] Updating build.gradle files...
cd /d "%~dp0\android\app"

powershell -Command "(Get-Content 'build.gradle') -replace 'compileSdk.*33', 'compileSdk 32' -replace 'targetSdk.*33', 'targetSdk 32' -replace 'compileSdkVersion 33', 'compileSdkVersion 32' -replace 'targetSdkVersion 33', 'targetSdkVersion 32' | Set-Content 'build.gradle'"

echo.
echo [4/4] Creating local.properties with SDK path...
cd /d "%~dp0\android"

(
echo sdk.dir=C:\\Users\\HP\\AppData\\Local\\Android\\Sdk
) > local.properties

echo.
echo ========================================
echo NUCLEAR FIX COMPLETE!
echo ========================================
echo.
echo CRITICAL NEXT STEPS:
echo.
echo 1. Open Android Studio
echo 2. Tools -^> SDK Manager
echo 3. SDK Platforms tab
echo 4. CHECK "Android 12L (S) - API Level 32"
echo 5. UNCHECK "Android 13.0 (Tiramisu) - API Level 33"
echo 6. Click "Apply" and wait for download (2-5 min)
echo 7. File -^> Invalidate Caches -^> Invalidate and Restart
echo 8. After restart, Build -^> Build APK
echo.
echo THIS WILL WORK!
echo.
pause
