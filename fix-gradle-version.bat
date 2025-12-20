@echo off
echo ========================================
echo FIXING GRADLE VERSION FOR JAVA 21
echo ========================================
echo.

echo [1/5] Closing Android Studio (if open)...
echo IMPORTANT: Please close Android Studio manually if it's open!
echo.
pause

echo.
echo [2/5] Stopping all Gradle processes...
taskkill /F /IM java.exe 2>nul
timeout /t 3 /nobreak >nul

echo.
echo [3/5] Deleting locked Gradle wrapper files...
rmdir /s /q "%USERPROFILE%\.gradle\wrapper\dists\gradle-8.4-all" 2>nul
rmdir /s /q "%USERPROFILE%\.gradle\daemon" 2>nul

echo.
echo [4/5] Updating gradle-wrapper.properties to version 8.5...
cd /d "%~dp0\android\gradle\wrapper"

(
echo distributionBase=GRADLE_USER_HOME
echo distributionPath=wrapper/dists
echo distributionUrl=https\://services.gradle.org/distributions/gradle-8.5-all.zip
echo networkTimeout=10000
echo validateDistributionUrl=true
echo zipStoreBase=GRADLE_USER_HOME
echo zipStorePath=wrapper/dists
) > gradle-wrapper.properties

echo.
echo [5/5] Gradle wrapper properties updated!
echo.
echo ========================================
echo GRADLE VERSION UPDATED TO 8.5!
echo ========================================
echo.
echo The gradle-wrapper.properties file has been updated.
echo Gradle 8.5 is compatible with Java 21.
echo.
echo Next steps:
echo 1. Open Android Studio
echo 2. Open your project
echo 3. Android Studio will automatically download Gradle 8.5
echo 4. Click "Sync Now" when prompted
echo 5. Wait for sync to complete (5-10 minutes)
echo 6. Build APK: Build -^> Build Bundle(s) / APK(s) -^> Build APK(s)
echo.
pause
