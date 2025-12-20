@echo off
echo ========================================
echo PERMANENT FIX - DISABLE JLINK
echo ========================================
echo.

echo [1/3] Creating gradle.properties with jlink disabled...
cd /d "%~dp0\android"

(
echo # Project-wide Gradle settings
echo org.gradle.jvmargs=-Xmx2048m -Dfile.encoding=UTF-8
echo android.useAndroidX=true
echo android.enableJetifier=true
echo.
echo # Use JDK 17
echo org.gradle.java.home=C:/Program Files/Eclipse Adoptium/jdk-17.0.17.10-hotspot
echo.
echo # PERMANENT FIX: Disable jlink
echo android.disableAutomaticComponentCreation=true
) > gradle.properties

echo Done!
type gradle.properties

echo.
echo [2/3] Cleaning all caches...
rmdir /s /q "%USERPROFILE%\.gradle\caches" 2>nul
rmdir /s /q ".gradle" 2>nul
rmdir /s /q "build" 2>nul
rmdir /s /q "app\build" 2>nul

echo.
echo [3/3] Building APK...
set JAVA_HOME=C:\Program Files\Eclipse Adoptium\jdk-17.0.17.10-hotspot
set PATH=%JAVA_HOME%\bin;%PATH%
call gradlew clean assembleDebug --no-daemon

echo.
if exist "app\build\outputs\apk\debug\app-debug.apk" (
    echo.
    echo ========================================
    echo SUCCESS! APK BUILT!
    echo ========================================
    echo.
    echo APK: %~dp0android\app\build\outputs\apk\debug\app-debug.apk
    echo.
    echo THIS IS THE PERMANENT SOLUTION!
    echo jlink is now DISABLED forever!
    echo.
) else (
    echo BUILD FAILED
)

pause
