@echo off
echo FINAL SIMPLE BUILD
echo.

cd android

set JAVA_HOME=C:\Program Files\Eclipse Adoptium\jdk-17.0.17.10-hotspot
set PATH=%JAVA_HOME%\bin;%PATH%

call gradlew clean assembleDebug --no-daemon

if exist "app\build\outputs\apk\debug\app-debug.apk" (
    echo.
    echo SUCCESS! APK at: app\build\outputs\apk\debug\app-debug.apk
) else (
    echo.
    echo FAILED
)

pause
