# 💕 Rajveer & Swarali - Love Diary Application

A beautiful, full-stack couples diary application with authentication, database storage, and real-time synchronization between partners.

## 🌟 Features

- ✅ **User Authentication** - Login/Register with email and password
- ✅ **Partner Linking** - Connect with your partner to share memories
- ✅ **Memory Diary** - Upload photos & videos (up to 20 per post)
- ✅ **Timeline** - Add and view relationship milestones
- ✅ **Couple Activities** - Track fun activities together
- ✅ **Bucket List** - Dream together about future goals
- ✅ **Love Letters** - Write heartfelt messages
- ✅ **Mood Tracker** - Track daily moods
- ✅ **Database Storage** - All data saved in MongoDB
- ✅ **Cross-Device Sync** - Access from any device
- ✅ **Delete Functionality** - Remove posts and timeline events
- ✅ **Beautiful Animations** - Floating hearts, sparkles, and more

## 📋 Prerequisites

Before you begin, ensure you have installed:
- **Node.js** (v14 or higher) - [Download here](https://nodejs.org/)
- **MongoDB** - Either:
  - Local MongoDB - [Download here](https://www.mongodb.com/try/download/community)
  - OR MongoDB Atlas (Free cloud database) - [Sign up here](https://www.mongodb.com/cloud/atlas/register)

## 🚀 Installation & Setup

### Step 1: Install Dependencies

Open terminal in the project folder and run:

```bash
npm install
```

This will install all required packages.

### Step 2: Configure Database

#### Option A: Using MongoDB Atlas (Recommended for Online Access)

1. Go to [MongoDB Atlas](https://www.mongodb.com/cloud/atlas/register)
2. Create a free account
3. Create a new cluster (free tier)
4. Click "Connect" → "Connect your application"
5. Copy the connection string
6. Open `.env` file and replace the `MONGODB_URI` with your connection string:

```env
MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/couples-diary
```

#### Option B: Using Local MongoDB

1. Install MongoDB locally
2. Start MongoDB service
3. Keep the default `.env` setting:

```env
MONGODB_URI=mongodb://localhost:27017/couples-diary
```

### Step 3: Update Environment Variables

Open `.env` file and update:

```env
# MongoDB Connection
MONGODB_URI=your-mongodb-connection-string

# Change these to random secure strings
JWT_SECRET=your-random-secret-key-here-make-it-long-and-secure
SESSION_SECRET=another-random-secret-key-here

# Server Port
PORT=3000
```

### Step 4: Start the Server

```bash
npm start
```

You should see:
```
✅ Connected to MongoDB
🚀 Server running on http://localhost:3000
💕 Couples Diary Application Ready!
```

### Step 5: Access the Application

Open your browser and go to:
```
http://localhost:3000
```

## 👥 How to Use

### First Time Setup

1. **Register Account**:
   - Click "Register" tab
   - Enter your name, email, and password
   - Leave "Partner's Email" blank for now
   - Click "Create Account"

2. **Partner Registration**:
   - Your partner should also register
   - When registering, they should enter YOUR email in "Partner's Email" field
   - This will link your accounts together

3. **Start Creating Memories**:
   - Both of you can now see each other's posts
   - All memories, timeline events, and activities are shared

### Using the Application

- **Memory Diary**: Upload photos/videos with captions
- **Timeline**: Add important dates and milestones
- **Activities**: Mark activities as complete
- **Bucket List**: Add dreams and goals
- **Love Letters**: Write romantic messages
- **Mood Tracker**: Log daily moods

## 🌐 Making it Online (Deployment)

### Option 1: Deploy to Heroku (Free)

1. Install Heroku CLI: https://devcenter.heroku.com/articles/heroku-cli
2. Login to Heroku:
   ```bash
   heroku login
   ```
3. Create new app:
   ```bash
   heroku create your-app-name
   ```
4. Set environment variables:
   ```bash
   heroku config:set MONGODB_URI=your-mongodb-atlas-uri
   heroku config:set JWT_SECRET=your-secret-key
   heroku config:set SESSION_SECRET=your-session-secret
   ```
5. Deploy:
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   git push heroku master
   ```
6. Open app:
   ```bash
   heroku open
   ```

### Option 2: Deploy to Render (Free)

1. Go to [Render.com](https://render.com/)
2. Sign up and create new "Web Service"
3. Connect your GitHub repository
4. Set environment variables in Render dashboard
5. Deploy automatically

### Option 3: Deploy to Railway (Free)

1. Go to [Railway.app](https://railway.app/)
2. Sign up with GitHub
3. Create new project from GitHub repo
4. Add MongoDB plugin
5. Set environment variables
6. Deploy automatically

## 📱 Mobile App (Future Enhancement)

To convert this to a mobile app, you can:

1. **Use Capacitor** (Recommended):
   ```bash
   npm install @capacitor/core @capacitor/cli
   npx cap init
   npx cap add android
   npx cap add ios
   ```

2. **Use React Native** - Rebuild with React Native

3. **Use Flutter** - Rebuild with Flutter

## 🔒 Security Notes

- Change `JWT_SECRET` and `SESSION_SECRET` to random secure strings
- Never commit `.env` file to version control
- Use HTTPS in production
- Enable MongoDB authentication
- Set secure cookie options in production

## 🐛 Troubleshooting

### "Cannot connect to MongoDB"
- Check if MongoDB is running
- Verify connection string in `.env`
- Check network connection

### "Port 3000 already in use"
- Change PORT in `.env` to different number (e.g., 3001)
- Or kill process using port 3000

### "Module not found"
- Run `npm install` again
- Delete `node_modules` folder and run `npm install`

### "Authentication failed"
- Clear browser cookies and localStorage
- Try registering new account

## 📞 Support

For issues or questions:
1. Check the troubleshooting section
2. Review the code comments
3. Check MongoDB connection
4. Ensure all dependencies are installed

## 🎨 Customization

You can customize:
- Colors in CSS files
- Animations and effects
- Add more features
- Change database schema
- Add email notifications
- Add file upload to cloud storage

## 📄 License

This project is for personal use by Rajveer & Swarali.

---

Made with 💕 by Rajveer & Swarali
