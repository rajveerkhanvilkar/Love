@echo off
echo ========================================
echo DEPLOYING TO VERCEL NOW
echo ========================================
echo.

echo [1/3] Configuring for Static + API deployment...
if exist server.js move server.js server.backup.js >nul

echo [2/3] Updating Vercel config...
(
echo {
echo   "version": 2,
echo   "rewrites": [
echo     { "source": "/api/(.*)", "destination": "/api/index.js" }
echo   ]
echo }
) > vercel.json

echo.
echo [3/3] Deploying...
echo.
echo NOTE: If asked to log in or link project, please type 'y' or follow instructions!
echo.

call npx vercel --prod

echo.
echo ========================================
echo IF DEPLOYMENT SUCCESSFUL:
echo Your app is now live at the URL shown above!
echo ========================================
echo.
pause
