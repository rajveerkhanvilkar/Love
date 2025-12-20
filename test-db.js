require('dotenv').config();
const mongoose = require('mongoose');

const uri = process.env.MONGODB_URI;

console.log('⏳ Testing MongoDB Connection...');
console.log('📝 URI Length:', uri ? uri.length : 'MISSING!');

if (!uri) {
    console.error('❌ STARTUP ERROR: MONGODB_URI is missing in .env file');
    process.exit(1);
}

mongoose.connect(uri, {
    serverSelectionTimeoutMS: 5000 // Timeout after 5s instead of 30s
})
    .then(() => {
        console.log('✅ SUCCESS! Connected to MongoDB.');
        console.log('🚀 Your IP address is whitelisted and password is correct.');
        process.exit(0);
    })
    .catch(err => {
        console.error('\n❌ CONNECTION FAILED');
        console.error('---------------------------------------------------');
        console.error('Error Name:', err.name);
        console.error('Error Message:', err.message);
        console.error('---------------------------------------------------');

        if (err.message.includes('bad auth')) {
            console.log('💡 TIP: Check your database Username and Password in .env');
        } else if (err.message.includes('queryTxt ETIMEOUT')) {
            console.log('💡 TIP: This is a DNS or Network error. Check your internet.');
        } else {
            console.log('💡 MOST LIKELY CAUSE: IP ADDRESS BLOCKED');
            console.log('1. Go to MongoDB Atlas (cloud.mongodb.com)');
            console.log('2. Click "Network Access" on the left');
            console.log('3. Click "Add IP Address"');
            console.log('4. Click "Allow Access From Anywhere" (0.0.0.0/0)');
            console.log('5. Click "Confirm"');
        }
        process.exit(1);
    });
