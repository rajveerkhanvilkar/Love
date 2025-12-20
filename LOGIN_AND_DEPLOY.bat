@echo off
echo ========================================
echo LOGIN & DEPLOY TO VERCEL
echo ========================================
echo.
echo [1/2] Logging in to Vercel...
echo Please follow the instructions to log in (it will open your browser).
echo.

call npx vercel login

echo.
echo [2/2] Deploying App...
echo If asked "Set up and deploy?", type 'y'.
echo.

if exist server.js move server.js server.backup.js >nul
call npx vercel --prod

echo.
echo ========================================
echo DEPLOYMENT COMPLETE!
echo ========================================
pause
