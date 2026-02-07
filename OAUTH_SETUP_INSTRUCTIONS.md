# OAuth Setup Instructions for Your Majesty

## 🔒 Google Sign-In Configuration

### Step 1: Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add Project"
3. Enter project name: `alu-academic-assistant`
4. Disable Google Analytics (or enable if you want)
5. Click "Create Project"

### Step 2: Enable Google Authentication

1. In your Firebase project, go to **Authentication** → **Sign-in method**
2. Click on **Google** provider
3. Toggle **Enable**
4. Add your support email
5. Click **Save**

### Step 3: Register Your Web App

1. In Firebase Console, click the **⚙️ gear icon** → **Project settings**
2. Scroll down and click **Web** icon (`</>`)
3. Register app name: `ALU Academic Assistant`
4. Check **"Also set up Firebase Hosting"** (optional)
5. Click **Register app**

### Step 4: Get Your Firebase Config

You'll see something like this:

```javascript
const firebaseConfig = {
  apiKey: "AIzaSyXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
  authDomain: "alu-academic-assistant.firebaseapp.com",
  projectId: "alu-academic-assistant",
  storageBucket: "alu-academic-assistant.appspot.com",
  messagingSenderId: "123456789012",
  appId: "1:123456789012:web:abcdef1234567890abcdef"
};
```

### Step 5: Update main.dart

Replace the placeholder values in `lib/main.dart`:

```dart
await Firebase.initializeApp(
  options: const FirebaseOptions(
    apiKey: "YOUR_ACTUAL_API_KEY",              // ← Replace this
    authDomain: "YOUR_ACTUAL_AUTH_DOMAIN",      // ← Replace this
    projectId: "YOUR_ACTUAL_PROJECT_ID",        // ← Replace this
    storageBucket: "YOUR_ACTUAL_STORAGE_BUCKET",// ← Replace this
    messagingSenderId: "YOUR_SENDER_ID",        // ← Replace this
    appId: "YOUR_APP_ID",                       // ← Replace this
  ),
);
```

### Step 6: Add Authorized Domains

1. In Firebase Console → **Authentication** → **Settings** → **Authorized domains**
2. Add these domains:
   - `localhost`
   - `127.0.0.1`
   - Your production domain (if deploying)

### Step 7: Configure Google Cloud Console

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Select your Firebase project
3. Go to **APIs & Services** → **Credentials**
4. Click on the **OAuth 2.0 Client ID** that Firebase created
5. Under **Authorized JavaScript origins**, add:
   - `http://localhost`
   - `http://localhost:5000` (or your port)
6. Under **Authorized redirect URIs**, add:
   - `http://localhost` 
   - `http://localhost/__/auth/handler`

### Step 8: Install Dependencies

```powershell
flutter pub get
```

### Step 9: Run the App

```powershell
flutter run -d chrome
```

## 🎯 Testing Google Sign-In

1. Click "Continue with Google" button
2. Select your Google account
3. Grant permissions
4. You should be logged in!

## 🔐 Security Notes for Your Majesty

- ✅ OAuth tokens are handled by Firebase (secure)
- ✅ No passwords stored locally
- ✅ Google manages authentication
- ⚠️ API keys in code are OK for web apps (they're public anyway)
- ⚠️ For production, add Firebase App Check for extra security

## 🐛 Troubleshooting

### "Firebase not initialized" error
- Make sure you replaced ALL placeholder values
- Check that Firebase is initialized before `runApp()`

### "Provider not enabled" error
- Enable Google provider in Firebase Console → Authentication

### "Unauthorized domain" error  
- Add your domain to Authorized domains in Firebase

### Google Sign-In popup closes immediately
- Check authorized redirect URIs in Google Cloud Console

## 📝 Microsoft Sign-In (Optional)

To add Microsoft OAuth:

1. Install: `flutter pub add extension_google_sign_in_as_googleapis_auth`
2. Or use Azure AD B2C
3. Similar setup in Azure Portal
4. Add button in login_screen.dart

## ✨ Your Current Setup

✅ Google Sign-In button added to login screen  
✅ Auth service updated with OAuth methods  
✅ Firebase initialized in main.dart  
✅ Email/password login still works as fallback  

---

**Ready to proceed, Your Majesty?** Configure Firebase and test the OAuth login! 👑
