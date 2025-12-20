@echo off
echo ========================================
echo UPGRADING GRADLE TO 8.5 FOR JAVA 21
echo ========================================
echo.

cd /d "%~dp0\android"

echo [1/2] Updating Gradle wrapper to version 8.5...
echo.

call gradlew wrapper --gradle-version=8.5 --distribution-type=bin

echo.
echo [2/2] Verifying Gradle version...
echo.

call gradlew --version

echo.
echo ========================================
echo GRADLE UPGRADE COMPLETE!
echo ========================================
echo.
echo Gradle has been upgraded to version 8.5
echo This version is compatible with Java 21
echo.
echo Next steps:
echo 1. Go back to Android Studio
echo 2. Click "Sync Now" to sync the project
echo 3. Wait for Gradle sync to complete (5-10 minutes)
echo 4. Build APK: Build -^> Build Bundle(s) / APK(s) -^> Build APK(s)
echo.
pause
