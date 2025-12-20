# 🚀 COMPLETE ANDROID APP SETUP - STEP BY STEP

## For Rajveer & Swarali - Android App with Push Notifications

---

## 📋 **Prerequisites**

Before starting, make sure you have:
- [ ] Node.js installed
- [ ] Android Studio installed ([Download](https://developer.android.com/studio))
- [ ] Java JDK 11 or higher
- [ ] Your backend deployed online (see DEPLOYMENT.md)

---

## 🎯 **PART 1: Convert to Android App (30 minutes)**

### **Step 1: Install Capacitor**

Open terminal in your project folder:

```bash
npm install @capacitor/core @capacitor/cli
npm install @capacitor/android
npm install @capacitor/push-notifications
```

### **Step 2: Initialize Capacitor**

```bash
npx cap init
```

When prompted:
- App name: `Love Diary`
- App ID: `com.rajveer.swarali.diary`
- Web directory: `.` (just press Enter)

### **Step 3: Add Android Platform**

```bash
npx cap add android
```

This creates an `android` folder with your Android project.

### **Step 4: Update capacitor.config.json**

The file is already created. Update the server URL:

```json
{
  "appId": "com.rajveer.swarali.diary",
  "appName": "Love Diary",
  "webDir": ".",
  "server": {
    "url": "https://your-app.onrender.com",
    "androidScheme": "https"
  }
}
```

Replace `your-app.onrender.com` with your deployed backend URL.

### **Step 5: Copy Files to Android**

```bash
npx cap copy android
npx cap sync android
```

### **Step 6: Open in Android Studio**

```bash
npx cap open android
```

Android Studio will open. Wait for Gradle to finish building (5-10 minutes first time).

### **Step 7: Run on Device/Emulator**

1. Connect your Android phone via USB (enable USB debugging)
   OR
   Create an emulator in Android Studio

2. Click the green "Run" button (▶️)

3. Your app will install and open!

---

## 🔔 **PART 2: Setup Push Notifications (45 minutes)**

### **Step 1: Create Firebase Project**

1. Go to https://console.firebase.google.com
2. Click "Add project"
3. Name: `Love Diary`
4. Disable Google Analytics (optional)
5. Click "Create project"

### **Step 2: Add Android App to Firebase**

1. In Firebase Console, click "Add app" → Android icon
2. Package name: `com.rajveer.swarali.diary`
3. App nickname: `Love Diary`
4. Click "Register app"
5. Download `google-services.json`
6. Place it in: `android/app/google-services.json`

### **Step 3: Enable Cloud Messaging**

1. In Firebase Console, go to "Cloud Messaging"
2. Click "Send your first message" (just to activate it)
3. Go to "Project Settings" → "Cloud Messaging"
4. Copy the "Server key" (you'll need this)

### **Step 4: Download Service Account Key**

1. In Firebase Console → Project Settings → Service Accounts
2. Click "Generate new private key"
3. Save as `firebase-service-account.json` in your project root
4. **IMPORTANT**: Add to `.gitignore` (never commit this file!)

### **Step 5: Update Backend for Notifications**

Add to `package.json` dependencies:
```json
"firebase-admin": "^12.0.0"
```

Run:
```bash
npm install
```

### **Step 6: Update server.js**

Add at the top of `server.js`:

```javascript
const { registerDeviceToken, notifyPartner, NotificationTemplates } = require('./notifications');
const admin = require('firebase-admin');
const serviceAccount = require('./firebase-service-account.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});
```

Add route for device registration:

```javascript
// Register device token
app.post('/api/notifications/register', authenticate, async (req, res) => {
    try {
        const { token } = req.body;
        registerDeviceToken(req.userId, token);
        res.json({ success: true });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});
```

### **Step 7: Add Notifications to Actions**

Update the create memory endpoint in `server.js`:

```javascript
// Create memory (with notification)
app.post('/api/memories', authenticate, async (req, res) => {
    try {
        const memory = new Memory({
            userId: req.userId,
            coupleId: req.coupleId,
            ...req.body
        });
        await memory.save();
        
        // Send notification to partner
        if (req.user.partnerId) {
            const notification = NotificationTemplates.newMemory(req.user.name);
            notification.id = memory._id.toString();
            await notifyPartner(req.userId, req.user.partnerId, notification);
        }
        
        res.json(memory);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});
```

Do the same for timeline, love letters, etc.

### **Step 8: Add Push Notification Script to HTML**

Add to each HTML page (before closing `</body>`):

```html
<script src="https://unpkg.com/@capacitor/core@latest/dist/capacitor.js"></script>
<script src="push-notifications.js"></script>
```

### **Step 9: Rebuild and Test**

```bash
npx cap copy android
npx cap sync android
npx cap open android
```

Run the app and test notifications!

---

## 📦 **PART 3: Build APK for Distribution**

### **For Testing (Debug APK):**

1. In Android Studio: Build → Build Bundle(s) / APK(s) → Build APK(s)
2. APK location: `android/app/build/outputs/apk/debug/app-debug.apk`
3. Share this APK with Swarali for testing

### **For Play Store (Release APK):**

#### **Step 1: Generate Keystore**

```bash
keytool -genkey -v -keystore my-release-key.keystore -alias my-key-alias -keyalg RSA -keysize 2048 -validity 10000
```

Answer the questions and remember the password!

#### **Step 2: Configure Signing**

Create `android/key.properties`:

```properties
storePassword=YOUR_KEYSTORE_PASSWORD
keyPassword=YOUR_KEY_PASSWORD
keyAlias=my-key-alias
storeFile=../my-release-key.keystore
```

#### **Step 3: Update build.gradle**

In `android/app/build.gradle`, add before `android {`:

```gradle
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}
```

Inside `android { ... }`, add:

```gradle
signingConfigs {
    release {
        keyAlias keystoreProperties['keyAlias']
        keyPassword keystoreProperties['keyPassword']
        storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
        storePassword keystoreProperties['storePassword']
    }
}
buildTypes {
    release {
        signingConfig signingConfigs.release
        minifyEnabled false
        proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
    }
}
```

#### **Step 4: Build Release APK**

In Android Studio:
1. Build → Generate Signed Bundle / APK
2. Select "APK"
3. Choose your keystore file
4. Enter passwords
5. Select "release" build variant
6. Click "Finish"

APK will be in: `android/app/build/outputs/apk/release/app-release.apk`

---

## 🎯 **PART 4: Real-time Sync**

Both partners will see updates because:

1. **Database Sync**: MongoDB stores all data
2. **Push Notifications**: Partner gets notified instantly
3. **Auto-refresh**: App checks for updates when opened

To add auto-refresh, add to each page:

```javascript
// Auto-refresh data every 30 seconds
setInterval(async () => {
    // Reload data from API
    await loadData();
}, 30000);
```

---

## 📱 **Testing Notifications**

### **Test Scenario:**

1. **Rajveer's Phone**:
   - Login to app
   - Upload a memory

2. **Swarali's Phone**:
   - Should receive push notification
   - Tap notification → Opens memories page
   - Sees Rajveer's new memory

---

## 🚀 **Publishing to Play Store (Optional)**

1. Create Google Play Developer account ($25 one-time fee)
2. Create new app listing
3. Upload your release APK
4. Fill in app details, screenshots, description
5. Submit for review
6. Wait 1-3 days for approval

---

## ✅ **Checklist**

### **Basic App:**
- [ ] Capacitor installed
- [ ] Android platform added
- [ ] App opens in Android Studio
- [ ] App runs on device/emulator

### **Push Notifications:**
- [ ] Firebase project created
- [ ] google-services.json added
- [ ] Service account key downloaded
- [ ] Backend updated with Firebase
- [ ] Notification routes added
- [ ] Push notification script added to HTML
- [ ] Tested notifications between devices

### **Distribution:**
- [ ] Debug APK built and tested
- [ ] Keystore generated
- [ ] Release APK built
- [ ] APK shared with partner
- [ ] (Optional) Published to Play Store

---

## 🆘 **Troubleshooting**

### **App won't build:**
- Check Java version: `java -version` (should be 11+)
- Update Gradle in Android Studio
- Clean project: Build → Clean Project

### **Notifications not working:**
- Check Firebase configuration
- Verify google-services.json location
- Check device has internet connection
- Ensure notification permissions granted

### **App shows blank screen:**
- Check server URL in capacitor.config.json
- Ensure backend is deployed and accessible
- Check browser console in Android Studio

---

## 📞 **Need Help?**

Common issues and solutions in ANDROID_DEPLOYMENT.md

---

**You're ready to create your Android app!** 🎉

Start with Part 1, test it, then move to Part 2 for notifications.
