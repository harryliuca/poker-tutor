# Deployment Guide

## 🌐 Live Web App

**Production URL**: https://poker-tutor.netlify.app

---

## Web Deployment (Netlify)

### Prerequisites
- Node.js installed
- Netlify CLI: `npm install -g netlify-cli`

### Deploy Steps

1. **Build for web:**
   ```bash
   cd mobile
   npx expo export --platform web
   ```

2. **Deploy to Netlify:**
   ```bash
   netlify deploy --dir=dist --prod
   ```

3. **First time setup:**
   - Choose "Create & configure a new site"
   - Select your team
   - Enter site name (or use auto-generated)

### Update Existing Deployment

```bash
# Clean old build
rm -rf dist

# Build fresh
npx expo export --platform web

# Deploy
netlify deploy --dir=dist --prod
```

---

## Database Setup

### 1. Create Supabase Project
- Go to https://supabase.com
- Create new project
- Note your project URL and anon key

### 2. Run Database Migrations

In Supabase SQL Editor, run these files **in order**:

```sql
-- 1. Create schema
supabase-migration.sql

-- 2. Load questions (run all 4 files)
questions-150.sql           -- Pre-Flop (55 questions)
questions-part2.sql         -- Post-Flop (32 questions)
questions-part3.sql         -- Turn (31 questions)
questions-part4-final.sql   -- River + Special (43 questions)

-- 3. Setup auto-update triggers
update-profile-stats-trigger.sql  -- Stats updates
update-streak-trigger.sql         -- Streak tracking
```

### 3. Configure Environment Variables

Create `.env` in `mobile/` folder:

```bash
EXPO_PUBLIC_SUPABASE_URL=your-project-url
EXPO_PUBLIC_SUPABASE_ANON_KEY=your-anon-key
```

For Netlify deployment, add these as **Environment Variables** in Netlify dashboard:
- Go to Site Settings → Environment Variables
- Add both variables

---

## Mobile App Deployment

### iOS (TestFlight)

**Requirements:**
- Apple Developer Account ($99/year)
- EAS CLI: `npm install -g eas-cli`

**Steps:**
```bash
cd mobile
eas login
eas build:configure
eas build --platform ios
eas submit --platform ios
```

### Android (APK)

**Requirements:**
- EAS CLI: `npm install -g eas-cli`

**Steps:**
```bash
cd mobile
eas login
eas build:configure
eas build --platform android --profile preview
```

Download the APK and share directly (no Play Store needed for testing).

---

## Continuous Deployment

### Automatic Netlify Deploys

1. **Connect GitHub:**
   - Push code to GitHub repository
   - In Netlify: Site Settings → Build & Deploy → Link Repository
   - Set build command: `cd mobile && npx expo export --platform web`
   - Set publish directory: `mobile/dist`

2. **Auto-deploy on push:**
   - Every push to `main` branch auto-deploys
   - No manual CLI deployment needed

### Environment Variables for CI/CD

Add to Netlify environment variables:
```
EXPO_PUBLIC_SUPABASE_URL=your-url
EXPO_PUBLIC_SUPABASE_ANON_KEY=your-key
```

---

## Database Backups

### Export Questions
```sql
-- In Supabase SQL Editor
COPY (SELECT * FROM questions) TO STDOUT WITH CSV HEADER;
```

### Export User Data
```sql
-- Backup profiles
COPY (SELECT * FROM profiles) TO STDOUT WITH CSV HEADER;

-- Backup answers
COPY (SELECT * FROM user_answers) TO STDOUT WITH CSV HEADER;

-- Backup progress
COPY (SELECT * FROM user_daily_progress) TO STDOUT WITH CSV HEADER;
```

---

## Monitoring & Analytics

### Netlify Analytics
- Site Settings → Analytics
- View traffic, bandwidth, performance

### Supabase Dashboard
- Monitor database usage
- Track API calls
- View active users

### Error Tracking (Future)
- Add Sentry for error monitoring
- Add analytics (Google Analytics, Mixpanel)

---

## Rollback Strategy

### Web Deployment
```bash
# Rollback to previous deployment
netlify rollback
```

### Database Migration Rollback
- Create backup before major migrations
- Keep previous SQL files for manual rollback
- Test migrations on staging environment first

---

## Security Checklist

### Before Going Public

- [ ] Environment variables secured (not in code)
- [ ] RLS policies enabled on all tables
- [ ] API keys rotated if exposed
- [ ] CORS configured properly
- [ ] Rate limiting enabled (Supabase dashboard)
- [ ] Backup strategy in place
- [ ] SSL/HTTPS enabled (automatic with Netlify)

---

## Deployment Checklist

### Pre-Deploy
- [ ] All tests passing: `npm test`
- [ ] Build succeeds: `npx expo export --platform web`
- [ ] .env variables configured
- [ ] Database migrations applied
- [ ] Questions loaded (161 total)

### Post-Deploy
- [ ] Test login/signup
- [ ] Complete a daily challenge
- [ ] Check profile stats update
- [ ] Verify streak tracking
- [ ] Test on mobile browser
- [ ] Test on desktop browser

---

## Support & Maintenance

### Update Questions
1. Edit SQL files in `/questions-*.sql`
2. Run in Supabase SQL Editor
3. Questions immediately available

### Update App
1. Make code changes in `/mobile/src`
2. Test locally: `npm run web`
3. Deploy: `netlify deploy --dir=dist --prod`
4. Changes live in ~1 minute

### Database Changes
1. Create new migration SQL file
2. Test on development database first
3. Run on production Supabase
4. Update RLS policies if needed

---

## Troubleshooting

### Web Build Fails
```bash
# Clear cache and rebuild
rm -rf dist node_modules .expo
npm install
npx expo export --platform web
```

### Database Connection Issues
- Check environment variables
- Verify Supabase project is active
- Check RLS policies (may block queries)

### Deployment Fails
```bash
# Check Netlify logs
netlify logs

# Verify build directory exists
ls -la dist
```

---

## Cost Breakdown

### Current (Free Tier)
- **Netlify**: Free (100GB bandwidth/month)
- **Supabase**: Free (500MB database, 2GB bandwidth)
- **Total**: $0/month

### When to Upgrade
- Netlify: >100GB bandwidth → $19/month
- Supabase: >500MB database → $25/month
- Apple Developer: $99/year (for iOS TestFlight)

---

**Last Updated**: 2025-09-30
**Current Version**: 1.0.0
**Production URL**: https://poker-tutor.netlify.app
