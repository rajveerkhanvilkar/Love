# How to Fix "Server Connection Error"

If you see "Server connection error", it means your website (frontend) cannot talk to your backend API.

## Scenario A: You want to run everything LOCALLY

1.  **Start the Server**:
    Open a new terminal and run:
    ```bash
    npm start
    ```
    You should see: `🚀 Server is running on port 3000`

2.  **Update the API URL**:
    The code currently points to Vercel (`https://couples-diary.vercel.app/api`). You need to point it to your local server.
    
    *   Open `index.html` and change:
        ```javascript
        const API_URL = 'http://localhost:3000/api';
        ```
    *   Open `api.js` (in the root folder) and change:
        ```javascript
        const API_URL = 'http://localhost:3000/api';
        ```

3.  **Check MongoDB**:
    Make sure you have a `.env` file with a valid `MONGODB_URI`. If not, create one!

---

## Scenario B: You want to deploy to VERCEL (Recommended)

The project is configured for Vercel. If "couples-diary.vercel.app" is your URL:

1.  **Deploy the Backend**:
    Make sure you have deployed this **entire project** to Vercel, specifically including the `api` folder.

2.  **Set Environment Variables on Vercel**:
    Go to Vercel Dashboard -> Project Settings -> Environment Variables.
    Add:
    *   `MONGODB_URI`: Your MongoDB connection string.
    *   `JWT_SECRET`: A secret key (e.g., "mysecret").
    *   `CLOUDINARY_...`: Your Cloudinary keys.

    **If these are missing, the server will crash and you will get a connection error.**

3.  **Check Vercel Logs**:
    Go to Vercel Dashboard -> Deployments -> [Latest Deployment] -> Functions.
    Check the logs for `api/index.js`. If you see errors (like "MongoTimeout"), that is why it's failing.

---

## Scenario C: You are on NETLIFY

If your frontend is on Netlify (`something.netlify.app`) but you want to use the Vercel backend:

1.  Ensure the Vercel backend is actually running (see Scenario B).
2.  The `API_URL` in `index.html` MUST point to `https://couples-diary.vercel.app/api`.
3.  Check the "Network" tab in your browser's Developer Tools (F12).
    *   Look for the failed request (red line).
    *   Click it and see the "Response".
    *   If it says "CORS error", you might need to update `allowed origins` in `server-app.js`.
