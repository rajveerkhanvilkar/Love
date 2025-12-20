// Push Notifications Handler for Mobile App
// Add this to each HTML page that needs notifications

class PushNotificationHandler {
    constructor() {
        this.isCapacitor = typeof Capacitor !== 'undefined';
        this.init();
    }

    async init() {
        if (!this.isCapacitor) {
            console.log('Not running in Capacitor, skipping push notifications');
            return;
        }

        const { PushNotifications } = Capacitor.Plugins;

        // Request permission
        let permStatus = await PushNotifications.checkPermissions();

        if (permStatus.receive === 'prompt') {
            permStatus = await PushNotifications.requestPermissions();
        }

        if (permStatus.receive !== 'granted') {
            console.log('Push notification permission denied');
            return;
        }

        // Register for push notifications
        await PushNotifications.register();

        // Listen for registration
        PushNotifications.addListener('registration', async (token) => {
            console.log('Push registration success, token:', token.value);
            // Send token to server
            await this.registerToken(token.value);
        });

        // Listen for registration errors
        PushNotifications.addListener('registrationError', (error) => {
            console.error('Error on registration:', error);
        });

        // Listen for push notifications
        PushNotifications.addListener('pushNotificationReceived', (notification) => {
            console.log('Push received:', notification);
            this.showLocalNotification(notification);
        });

        // Listen for notification taps
        PushNotifications.addListener('pushNotificationActionPerformed', (notification) => {
            console.log('Push action performed:', notification);
            this.handleNotificationTap(notification);
        });
    }

    async registerToken(token) {
        try {
            const response = await fetch(`${API_URL}/notifications/register`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': `Bearer ${getToken()}`
                },
                body: JSON.stringify({ token })
            });
            console.log('Token registered with server');
        } catch (error) {
            console.error('Error registering token:', error);
        }
    }

    showLocalNotification(notification) {
        // Show notification banner
        if (this.isCapacitor) {
            const { LocalNotifications } = Capacitor.Plugins;
            LocalNotifications.schedule({
                notifications: [{
                    title: notification.title,
                    body: notification.body,
                    id: Date.now(),
                    schedule: { at: new Date(Date.now() + 1000) }
                }]
            });
        }
    }

    handleNotificationTap(notification) {
        const data = notification.notification.data;

        // Navigate based on notification type
        switch (data.type) {
            case 'memory':
                window.location.href = 'memories.html';
                break;
            case 'timeline':
                window.location.href = 'timeline.html';
                break;
            case 'love-letter':
                window.location.href = 'love-letters.html';
                break;
            case 'comment':
                window.location.href = 'memories.html';
                break;
            case 'bucket-list':
                window.location.href = 'bucket-list.html';
                break;
            case 'activity':
                window.location.href = 'activities.html';
                break;
            default:
                window.location.href = 'home.html';
        }
    }
}

// Initialize when page loads
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', () => {
        window.pushHandler = new PushNotificationHandler();
    });
} else {
    window.pushHandler = new PushNotificationHandler();
}
