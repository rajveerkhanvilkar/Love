# How to Manually Allow All IPs (0.0.0.0/0)

If you don't see the "Allow Access From Anywhere" button, you can type the universal code manually.

1.  Go to **Network Access** (in the left sidebar of MongoDB Atlas).
2.  Click the green **Add IP Address** button.
3.  **IGNORE** the "Add Current IP Address" button.
4.  Look for the input box that says **"Access List Entry"** or **"Whitelist Entry"**.
5.  **TYPE EXACTLY THIS:**
    ```
    0.0.0.0/0
    ```
6.  (Optional) In the "Comment" box, type "Allow Vercel".
7.  Click **Confirm**.

And that's it! `0.0.0.0/0` is the code for "Anywhere".
