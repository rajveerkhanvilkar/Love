# 🌐 DEPLOYMENT GUIDE - Make Your App Online

## 🎯 Goal
Make your couples diary accessible from anywhere in the world, on any device!

---

## ✅ EASIEST METHOD: Render.com (Recommended)

### Why Render?
- ✅ Completely FREE
- ✅ Automatic HTTPS
- ✅ Easy setup (10 minutes)
- ✅ Permanent URL
- ✅ Auto-deploys on code changes

### Step-by-Step:

#### 1. Prepare Your Code

First, create a `Procfile` (no extension) in your project folder:
```
web: node server.js
```

#### 2. Push to GitHub

```bash
# Initialize git (if not already done)
git init

# Add all files
git add .

# Commit
git commit -m "Initial commit"

# Create repository on GitHub.com, then:
git remote add origin https://github.com/YOUR-USERNAME/couples-diary.git
git push -u origin main
```

#### 3. Deploy on Render

1. Go to https://render.com and sign up (free)
2. Click "New +" → "Web Service"
3. Connect your GitHub account
4. Select your repository
5. Configure:
   - **Name**: couples-diary
   - **Environment**: Node
   - **Build Command**: `npm install`
   - **Start Command**: `node server.js`
6. Click "Advanced" → Add Environment Variables:
   ```
   MONGODB_URI = your-mongodb-atlas-connection-string
   JWT_SECRET = your-random-secret-key
   SESSION_SECRET = your-random-session-secret
   PORT = 3000
   ```
7. Click "Create Web Service"
8. Wait 5-10 minutes for deployment
9. Your app will be live at: `https://couples-diary.onrender.com`

#### 4. Update Frontend URLs

In all your HTML files, update the API_URL:
```javascript
const API_URL = 'https://couples-diary.onrender.com/api';
```

---

## 🚀 ALTERNATIVE: Railway.app

### Step-by-Step:

1. Go to https://railway.app
2. Sign in with GitHub
3. Click "New Project" → "Deploy from GitHub repo"
4. Select your repository
5. Add MongoDB plugin:
   - Click "+ New"
   - Select "Database" → "MongoDB"
   - Copy the connection string
6. Add environment variables:
   - Click on your service
   - Go to "Variables" tab
   - Add:
     ```
     MONGODB_URI = (from MongoDB plugin)
     JWT_SECRET = your-secret
     SESSION_SECRET = your-secret
     ```
7. Deploy automatically!
8. Get your URL from "Settings" → "Domains"

---

## ⚡ QUICK TESTING: Ngrok (Temporary)

### For immediate testing (URL changes each time):

1. Download ngrok: https://ngrok.com/download
2. Extract and run:
   ```bash
   # Start your server first
   npm start
   
   # In new terminal:
   ngrok http 3000
   ```
3. Copy the https URL (e.g., `https://abc123.ngrok.io`)
4. Share with your partner!
5. **Note**: URL expires when you close ngrok

---

## 📱 MOBILE APP CONVERSION

### Option 1: PWA (Progressive Web App)

Add this to your HTML files in `<head>`:

```html
<link rel="manifest" href="manifest.json">
<meta name="theme-color" content="#ff6b9d">
<meta name="apple-mobile-web-app-capable" content="yes">
```

Create `manifest.json`:
```json
{
  "name": "Love Diary",
  "short_name": "Love Diary",
  "start_url": "/",
  "display": "standalone",
  "background_color": "#ffeef8",
  "theme_color": "#ff6b9d",
  "icons": [
    {
      "src": "icon-192.png",
      "sizes": "192x192",
      "type": "image/png"
    },
    {
      "src": "icon-512.png",
      "sizes": "512x512",
      "type": "image/png"
    }
  ]
}
```

Users can then "Add to Home Screen" on mobile!

### Option 2: Capacitor (Real Native App)

```bash
npm install @capacitor/core @capacitor/cli
npx cap init "Love Diary" "com.rajveer.swarali.diary"
npx cap add android
npx cap add ios
npx cap open android  # Opens Android Studio
```

---

## 🔐 SECURITY CHECKLIST

Before going online:

- [ ] Change `JWT_SECRET` to random 32+ character string
- [ ] Change `SESSION_SECRET` to random 32+ character string
- [ ] Use MongoDB Atlas (not local MongoDB)
- [ ] Enable MongoDB IP whitelist (allow all: 0.0.0.0/0)
- [ ] Use strong passwords for user accounts
- [ ] Enable HTTPS (automatic on Render/Railway)

---

## 💰 COST COMPARISON

| Platform | Cost | Features |
|----------|------|----------|
| **Render** | FREE | 750 hours/month, auto-sleep after 15min idle |
| **Railway** | FREE | $5 credit/month, then pay-as-you-go |
| **Heroku** | FREE tier removed | Now paid only |
| **Vercel** | FREE | Good for frontend, need separate backend |
| **Ngrok** | FREE | Temporary URLs, great for testing |

**Recommendation**: Start with Render (free forever)

---

## 🌍 CUSTOM DOMAIN (Optional)

### Add your own domain (e.g., rajveer-swarali.com):

1. Buy domain from:
   - Namecheap.com (~$10/year)
   - GoDaddy.com
   - Google Domains

2. On Render:
   - Go to your service
   - Click "Settings" → "Custom Domain"
   - Add your domain
   - Update DNS records as instructed

3. Wait 24-48 hours for DNS propagation

---

## 📊 MONITORING

### Check if your app is running:

1. **Render Dashboard**:
   - View logs
   - See deployment status
   - Monitor uptime

2. **UptimeRobot** (free):
   - https://uptimerobot.com
   - Get alerts if app goes down
   - Free monitoring

---

## 🆘 TROUBLESHOOTING DEPLOYMENT

### "Application Error"
- Check logs in Render dashboard
- Verify environment variables are set
- Check MongoDB connection string

### "Cannot connect to database"
- Verify MongoDB Atlas IP whitelist (0.0.0.0/0)
- Check connection string format
- Ensure database user has read/write permissions

### "502 Bad Gateway"
- App is starting (wait 1-2 minutes)
- Check if PORT is set correctly
- View logs for errors

### App sleeps after inactivity (Render free tier)
- First request after sleep takes 30-60 seconds
- Upgrade to paid plan for always-on
- Or use cron job to ping every 14 minutes

---

## 📞 SUPPORT

If you face issues:
1. Check deployment logs
2. Verify all environment variables
3. Test MongoDB connection separately
4. Check Render/Railway documentation

---

## 🎉 SUCCESS!

Once deployed:
- ✅ Access from anywhere: `https://your-app.onrender.com`
- ✅ Both partners can login from different devices
- ✅ All data synced in real-time
- ✅ Secure HTTPS connection
- ✅ Professional URL to share

---

Made with 💕 for Rajveer & Swarali
