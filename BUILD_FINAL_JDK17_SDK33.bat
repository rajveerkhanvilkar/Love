@echo off
echo ========================================
echo FINAL BUILD - JDK 17 + SDK 33
echo ========================================
echo.

echo [1/5] Setting JDK 17...
set JAVA_HOME=C:\Program Files\Eclipse Adoptium\jdk-17.0.17.10-hotspot
set PATH=%JAVA_HOME%\bin;%PATH%

echo Verifying JDK 17...
java -version

echo.
echo [2/5] Updating build.gradle to SDK 33...
cd /d "%~dp0android\app"
powershell -Command "(Get-Content 'build.gradle') -replace 'compileSdk.*32', 'compileSdk 33' -replace 'targetSdk.*32', 'targetSdk 33' -replace 'compileSdk 32', 'compileSdk 33' -replace 'targetSdk 32', 'targetSdk 33' | Set-Content 'build.gradle'"

echo.
echo [3/5] Cleaning caches...
cd /d "%~dp0"
rmdir /s /q "%USERPROFILE%\.gradle\caches\transforms-3" 2>nul
rmdir /s /q "android\.gradle" 2>nul
rmdir /s /q "android\build" 2>nul

echo.
echo [4/5] Building APK with JDK 17 + SDK 33...
cd android
call gradlew clean assembleDebug --no-daemon --stacktrace

echo.
echo [5/5] Checking for APK...
if exist "app\build\outputs\apk\debug\app-debug.apk" (
    echo.
    echo ========================================
    echo SUCCESS! APK BUILT!
    echo ========================================
    echo.
    echo JDK: 17 ✅
    echo SDK: 33 ✅
    echo.
    echo APK Location:
    echo %~dp0android\app\build\outputs\apk\debug\app-debug.apk
    echo.
    echo COPY THIS TO BOTH PHONES AND INSTALL!
    echo.
    echo YOU DID IT! 🎉
    echo.
) else (
    echo.
    echo ========================================
    echo BUILD FAILED
    echo ========================================
    echo.
    echo Check errors above.
    echo.
)

pause
