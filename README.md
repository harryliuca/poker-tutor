# Poker Tutor 🃏

A mobile app for practicing Texas Hold'em poker decision-making through daily challenges and immediate feedback.

**Status**: MVP Phase 1 - 80% Complete ✅

---

## Quick Start

### Prerequisites
- Node.js 18+
- Expo CLI
- Expo Go app (iOS/Android)
- Supabase account

### Installation

```bash
cd mobile
npm install
```

### Configuration

Create `.env` file in `/mobile`:

```env
EXPO_PUBLIC_SUPABASE_URL=your_supabase_url
EXPO_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key
```

### Run

```bash
npm start
```

Scan QR code with Expo Go app.

### Testing

```bash
npm test              # Run all tests
npm run test:watch   # Watch mode
npm run test:coverage # Coverage report
```

**Current Test Status**: ✅ 31/31 tests passing

---

## Features

### ✅ Implemented
- Daily challenges (10 fixed questions per day)
- Random practice mode
- Email/password authentication
- Progress persistence
- Score calculation with perfect score bonus
- Streak tracking
- Challenge completion summary
- Unit testing framework

### ⏳ In Progress
- Profile screen with detailed stats
- Question library (10/150 complete)

### 🔜 Planned
- Google OAuth
- 150 total questions across 5 categories and 3 difficulty levels
- Offline support
- Push notifications
- Better UI/UX design
- React Navigation tabs

---

## Tech Stack

- **Frontend**: React Native + Expo
- **Backend**: Supabase (PostgreSQL + Auth + RLS)
- **Language**: TypeScript
- **UI**: React Native Paper
- **State**: React Query (@tanstack/react-query)
- **Testing**: Jest + React Native Testing Library
- **OTA Updates**: Expo Updates (EAS)

---

## Project Structure

```
poker-tutor/
├── docs/                     # Planning & documentation
│   ├── PROJECT_OVERVIEW.md
│   ├── DEVELOPMENT_PROGRESS.md
│   ├── DATABASE_SCHEMA.md
│   ├── MOBILE_APP_PLAN.md
│   └── ...
│
├── mobile/                   # React Native app
│   ├── src/
│   │   ├── screens/         # UI screens
│   │   ├── services/        # API & business logic
│   │   ├── utils/           # Utility functions
│   │   └── constants/       # Config
│   ├── App.tsx
│   ├── package.json
│   └── jest.config.js
│
├── supabase-migration.sql   # Database schema
├── sample-questions.sql     # Test questions
└── README.md                # This file
```

---

## Documentation

- **[Project Overview](docs/PROJECT_OVERVIEW.md)** - Business goals, features, roadmap
- **[Development Progress](docs/DEVELOPMENT_PROGRESS.md)** - Current status, completed features, next steps
- **[Mobile App Plan](docs/MOBILE_APP_PLAN.md)** - UI/UX screens, navigation, implementation details
- **[Database Schema](docs/DATABASE_SCHEMA.md)** - PostgreSQL tables, RLS policies
- **[Tech Stack](docs/TECH_STACK.md)** - Technology choices and rationale
- **[Testing Guide](mobile/TESTING.md)** - How to write and run tests

---

## Development Workflow

### 1. Start Development Server
```bash
cd mobile
npm start
```

### 2. Run Tests
```bash
npm test
```

### 3. Test on Device
- Open Expo Go app
- Scan QR code from terminal
- Shake device to open developer menu

---

## Database Setup

1. Create Supabase project
2. Run `/supabase-migration.sql` in SQL editor
3. Run `/sample-questions.sql` to add test questions
4. Enable email auth in Supabase dashboard
5. Configure RLS policies (already in migration script)

---

## Known Issues

### Resolved ✅
- ~~Timezone handling in date comparisons~~ (Fixed with parseDate helper)
- ~~Daily challenge progress not persisting~~ (Fixed with question_ids storage)
- ~~Random question ordering~~ (Fixed with client-side shuffle)
- ~~RLS blocking inserts~~ (Fixed with INSERT policy)

### Current Limitations
- Only 10 sample questions (need 140 more)
- No offline support yet
- Basic UI (needs visual polish)
- Email/password auth only (Google OAuth pending)

---

## Next Steps

### Immediate Priority
1. Build Profile screen with stats
2. Generate remaining 140 questions with OpenAI
3. Improve UI/UX design

### Short Term
1. Migrate to React Navigation
2. Add Google OAuth
3. Implement offline caching
4. Error handling improvements

### Long Term
1. Beta testing with real users
2. App store submission
3. OTA update pipeline
4. Social features (leaderboards)

---

## Contributing

This is a personal project, but suggestions and feedback are welcome!

---

## License

Private - All Rights Reserved

---

**Last Updated**: 2025-09-30
**Version**: 0.1.0 (MVP Phase 1)
