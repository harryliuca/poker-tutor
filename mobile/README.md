# Poker Tutor Mobile App

React Native mobile app for practicing poker decision-making skills.

## Tech Stack

- **React Native** with Expo
- **TypeScript** for type safety
- **Supabase** for backend (database, auth, API)
- **React Native Paper** for UI components
- **React Query** for data fetching
- **AsyncStorage** for offline support

## Prerequisites

- Node.js 18+ (LTS)
- npm or yarn
- Expo Go app on your phone (iOS/Android)
- Supabase account (free tier)

## Setup Instructions

### 1. Install Dependencies

```bash
npm install
```

### 2. Configure Supabase

1. Create a Supabase project at https://supabase.com
2. Copy your project URL and anon key from: Project Settings → API
3. Update `.env` file:

```env
EXPO_PUBLIC_SUPABASE_URL=https://your-project-ref.supabase.co
EXPO_PUBLIC_SUPABASE_ANON_KEY=your-anon-key-here
```

### 3. Setup Supabase Database

Run the SQL migrations from `../docs/DATABASE_SCHEMA.md` in your Supabase SQL editor:

1. Create tables (profiles, questions, user_answers, etc.)
2. Enable Row Level Security
3. Create policies
4. Create triggers

### 4. Configure Google OAuth

1. In Supabase Dashboard → Authentication → Providers
2. Enable Google provider
3. Add OAuth credentials from Google Cloud Console
4. Add redirect URL: `pokertutor://auth/callback`

### 5. Generate Questions

Run the question generation script (to be created) to populate the questions table with 150 initial questions using OpenAI API.

## Running the App

### Development

```bash
npm start
```

This will start the Expo development server. Scan the QR code with:
- **iOS**: Camera app
- **Android**: Expo Go app

### Run on Specific Platform

```bash
npm run ios       # iOS simulator
npm run android   # Android emulator
npm run web       # Web browser
```

## Project Structure

```
src/
├── components/         # Reusable UI components
│   ├── buttons/
│   ├── cards/
│   ├── common/
│   └── stats/
├── screens/           # Screen components
│   ├── auth/          # Login screen
│   ├── home/          # Home screen
│   ├── practice/      # Practice screens
│   └── profile/       # Profile screen
├── services/          # API services
│   ├── supabase.ts
│   ├── auth.ts
│   ├── questions.ts
│   ├── answers.ts
│   ├── stats.ts
│   └── challenge.ts
├── hooks/             # Custom React hooks
├── contexts/          # React contexts
├── types/             # TypeScript types
├── utils/             # Utility functions
└── constants/         # Constants and config
```

## Available Scripts

- `npm start` - Start Expo development server
- `npm run ios` - Run on iOS simulator
- `npm run android` - Run on Android emulator
- `npm run web` - Run in web browser

## Features

### Implemented
- ✅ Authentication with Google OAuth
- ✅ User profile and stats tracking
- ✅ Home screen with daily challenge
- ✅ Stats display
- ✅ Theme support (dark/light)

### TODO
- [ ] Question screen with poker scenarios
- [ ] Answer submission and feedback
- [ ] Daily challenge flow
- [ ] Random practice mode
- [ ] Profile screen with detailed stats
- [ ] Streak tracking and celebrations
- [ ] Offline support
- [ ] Push notifications

## Environment Variables

Create a `.env` file in the root directory:

```env
EXPO_PUBLIC_SUPABASE_URL=https://your-project.supabase.co
EXPO_PUBLIC_SUPABASE_ANON_KEY=your-anon-key
```

Never commit the `.env` file with real credentials!

## Troubleshooting

### "Supabase credentials not found"
- Make sure `.env` file exists with correct values
- Restart the development server after changing `.env`

### Authentication not working
- Verify Google OAuth is configured in Supabase
- Check redirect URL matches in Supabase settings
- Make sure you're testing on a real device (OAuth may not work in simulator)

### Database errors
- Verify all migrations are run in Supabase
- Check Row Level Security policies are enabled
- Verify user has proper permissions

## Deployment

### Build for Production

```bash
# Install EAS CLI
npm install -g eas-cli

# Login to Expo
eas login

# Configure build
eas build:configure

# Build for iOS and Android
eas build --platform all
```

### OTA Updates

```bash
# Push update
eas update --branch production --message "Description"
```

## Contributing

1. Create a feature branch
2. Make changes
3. Test thoroughly
4. Submit pull request

## License

MIT