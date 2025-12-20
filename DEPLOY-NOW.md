# 🚀 SIMPLE DEPLOYMENT - NO GIT NEEDED!

## Use Vercel (Easiest Method)

### Step 1: Install Vercel CLI

```bash
npm install -g vercel
```

### Step 2: Login to Vercel

```bash
vercel login
```

### Step 3: Deploy

```bash
vercel
```

Follow prompts:
- Set up and deploy? **Y**
- Which scope? (your account)
- Link to existing project? **N**
- Project name? **couples-diary**
- Directory? **./  (just press Enter)**
- Override settings? **N**

### Step 4: Set Environment Variables

After deployment, run:

```bash
vercel env add MONGODB_URI
```

Paste: `mongodb+srv://rajveerkhanvilkarbhosle70_db_user:791FHBwBnVR1opdx@cluster0.gr3i0ez.mongodb.net/couples-diary?retryWrites=true&w=majority`

```bash
vercel env add JWT_SECRET
```
Enter: `rajveer-swarali-secret-2025`

```bash
vercel env add SESSION_SECRET
```
Enter: `rajveer-swarali-session-2025`

### Step 5: Redeploy

```bash
vercel --prod
```

You'll get a URL like: `https://couples-diary.vercel.app`

---

## ✅ **After Deployment:**

Update these files with your new URL:

**api.js:**
```javascript
const API_URL = 'https://couples-diary.vercel.app/api';
```

**capacitor.config.json:**
```json
"server": {
  "url": "https://couples-diary.vercel.app"
}
```

**index.html (line 299):**
```javascript
const API_URL = 'https://couples-diary.vercel.app/api';
```

Then rebuild APK!
