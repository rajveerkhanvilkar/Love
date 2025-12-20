// Push Notification Service for Real-time Updates
const admin = require('firebase-admin');

// Initialize Firebase Admin (you'll need to add your service account key)
// Download from Firebase Console -> Project Settings -> Service Accounts
// const serviceAccount = require('./firebase-service-account.json');

// admin.initializeApp({
//   credential: admin.credential.cert(serviceAccount)
// });

// Store user FCM tokens
const userTokens = new Map();

// Register device token
function registerDeviceToken(userId, token) {
    if (!userTokens.has(userId)) {
        userTokens.set(userId, []);
    }
    const tokens = userTokens.get(userId);
    if (!tokens.includes(token)) {
        tokens.push(token);
    }
}

// Send notification to partner
async function notifyPartner(userId, partnerId, notification) {
    const partnerTokens = userTokens.get(partnerId);

    if (!partnerTokens || partnerTokens.length === 0) {
        console.log('No device tokens for partner');
        return;
    }

    const message = {
        notification: {
            title: notification.title,
            body: notification.body,
            imageUrl: notification.image || undefined
        },
        data: {
            type: notification.type,
            id: notification.id || '',
            click_action: 'FLUTTER_NOTIFICATION_CLICK'
        },
        tokens: partnerTokens
    };

    try {
        const response = await admin.messaging().sendMulticast(message);
        console.log('Notification sent:', response.successCount, 'success,', response.failureCount, 'failed');

        // Remove invalid tokens
        if (response.failureCount > 0) {
            const tokensToRemove = [];
            response.responses.forEach((resp, idx) => {
                if (!resp.success) {
                    tokensToRemove.push(partnerTokens[idx]);
                }
            });
            userTokens.set(partnerId, partnerTokens.filter(t => !tokensToRemove.includes(t)));
        }
    } catch (error) {
        console.error('Error sending notification:', error);
    }
}

// Notification templates
const NotificationTemplates = {
    newMemory: (userName) => ({
        title: '💕 New Memory!',
        body: `${userName} just shared a beautiful memory with you!`,
        type: 'memory'
    }),

    newTimelineEvent: (userName, eventTitle) => ({
        title: '⏰ New Timeline Event',
        body: `${userName} added: ${eventTitle}`,
        type: 'timeline'
    }),

    newLoveLetter: (userName) => ({
        title: '💌 Love Letter',
        body: `${userName} wrote you a love letter!`,
        type: 'love-letter'
    }),

    newComment: (userName, postCaption) => ({
        title: '💬 New Comment',
        body: `${userName} commented on: ${postCaption.substring(0, 30)}...`,
        type: 'comment'
    }),

    bucketListComplete: (userName, item) => ({
        title: '✨ Dream Achieved!',
        body: `${userName} completed: ${item}`,
        type: 'bucket-list'
    }),

    newActivity: (userName, activity) => ({
        title: '🎯 Activity Completed',
        body: `${userName} completed: ${activity}`,
        type: 'activity'
    })
};

module.exports = {
    registerDeviceToken,
    notifyPartner,
    NotificationTemplates
};
