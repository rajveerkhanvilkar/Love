@echo off
echo ========================================
echo ABSOLUTE FINAL BUILD
echo JDK 17 + SDK 33 + gradle.properties
echo ========================================
echo.

echo [1/4] Cleaning ALL caches...
rmdir /s /q "%USERPROFILE%\.gradle\caches" 2>nul
rmdir /s /q "android\.gradle" 2>nul
rmdir /s /q "android\build" 2>nul

echo.
echo [2/4] Verifying gradle.properties has JDK 17...
type android\gradle.properties

echo.
echo [3/4] Building APK...
cd android
set JAVA_HOME=C:\Program Files\Eclipse Adoptium\jdk-17.0.17.10-hotspot
set PATH=%JAVA_HOME%\bin;%PATH%
call gradlew clean assembleDebug --no-daemon --stacktrace

echo.
echo [4/4] Checking for APK...
if exist "app\build\outputs\apk\debug\app-debug.apk" (
    echo.
    echo ========================================
    echo 🎉 SUCCESS! APK BUILT! 🎉
    echo ========================================
    echo.
    echo APK: %~dp0android\app\build\outputs\apk\debug\app-debug.apk
    echo.
    echo INSTALL ON BOTH PHONES NOW!
    echo.
) else (
    echo.
    echo BUILD FAILED - Check errors above
    echo.
)

pause
