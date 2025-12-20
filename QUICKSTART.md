# 🚀 QUICK START GUIDE

## For Rajveer & Swarali

### ⚡ Fastest Way to Get Started

1. **Install MongoDB Atlas (Free Cloud Database)**
   - Go to: https://www.mongodb.com/cloud/atlas/register
   - Sign up (free)
   - Create a cluster (choose FREE tier)
   - Click "Connect" → "Connect your application"
   - Copy the connection string (looks like: `mongodb+srv://username:password@...`)

2. **Update .env File**
   - Open `.env` file in this folder
   - Replace the `MONGODB_URI` line with your connection string
   - Change `JWT_SECRET` and `SESSION_SECRET` to any random text

3. **Start the Server**
   - Double-click `start.bat` file
   - Wait for "Server running" message

4. **Open in Browser**
   - Go to: http://localhost:3000
   - Register both accounts
   - Start creating memories!

---

## 📝 Step-by-Step First Time Setup

### Step 1: Rajveer Registers
1. Open http://localhost:3000
2. Click "Register" tab
3. Enter:
   - Name: Rajveer
   - Email: rajveer@example.com
   - Password: (choose a password)
   - Partner Email: (leave blank)
4. Click "Create Account"

### Step 2: Swarali Registers
1. Open http://localhost:3000 (on same or different device)
2. Click "Register" tab
3. Enter:
   - Name: Swarali
   - Email: swarali@example.com
   - Password: (choose a password)
   - Partner Email: rajveer@example.com ← **IMPORTANT!**
4. Click "Create Account"

### Step 3: You're Connected!
- Now both of you can see each other's posts
- All memories are shared between you
- Login from any device with your email/password

---

## 🌐 Making it Online (Access from Anywhere)

### Option 1: Use Ngrok (Temporary - Free)
1. Download ngrok: https://ngrok.com/download
2. Run server: `npm start`
3. In new terminal: `ngrok http 3000`
4. Share the https URL with your partner
5. Both can access from anywhere!

### Option 2: Deploy to Render (Permanent - Free)
1. Create account: https://render.com
2. Click "New +" → "Web Service"
3. Connect GitHub (push code to GitHub first)
4. Set environment variables
5. Deploy!
6. Get permanent URL like: https://your-app.onrender.com

### Option 3: Deploy to Railway (Permanent - Free)
1. Go to: https://railway.app
2. Sign in with GitHub
3. "New Project" → "Deploy from GitHub repo"
4. Add MongoDB plugin
5. Set environment variables
6. Deploy!

---

## ❓ Common Questions

**Q: Can we access from different cities?**
A: Yes! Once deployed online, access from anywhere.

**Q: Is data safe?**
A: Yes! Stored in MongoDB with password encryption.

**Q: Can we use on mobile?**
A: Yes! Works on mobile browsers. For app, see README.md

**Q: What if I forget password?**
A: Currently no reset. Keep passwords safe!

**Q: Can we add more partners?**
A: Currently designed for 2 people only.

---

## 🆘 Need Help?

### Server won't start?
- Make sure MongoDB connection string is correct in `.env`
- Check if port 3000 is free
- Run `npm install` again

### Can't login?
- Clear browser cookies
- Check email/password spelling
- Try registering again

### Partner can't see my posts?
- Make sure partner entered your email during registration
- Both should be logged in
- Refresh the page

---

## 📞 Contact

For any issues, check the full README.md file for detailed troubleshooting.

---

Made with 💕
