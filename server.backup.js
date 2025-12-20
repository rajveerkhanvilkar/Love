const express = require('express');
const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const cors = require('cors');
const cookieParser = require('cookie-parser');
const session = require('express-session');
const cloudinary = require('cloudinary').v2;
const multer = require('multer');
const { CloudinaryStorage } = require('multer-storage-cloudinary');
require('dotenv').config();

// Configure Cloudinary
cloudinary.config({
    cloud_name: process.env.CLOUDINARY_CLOUD_NAME,
    api_key: process.env.CLOUDINARY_API_KEY,
    api_secret: process.env.CLOUDINARY_API_SECRET
});

// Configure Multer with Cloudinary Storage
const storage = new CloudinaryStorage({
    cloudinary: cloudinary,
    params: {
        folder: 'couples-diary',
        allowed_formats: ['jpg', 'jpeg', 'png', 'gif', 'webp'],
        transformation: [{ width: 1200, quality: 'auto' }]
    }
});

const upload = multer({ storage: storage });

const app = express();

// Middleware
app.use(cors({
    origin: true,
    credentials: true
}));
app.use(express.json({ limit: '50mb' }));
app.use(express.urlencoded({ extended: true, limit: '50mb' }));
app.use(cookieParser());
app.use(session({
    secret: process.env.SESSION_SECRET,
    resave: false,
    saveUninitialized: false,
    cookie: { secure: false, maxAge: 24 * 60 * 60 * 1000 }
}));

// Serve static files
app.use(express.static(__dirname));

// MongoDB Connection
mongoose.connect(process.env.MONGODB_URI, {
    useNewUrlParser: true,
    useUnifiedTopology: true
})
    .then(() => console.log('✅ Connected to MongoDB'))
    .catch(err => console.error('❌ MongoDB connection error:', err));

// ==================== SCHEMAS ====================

// User Schema
const userSchema = new mongoose.Schema({
    name: { type: String, required: true },
    email: { type: String, required: true, unique: true },
    password: { type: String, required: true },
    partnerId: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
    createdAt: { type: Date, default: Date.now }
});

// Memory Post Schema
const memorySchema = new mongoose.Schema({
    userId: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
    coupleId: { type: String, required: true },
    media: [{
        src: { type: String, required: true },
        type: { type: String, enum: ['image', 'video'], required: true }
    }],
    caption: { type: String, required: true },
    isLoveNote: { type: Boolean, default: false },
    comments: [{
        author: String,
        text: String,
        createdAt: { type: Date, default: Date.now }
    }],
    currentIndex: { type: Number, default: 0 },
    createdAt: { type: Date, default: Date.now }
});

// Timeline Event Schema
const timelineSchema = new mongoose.Schema({
    userId: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
    coupleId: { type: String, required: true },
    date: { type: Date, required: true },
    title: { type: String, required: true },
    description: String,
    images: [String],
    createdAt: { type: Date, default: Date.now }
});

// Activity Schema
const activitySchema = new mongoose.Schema({
    coupleId: { type: String, required: true },
    activityId: { type: Number, required: true },
    completed: { type: Boolean, default: false },
    notes: String,
    completedAt: Date
});

// Bucket List Schema
const bucketListSchema = new mongoose.Schema({
    coupleId: { type: String, required: true },
    text: { type: String, required: true },
    category: { type: String, default: 'Dream' },
    completed: { type: Boolean, default: false },
    createdAt: { type: Date, default: Date.now }
});

// Love Letter Schema
const loveLetterSchema = new mongoose.Schema({
    coupleId: { type: String, required: true },
    from: { type: String, required: true },
    text: { type: String, required: true },
    createdAt: { type: Date, default: Date.now }
});

// Mood Schema
const moodSchema = new mongoose.Schema({
    userId: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
    coupleId: { type: String, required: true },
    emoji: { type: String, required: true },
    createdAt: { type: Date, default: Date.now }
});

// Models
const User = mongoose.model('User', userSchema);
const Memory = mongoose.model('Memory', memorySchema);
const Timeline = mongoose.model('Timeline', timelineSchema);
const Activity = mongoose.model('Activity', activitySchema);
const BucketList = mongoose.model('BucketList', bucketListSchema);
const LoveLetter = mongoose.model('LoveLetter', loveLetterSchema);
const Mood = mongoose.model('Mood', moodSchema);

// ==================== MIDDLEWARE ====================

// Authentication Middleware
const authenticate = async (req, res, next) => {
    try {
        const token = req.cookies.token || req.headers.authorization?.split(' ')[1];

        if (!token) {
            return res.status(401).json({ error: 'Authentication required' });
        }

        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        req.userId = decoded.userId;
        req.user = await User.findById(decoded.userId);

        if (!req.user) {
            return res.status(401).json({ error: 'User not found' });
        }

        // Get couple ID (sorted user IDs)
        if (req.user.partnerId) {
            const ids = [req.user._id.toString(), req.user.partnerId.toString()].sort();
            req.coupleId = ids.join('-');
        } else {
            req.coupleId = req.user._id.toString();
        }

        next();
    } catch (error) {
        res.status(401).json({ error: 'Invalid token' });
    }
};

// ==================== AUTH ROUTES ====================

// Register
app.post('/api/auth/register', async (req, res) => {
    try {
        const { name, email, password, partnerEmail } = req.body;

        // Check if user exists
        const existingUser = await User.findOne({ email });
        if (existingUser) {
            return res.status(400).json({ error: 'Email already registered' });
        }

        // Hash password
        const hashedPassword = await bcrypt.hash(password, 10);

        // Create user
        const user = new User({
            name,
            email,
            password: hashedPassword
        });

        // Link partner if provided
        if (partnerEmail) {
            const partner = await User.findOne({ email: partnerEmail });
            if (partner) {
                user.partnerId = partner._id;
                partner.partnerId = user._id;
                await partner.save();
            }
        }

        await user.save();

        // Generate token
        const token = jwt.sign({ userId: user._id }, process.env.JWT_SECRET, { expiresIn: '7d' });

        res.cookie('token', token, { httpOnly: true, maxAge: 7 * 24 * 60 * 60 * 1000 });
        res.json({
            success: true,
            token,
            user: { id: user._id, name: user.name, email: user.email }
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Login
app.post('/api/auth/login', async (req, res) => {
    try {
        const { email, password } = req.body;

        // Find user
        const user = await User.findOne({ email });
        if (!user) {
            return res.status(401).json({ error: 'Invalid credentials' });
        }

        // Check password
        const isValid = await bcrypt.compare(password, user.password);
        if (!isValid) {
            return res.status(401).json({ error: 'Invalid credentials' });
        }

        // Generate token
        const token = jwt.sign({ userId: user._id }, process.env.JWT_SECRET, { expiresIn: '7d' });

        res.cookie('token', token, { httpOnly: true, maxAge: 7 * 24 * 60 * 60 * 1000 });
        res.json({
            success: true,
            token,
            user: { id: user._id, name: user.name, email: user.email }
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Logout
app.post('/api/auth/logout', (req, res) => {
    res.clearCookie('token');
    res.json({ success: true });
});

// Get current user
app.get('/api/auth/me', authenticate, async (req, res) => {
    try {
        const partner = req.user.partnerId ? await User.findById(req.user.partnerId) : null;
        res.json({
            user: {
                id: req.user._id,
                name: req.user.name,
                email: req.user.email
            },
            partner: partner ? {
                id: partner._id,
                name: partner.name,
                email: partner.email
            } : null
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// ==================== UPLOAD ROUTE ====================

// Upload image to Cloudinary
app.post('/api/upload', authenticate, upload.single('image'), async (req, res) => {
    try {
        if (!req.file) {
            return res.status(400).json({ error: 'No file uploaded' });
        }

        // Return the Cloudinary URL
        res.json({
            success: true,
            url: req.file.path,
            publicId: req.file.filename
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// ==================== MEMORY ROUTES ====================

// Get all memories
app.get('/api/memories', authenticate, async (req, res) => {
    try {
        const memories = await Memory.find({ coupleId: req.coupleId }).sort({ createdAt: -1 });
        res.json(memories);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Create memory
app.post('/api/memories', authenticate, async (req, res) => {
    try {
        const memory = new Memory({
            userId: req.userId,
            coupleId: req.coupleId,
            ...req.body
        });
        await memory.save();
        res.json(memory);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Delete memory
app.delete('/api/memories/:id', authenticate, async (req, res) => {
    try {
        await Memory.findByIdAndDelete(req.params.id);
        res.json({ success: true });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Add comment
app.post('/api/memories/:id/comments', authenticate, async (req, res) => {
    try {
        const memory = await Memory.findById(req.params.id);
        memory.comments.push(req.body);
        await memory.save();
        res.json(memory);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// ==================== TIMELINE ROUTES ====================

// Get timeline events
app.get('/api/timeline', authenticate, async (req, res) => {
    try {
        const events = await Timeline.find({ coupleId: req.coupleId }).sort({ date: 1 });
        res.json(events);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Create timeline event
app.post('/api/timeline', authenticate, async (req, res) => {
    try {
        const event = new Timeline({
            userId: req.userId,
            coupleId: req.coupleId,
            ...req.body
        });
        await event.save();
        res.json(event);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Delete timeline event
app.delete('/api/timeline/:id', authenticate, async (req, res) => {
    try {
        await Timeline.findByIdAndDelete(req.params.id);
        res.json({ success: true });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// ==================== OTHER ROUTES ====================

// Activities
app.get('/api/activities', authenticate, async (req, res) => {
    try {
        const activities = await Activity.find({ coupleId: req.coupleId });
        res.json(activities);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

app.post('/api/activities', authenticate, async (req, res) => {
    try {
        const activity = await Activity.findOneAndUpdate(
            { coupleId: req.coupleId, activityId: req.body.activityId },
            { ...req.body, coupleId: req.coupleId },
            { upsert: true, new: true }
        );
        res.json(activity);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Bucket List
app.get('/api/bucket-list', authenticate, async (req, res) => {
    try {
        const items = await BucketList.find({ coupleId: req.coupleId }).sort({ createdAt: -1 });
        res.json(items);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

app.post('/api/bucket-list', authenticate, async (req, res) => {
    try {
        const item = new BucketList({ ...req.body, coupleId: req.coupleId });
        await item.save();
        res.json(item);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

app.delete('/api/bucket-list/:id', authenticate, async (req, res) => {
    try {
        await BucketList.findByIdAndDelete(req.params.id);
        res.json({ success: true });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Love Letters
app.get('/api/love-letters', authenticate, async (req, res) => {
    try {
        const letters = await LoveLetter.find({ coupleId: req.coupleId }).sort({ createdAt: -1 });
        res.json(letters);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

app.post('/api/love-letters', authenticate, async (req, res) => {
    try {
        const letter = new LoveLetter({ ...req.body, coupleId: req.coupleId });
        await letter.save();
        res.json(letter);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Moods
app.get('/api/moods', authenticate, async (req, res) => {
    try {
        const moods = await Mood.find({ coupleId: req.coupleId }).sort({ createdAt: -1 });
        res.json(moods);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

app.post('/api/moods', authenticate, async (req, res) => {
    try {
        const mood = new Mood({
            ...req.body,
            userId: req.userId,
            coupleId: req.coupleId
        });
        await mood.save();
        res.json(mood);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// ==================== START SERVER ====================

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`🚀 Server running on http://localhost:${PORT}`);
    console.log(`💕 Couples Diary Application Ready!`);
});
