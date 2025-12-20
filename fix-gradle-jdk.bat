@echo off
echo ========================================
echo FIXING GRADLE JDK CONFIGURATION
echo ========================================
echo.

cd /d "%~dp0\android"

echo Creating gradle.properties with Embedded JDK...
echo.

(
echo # Project-wide Gradle settings
echo org.gradle.jvmargs=-Xmx2048m -Dfile.encoding=UTF-8
echo android.useAndroidX=true
echo android.enableJetifier=true
echo.
echo # Use Embedded JDK
echo org.gradle.java.home=C:\\Program Files\\Android\\Android Studio\\jbr
) > gradle.properties

echo.
echo ========================================
echo GRADLE JDK CONFIGURATION FIXED!
echo ========================================
echo.
echo The gradle.properties file has been updated to use:
echo C:\Program Files\Android\Android Studio\jbr
echo.
echo Next steps:
echo 1. Go back to Android Studio
echo 2. Click "Use Embedded JDK" in the error dialog
echo 3. OR click "Sync Now" to sync Gradle
echo.
pause
