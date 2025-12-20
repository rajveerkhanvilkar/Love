@echo off
echo ========================================
echo NUCLEAR GRADLE RESET
echo ========================================
echo.
echo This will completely reset Gradle to a clean state.
echo.
pause

echo.
echo [1/6] Stopping all Gradle daemons...
cd /d "%~dp0"
cd android
call gradlew --stop
timeout /t 2 /nobreak >nul

echo.
echo [2/6] Deleting GLOBAL Gradle caches...
rmdir /s /q "%USERPROFILE%\.gradle\caches" 2>nul
rmdir /s /q "%USERPROFILE%\.gradle\daemon" 2>nul
rmdir /s /q "%USERPROFILE%\.gradle\wrapper" 2>nul

echo.
echo [3/6] Deleting PROJECT Gradle caches...
rmdir /s /q ".gradle" 2>nul
rmdir /s /q "build" 2>nul
rmdir /s /q "app\.gradle" 2>nul
rmdir /s /q "app\build" 2>nul

echo.
echo [4/6] Deleting Android Studio caches...
rmdir /s /q "%USERPROFILE%\.android\build-cache" 2>nul

echo.
echo [5/6] Deleting Kotlin compiler cache...
rmdir /s /q "%USERPROFILE%\.kotlin" 2>nul

echo.
echo [6/6] Cleaning up temporary files...
del /f /s /q *.lock 2>nul
del /f /s /q *.bin 2>nul

echo.
echo ========================================
echo CLEANUP COMPLETE!
echo ========================================
echo.
echo Next steps:
echo 1. Close Android Studio completely
echo 2. Wait 10 seconds
echo 3. Reopen Android Studio
echo 4. Wait for Gradle sync to complete (may take 5-10 minutes)
echo 5. Build APK: Build -^> Build Bundle(s) / APK(s) -^> Build APK(s)
echo.
echo ========================================
pause
