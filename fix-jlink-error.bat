@echo off
echo ========================================
echo FIXING JLINK ERROR - DELETING GRADLE CACHE
echo ========================================
echo.

echo This will delete the corrupted Gradle cache causing the jlink error.
echo.

echo Deleting Gradle transforms cache...
rmdir /s /q "%USERPROFILE%\.gradle\caches\transforms-3" 2>nul
echo ✅ Gradle cache deleted!
echo.

echo Deleting Android project cache...
cd "%~dp0android"
rmdir /s /q .gradle 2>nul
rmdir /s /q build 2>nul
rmdir /s /q app\build 2>nul
echo ✅ Project cache deleted!
echo.

echo ========================================
echo ✅ CACHE CLEARED!
echo ========================================
echo.
echo NOW IN ANDROID STUDIO:
echo 1. File ^> Invalidate Caches / Restart
echo 2. Choose "Invalidate and Restart"
echo 3. Wait for restart and Gradle sync
echo 4. Build ^> Build Bundle(s) / APK(s) ^> Build APK(s)
echo.
echo The jlink error should be GONE!
echo.
pause
