@echo off
echo STOPPING GRADLE AND BUILDING FRESH
echo.

echo [1/4] Stopping all Gradle processes...
taskkill /F /IM java.exe 2>nul
timeout /t 2 /nobreak >nul

echo.
echo [2/4] Deleting Gradle cache...
rmdir /s /q "android\.gradle" 2>nul
rmdir /s /q "%USERPROFILE%\.gradle\caches\8.5" 2>nul

echo.
echo [3/4] Verifying gradle.properties...
type android\gradle.properties

echo.
echo [4/4] Building APK...
cd android
set JAVA_HOME=C:\Program Files\Eclipse Adoptium\jdk-17.0.17.10-hotspot
set PATH=%JAVA_HOME%\bin;%PATH%
call gradlew clean assembleDebug --no-daemon

if exist "app\build\outputs\apk\debug\app-debug.apk" (
    echo.
    echo ========================================
    echo SUCCESS! APK BUILT!
    echo ========================================
    echo.
    echo Location: app\build\outputs\apk\debug\app-debug.apk
    echo.
) else (
    echo.
    echo BUILD FAILED
)

pause
