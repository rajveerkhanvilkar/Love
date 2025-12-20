@echo off
echo ========================================
echo FIXING JLINK ERROR - DOWNGRADE TO SDK 32
echo ========================================
echo.

cd /d "%~dp0\android\app"

echo Creating backup of build.gradle...
copy build.gradle build.gradle.backup >nul

echo.
echo Updating build.gradle to use Android SDK 32...

powershell -Command "(Get-Content 'build.gradle') -replace 'compileSdk = 33', 'compileSdk = 32' -replace 'compileSdk 33', 'compileSdk 32' -replace 'targetSdk = 33', 'targetSdk = 32' -replace 'targetSdk 33', 'targetSdk 32' | Set-Content 'build.gradle'"

echo.
echo ========================================
echo SDK VERSION UPDATED!
echo ========================================
echo.
echo Changed:
echo   compileSdk: 33 -^> 32
echo   targetSdk: 33 -^> 32
echo.
echo This will fix the jlink.exe error!
echo.
echo Next steps:
echo 1. Go to Android Studio
echo 2. Tools -^> SDK Manager
echo 3. Check "Android 12L (S) - API Level 32"
echo 4. Click "Apply" and wait for download
echo 5. Click "Sync Now" in Android Studio
echo 6. Build APK: Build -^> Build Bundle(s) / APK(s) -^> Build APK(s)
echo.
pause
