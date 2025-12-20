// API Configuration and Helper Functions
const API_URL = window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1'
    ? 'http://localhost:3000/api'
    : 'https://couples-diary.vercel.app/api';

// Get authentication token
function getToken() {
    return localStorage.getItem('token');
}

// Get current user
function getUser() {
    const user = localStorage.getItem('user');
    return user ? JSON.parse(user) : null;
}

// Check if user is authenticated
function isAuthenticated() {
    return !!getToken();
}

// Redirect to login if not authenticated
function requireAuth() {
    if (!isAuthenticated()) {
        window.location.href = 'index.html';
        return false;
    }
    return true;
}

// Logout function
async function logout() {
    try {
        await fetch(`${API_URL}/auth/logout`, {
            method: 'POST',
            headers: {
                'Authorization': `Bearer ${getToken()}`
            },
            credentials: 'include'
        });
    } catch (error) {
        console.error('Logout error:', error);
    } finally {
        localStorage.removeItem('token');
        localStorage.removeItem('user');
        window.location.href = 'index.html';
    }
}

// Upload file
async function uploadFile(file) {
    const formData = new FormData();
    formData.append('image', file);

    const token = getToken();

    try {
        const response = await fetch(`${API_URL}/upload`, {
            method: 'POST',
            headers: {
                'Authorization': `Bearer ${token}`
            },
            body: formData
        });

        const data = await response.json();

        if (!response.ok) {
            throw new Error(data.error || 'Upload failed');
        }

        return data.url;
    } catch (error) {
        console.error('Upload error:', error);
        throw error;
    }
}

// Generic API request helper
async function apiRequest(endpoint, options = {}) {
    const token = getToken();

    const defaultOptions = {
        headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${token}`
        },
        credentials: 'include'
    };

    const mergedOptions = {
        ...defaultOptions,
        ...options,
        headers: {
            ...defaultOptions.headers,
            ...options.headers
        }
    };

    try {
        const response = await fetch(`${API_URL}${endpoint}`, mergedOptions);

        if (response.status === 401) {
            // Unauthorized - redirect to login
            localStorage.removeItem('token');
            localStorage.removeItem('user');
            window.location.href = 'index.html';
            return null;
        }

        const data = await response.json();

        if (!response.ok) {
            throw new Error(data.error || 'Request failed');
        }

        return data;
    } catch (error) {
        console.error('API Error:', error);
        throw error;
    }
}

// Specific API functions

// Memories
async function getMemories() {
    return apiRequest('/memories');
}

async function createMemory(memoryData) {
    return apiRequest('/memories', {
        method: 'POST',
        body: JSON.stringify(memoryData)
    });
}

async function deleteMemory(id) {
    return apiRequest(`/memories/${id}`, {
        method: 'DELETE'
    });
}

async function addComment(memoryId, comment) {
    return apiRequest(`/memories/${memoryId}/comments`, {
        method: 'POST',
        body: JSON.stringify(comment)
    });
}

// Timeline
async function getTimeline() {
    return apiRequest('/timeline');
}

async function createTimelineEvent(eventData) {
    return apiRequest('/timeline', {
        method: 'POST',
        body: JSON.stringify(eventData)
    });
}

async function deleteTimelineEvent(id) {
    return apiRequest(`/timeline/${id}`, {
        method: 'DELETE'
    });
}

// Activities
async function getActivities() {
    return apiRequest('/activities');
}

async function updateActivity(activityData) {
    return apiRequest('/activities', {
        method: 'POST',
        body: JSON.stringify(activityData)
    });
}

// Bucket List
async function getBucketList() {
    return apiRequest('/bucket-list');
}

async function createBucketItem(itemData) {
    return apiRequest('/bucket-list', {
        method: 'POST',
        body: JSON.stringify(itemData)
    });
}

async function updateBucketItem(id, itemData) {
    return apiRequest(`/bucket-list/${id}`, {
        method: 'PUT',
        body: JSON.stringify(itemData)
    });
}

async function deleteBucketItem(id) {
    return apiRequest(`/bucket-list/${id}`, {
        method: 'DELETE'
    });
}

// Love Letters
async function getLoveLetters() {
    return apiRequest('/love-letters');
}

async function createLoveLetter(letterData) {
    return apiRequest('/love-letters', {
        method: 'POST',
        body: JSON.stringify(letterData)
    });
}

// Moods
async function getMoods() {
    return apiRequest('/moods');
}

async function createMood(moodData) {
    return apiRequest('/moods', {
        method: 'POST',
        body: JSON.stringify(moodData)
    });
}

// User info
async function getCurrentUser() {
    return apiRequest('/auth/me');
}
