# 🚀 FASTEST DEPLOYMENT - 5 MINUTES!

## Method: Upload ZIP to Vercel Website

### Step 1: Create ZIP File (1 min)

1. Go to: `C:\Users\HP\Desktop\couples website`
2. Select these files:
   - server.js
   - package.json
   - vercel.json
   - index.html
   - home.html
   - memories.html
   - timeline.html
   - activities.html
   - bucket-list.html
   - love-letters.html
   - mood-tracker.html
   - api.js
   - www folder (entire folder)

3. Right-click → Send to → Compressed (zipped) folder
4. Name it: `couples-diary.zip`

### Step 2: Upload to Vercel (2 min)

1. Go to: https://vercel.com/new
2. Click "Continue with GitHub" (you're already logged in)
3. Click "Import Project"
4. Drag and drop `couples-diary.zip`
5. Click "Deploy"
6. Wait 2 minutes
7. You'll get a URL like: `https://couples-diary-xxx.vercel.app`

### Step 3: Update Your Code (1 min)

Replace the URL in these files:

**api.js** (line 2):
```javascript
const API_URL = 'https://YOUR-URL-HERE.vercel.app/api';
```

**capacitor.config.json**:
```json
"server": {
  "url": "https://YOUR-URL-HERE.vercel.app"
}
```

### Step 4: Rebuild APK (1 min)

```bash
npx cap sync android
npx cap open android
```

Build → Build APK

DONE! 🎉

---

## OR EVEN FASTER - Use Railway!

1. Go to: https://railway.app/new
2. Click "Deploy from GitHub repo"
3. Connect GitHub
4. Upload your code
5. Add environment variables
6. Deploy!

Same process but might be easier!
