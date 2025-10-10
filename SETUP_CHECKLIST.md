# Setup Checklist

## ✅ Completed

- [x] Created Supabase project
- [x] Added Supabase credentials to `.env`
- [x] Enabled Google OAuth provider
- [ ] Run database migration
- [ ] Test the app
- [ ] Generate questions

## 🗄️ Database Migration

Run the SQL in `supabase-migration.sql` in your Supabase SQL Editor to create all tables.

**Steps:**
1. Go to: https://supabase.com/dashboard/project/irzvisggotlcglldfbzk/sql
2. Click **New Query**
3. Copy/paste contents of `supabase-migration.sql`
4. Click **Run**
5. Verify success (should see "Success. No rows returned")

**To verify it worked:**
Run the test query in `test-database.sql` - you should see 6 tables listed.

## 📱 Test the App

```bash
cd mobile
npm start
```

Scan QR code with Expo Go app on your phone.

**Expected Flow:**
1. See Login screen with "Sign in with Google" button
2. Click button → Opens Google sign-in
3. After signing in → Redirects to Home screen
4. See welcome message with your name
5. See daily challenge card (empty until questions are generated)
6. See stats (all zeros initially)

## 🎯 Next Steps After Testing

1. **Generate Questions** - Create 150 poker questions using OpenAI API
2. **Build Question Screen** - Display poker scenarios and answer choices
3. **Build Practice Flow** - Complete the practice mode
4. **Build Profile Screen** - Detailed stats and settings

---

## ⚠️ Troubleshooting

### "Supabase credentials not found"
- Check `.env` file exists
- Restart Expo dev server (`npm start`)

### Google OAuth redirects to browser but doesn't go back to app
- Make sure redirect URL is set: `pokertutor://auth/callback`
- You may need to test on a real device (not simulator)

### Database errors / "relation does not exist"
- Run the migration SQL in Supabase SQL Editor
- Verify tables exist by running test query

### App crashes on login
- Check browser console for errors
- Verify RLS policies are set correctly