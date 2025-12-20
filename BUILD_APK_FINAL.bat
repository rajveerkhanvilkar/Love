@echo off
echo ========================================
echo FINAL FIX - BUILD APK NOW
echo ========================================
echo.

echo [1/5] Stopping all processes...
taskkill /F /IM java.exe 2>nul
taskkill /F /IM studio64.exe 2>nul
timeout /t 3 /nobreak >nul

echo.
echo [2/5] Deleting ALL Gradle caches...
rmdir /s /q "%USERPROFILE%\.gradle\caches" 2>nul
rmdir /s /q "%~dp0android\.gradle" 2>nul
rmdir /s /q "%~dp0android\build" 2>nul
rmdir /s /q "%~dp0android\app\build" 2>nul

echo.
echo [3/5] Updating build.gradle to SDK 32...
cd /d "%~dp0android\app"
powershell -Command "(Get-Content 'build.gradle') -replace 'compileSdk.*', 'compileSdk 32' -replace 'targetSdk.*', 'targetSdk 32' | Set-Content 'build.gradle'"

echo.
echo [4/5] Building APK with Gradle...
cd /d "%~dp0android"
call gradlew clean assembleDebug --no-daemon --stacktrace

echo.
echo [5/5] Checking for APK...
if exist "app\build\outputs\apk\debug\app-debug.apk" (
    echo.
    echo ========================================
    echo SUCCESS! APK BUILT!
    echo ========================================
    echo.
    echo APK Location:
    echo %~dp0android\app\build\outputs\apk\debug\app-debug.apk
    echo.
    echo Copy this file to both phones and install it!
    echo.
) else (
    echo.
    echo ========================================
    echo BUILD FAILED
    echo ========================================
    echo.
    echo Check the error messages above.
    echo.
)

pause
