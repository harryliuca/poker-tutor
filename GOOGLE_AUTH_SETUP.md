# Google OAuth Setup Guide

## ✅ What We've Done

1. ✅ Installed OAuth dependencies (`expo-web-browser`, `expo-auth-session`, `expo-linking`)
2. ✅ Updated auth service to use WebBrowser for OAuth
3. ✅ Configured app scheme in `app.json` as `pokertutor`
4. ✅ Enabled Google provider in Supabase

## 🔧 Configure Supabase Redirect URLs

1. Go to: https://supabase.com/dashboard/project/irzvisggotlcglldfbzk/auth/url-configuration

2. Add these **Redirect URLs** (under "Site URL" section):
   ```
   pokertutor://
   exp://localhost:8081
   ```

3. Save changes

## 🧪 Test the App

1. **Stop** the current Expo server (Ctrl+C)

2. **Restart** the app:
   ```bash
   npm start
   ```

3. **Scan QR code** with Expo Go on your phone

4. **Click "Sign in with Google"**:
   - Should open a browser/webview
   - Sign in with your Google account
   - Should redirect back to the app
   - You should see the Home screen with your name!

## ⚠️ Troubleshooting

### Button does nothing
- Check Expo terminal for errors
- Make sure redirect URLs are configured in Supabase

### Browser opens but doesn't redirect back
- Verify `scheme: "pokertutor"` is in `app.json`
- Make sure you restarted the Expo server after changes
- Try clearing Expo Go cache

### "Invalid redirect URL" error
- Add `pokertutor://` to Supabase redirect URLs
- Also add `exp://localhost:8081` for development

### Still having issues?
- Check browser console / Expo logs for specific errors
- Verify Google OAuth is enabled in Supabase
- Make sure database migration was run (profiles table exists)

## 📱 Expected Flow

1. Login Screen → Click "Sign in with Google"
2. Browser opens → Google sign-in page
3. Select account → Authorize app
4. Redirect back to app → Home Screen
5. See "Welcome back, [Your Name]!"
6. Profile created automatically in database