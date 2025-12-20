@echo off
echo ========================================
echo BUILDING APK WITH JDK 17
echo ========================================
echo.

echo [1/4] Setting JDK 17 path...
set JAVA_HOME=C:\Program Files\Eclipse Adoptium\jdk-17.0.17.10-hotspot
set PATH=%JAVA_HOME%\bin;%PATH%

echo Verifying JDK version...
java -version

echo.
echo [2/4] Cleaning Gradle caches...
rmdir /s /q "%USERPROFILE%\.gradle\caches\transforms-3" 2>nul
rmdir /s /q "android\.gradle" 2>nul
rmdir /s /q "android\build" 2>nul

echo.
echo [3/4] Building APK with JDK 17...
cd android
call gradlew clean assembleDebug --no-daemon --stacktrace

echo.
echo [4/4] Checking for APK...
if exist "app\build\outputs\apk\debug\app-debug.apk" (
    echo.
    echo ========================================
    echo SUCCESS! APK BUILT WITH JDK 17!
    echo ========================================
    echo.
    echo APK Location:
    echo %~dp0android\app\build\outputs\apk\debug\app-debug.apk
    echo.
    echo Copy this to both phones and install!
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
