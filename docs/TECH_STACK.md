# Technology Stack

## Complete Technology Choices and Rationale

---

## Mobile Application

### React Native + Expo

**Version:** React Native 0.74+ with Expo SDK 51+

**Why:**
- ✅ Single codebase for iOS and Android
- ✅ Over-The-Air (OTA) updates via Expo Updates
- ✅ Fast development with hot reload
- ✅ Rich ecosystem of packages
- ✅ Easy deployment with EAS Build
- ✅ Built-in development tools and debugging

**Key Features Used:**
- Expo Router for navigation
- Expo Auth Session for Google OAuth
- Expo Updates for OTA deployments
- EAS Build for native builds

**Installation:**
```bash
npx create-expo-app poker-tutor --template blank-typescript
```

---

## Backend & Database

### Supabase

**Version:** Supabase JS Client v2+

**Why:**
- ✅ Free tier (500MB database, 50k MAU)
- ✅ PostgreSQL database with full SQL power
- ✅ Built-in authentication (Google OAuth)
- ✅ Automatic REST API generation
- ✅ Row Level Security for data protection
- ✅ Real-time capabilities (for future features)
- ✅ Edge Functions (Deno-based serverless)
- ✅ Easy to scale

**Services Used:**
- **Database**: PostgreSQL for structured data
- **Auth**: Built-in auth with Google provider
- **Storage**: For future features (user avatars, etc.)
- **Edge Functions**: Serverless functions for complex logic
- **Realtime**: For future real-time features

**Cost:**
- Free tier sufficient for MVP
- Pro: $25/month if scaling needed

---

## Authentication

### Google OAuth via Supabase Auth

**Why Google-only:**
- ✅ Most users have Google accounts
- ✅ No password management
- ✅ Fast signup/login
- ✅ Trusted provider
- ✅ Easy implementation with Supabase

**Implementation:**
```typescript
import { createClient } from '@supabase/supabase-js'

const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY)

// Sign in
await supabase.auth.signInWithOAuth({
  provider: 'google',
  options: { redirectTo: 'pokertutor://auth/callback' }
})
```

---

## State Management

### React Context API + Custom Hooks

**Why not Redux/MobX:**
- ✅ App state is relatively simple
- ✅ Context API sufficient for auth and user data
- ✅ Custom hooks for data fetching
- ✅ Less boilerplate
- ✅ Easier to understand for maintainability

**Structure:**
```typescript
// AuthContext for user authentication state
// Custom hooks (useQuestions, useDailyChallenge, useStats) for data

import { useAuth } from '@/hooks/useAuth'
import { useQuestions } from '@/hooks/useQuestions'
```

---

## Navigation

### Expo Router

**Why:**
- ✅ File-based routing (like Next.js)
- ✅ Built-in deep linking
- ✅ Type-safe navigation
- ✅ Easy modal management
- ✅ Native feel with stack/tab navigators

**Structure:**
```
app/
├── (auth)/
│   └── login.tsx
├── (tabs)/
│   ├── index.tsx       # Home
│   ├── practice.tsx
│   └── profile.tsx
└── question/[id].tsx   # Modal
```

---

## UI Components & Styling

### React Native Paper + Custom Components

**UI Library:** React Native Paper v5+

**Why:**
- ✅ Material Design components
- ✅ Customizable theming
- ✅ Good TypeScript support
- ✅ Accessible components
- ✅ Works well with React Native

**Styling:**
- StyleSheet for performance
- Custom theme configuration
- Dark mode support

**Alternative considered:** NativeBase, React Native Elements
- Chose Paper for cleaner design and better theming

```bash
npm install react-native-paper
npm install react-native-safe-area-context
```

---

## Data Fetching

### Supabase JS Client + React Query

**React Query (TanStack Query):** For caching and data synchronization

**Why:**
- ✅ Automatic caching
- ✅ Background refetching
- ✅ Optimistic updates
- ✅ Error handling
- ✅ Loading states

**Example:**
```typescript
import { useQuery } from '@tanstack/react-query'

const { data: questions, isLoading } = useQuery({
  queryKey: ['questions', category, difficulty],
  queryFn: () => fetchQuestions(category, difficulty)
})
```

---

## Offline Support

### AsyncStorage + React Query Persistence

**AsyncStorage:** React Native's persistent key-value storage

**Why:**
- ✅ Simple API
- ✅ Works on iOS and Android
- ✅ Can store JSON data
- ✅ Integrates with React Query

**Used for:**
- Cached questions
- User preferences
- Pending answer submissions (offline queue)

```bash
npm install @react-native-async-storage/async-storage
```

---

## Network Detection

### NetInfo

**Package:** @react-native-community/netinfo

**Why:**
- ✅ Reliable network status detection
- ✅ Event-based updates
- ✅ Works on iOS and Android

**Usage:**
```typescript
import NetInfo from '@react-native-community/netinfo'

NetInfo.addEventListener(state => {
  if (state.isConnected) {
    // Sync pending data
  }
})
```

---

## Question Generation

### OpenAI API

**Model:** GPT-4 (or GPT-4-turbo)

**Why:**
- ✅ Best poker knowledge among LLMs
- ✅ Can generate realistic scenarios
- ✅ Detailed explanations
- ✅ Consistent JSON output

**Usage:**
- One-time batch generation of 150 questions
- Script to generate and validate questions
- Manual review before database insertion

**Cost:**
- ~$1-2 for generating 150 questions (one-time)

**Alternative:** Claude 3.5 Sonnet (also excellent for poker reasoning)

---

## Development Tools

### TypeScript

**Why:**
- ✅ Type safety
- ✅ Better IDE support
- ✅ Catch errors at compile time
- ✅ Self-documenting code

### ESLint + Prettier

**Why:**
- ✅ Code consistency
- ✅ Catch common errors
- ✅ Automatic formatting

### Expo Dev Tools

**Features:**
- Fast Refresh
- Network inspector
- Element inspector
- Performance monitor

---

## Testing

### Jest + React Native Testing Library

**Unit Tests:**
```bash
npm install --save-dev jest @testing-library/react-native
```

**Why:**
- ✅ Fast unit testing
- ✅ Component testing
- ✅ Snapshot testing

### Detox (E2E Testing)

**Why:**
- ✅ Real device testing
- ✅ Automated user flows
- ✅ iOS and Android support

**Future implementation** (after MVP)

---

## Analytics

### Expo Analytics (Future)

**Why:**
- ✅ Privacy-focused
- ✅ Built-in to Expo
- ✅ No third-party dependencies

**Metrics to track:**
- Daily active users
- Retention rate
- Questions answered per session
- Streak distribution

---

## Push Notifications (Future)

### Expo Notifications

**Why:**
- ✅ Cross-platform
- ✅ Local and remote notifications
- ✅ Scheduling support

**Use cases:**
- Daily challenge reminders
- Streak achievements
- New content alerts

---

## Deployment & CI/CD

### EAS Build & Update

**EAS Build:** Build native apps in the cloud

**Why:**
- ✅ No need for Mac (for iOS builds)
- ✅ Consistent build environment
- ✅ Easy certificate management

**EAS Update:** OTA updates

**Why:**
- ✅ Push updates without app store review
- ✅ Instant bug fixes
- ✅ A/B testing capability (future)

```bash
# Install EAS CLI
npm install -g eas-cli

# Build for production
eas build --platform all

# Push OTA update
eas update --branch production
```

### GitHub Actions (Future)

**CI/CD Pipeline:**
- Run tests on PR
- Build preview on merge
- Deploy to production on release

---

## Version Control

### Git + GitHub

**Branching Strategy:**
- `main`: Production-ready code
- `develop`: Development branch
- Feature branches: `feature/question-screen`

**Commit Convention:** Conventional Commits
- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation
- `refactor:` Code refactoring

---

## Environment Management

### .env files + expo-constants

**Files:**
```
.env.development
.env.production
```

**Variables:**
```env
EXPO_PUBLIC_SUPABASE_URL=https://xxx.supabase.co
EXPO_PUBLIC_SUPABASE_ANON_KEY=eyJhbGc...
```

**Usage:**
```typescript
import Constants from 'expo-constants'

const supabaseUrl = Constants.expoConfig?.extra?.supabaseUrl
```

---

## Dependencies Summary

### Core Dependencies
```json
{
  "dependencies": {
    "expo": "~51.0.0",
    "react": "18.2.0",
    "react-native": "0.74.0",
    "@supabase/supabase-js": "^2.38.0",
    "react-native-paper": "^5.12.0",
    "@tanstack/react-query": "^5.0.0",
    "@react-native-async-storage/async-storage": "^1.21.0",
    "@react-native-community/netinfo": "^11.3.0",
    "expo-router": "~3.5.0",
    "react-native-safe-area-context": "4.10.0",
    "react-native-screens": "~3.31.0"
  },
  "devDependencies": {
    "@types/react": "~18.2.0",
    "typescript": "^5.3.0",
    "jest": "^29.0.0",
    "@testing-library/react-native": "^12.0.0",
    "prettier": "^3.0.0",
    "eslint": "^8.0.0"
  }
}
```

---

## Architecture Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                        Mobile App                           │
│                   (React Native + Expo)                     │
│                                                             │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐    │
│  │   Screens    │  │  Components  │  │    Hooks     │    │
│  └──────────────┘  └──────────────┘  └──────────────┘    │
│         │                  │                  │            │
│         └──────────────────┴──────────────────┘            │
│                         │                                   │
│                  ┌──────▼───────┐                          │
│                  │  Supabase    │                          │
│                  │   Client     │                          │
│                  └──────┬───────┘                          │
└─────────────────────────┼───────────────────────────────────┘
                          │
                          │ HTTPS + JWT Auth
                          │
┌─────────────────────────▼───────────────────────────────────┐
│                       Supabase                              │
│                                                             │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐    │
│  │  PostgreSQL  │  │   Auth       │  │   Edge       │    │
│  │   Database   │  │  (Google)    │  │  Functions   │    │
│  └──────────────┘  └──────────────┘  └──────────────┘    │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## Development Environment Setup

### Prerequisites
- Node.js 18+ (LTS)
- npm or yarn
- Expo Go app (iOS/Android) for testing
- Git

### Setup Steps

1. **Clone repo** (future)
```bash
git clone https://github.com/yourusername/poker-tutor.git
cd poker-tutor
```

2. **Install dependencies**
```bash
npm install
```

3. **Setup Supabase**
- Create Supabase project
- Copy URL and anon key to .env
- Run database migrations

4. **Start development server**
```bash
npx expo start
```

5. **Run on device**
- Scan QR code with Expo Go (iOS/Android)
- Or press 'i' for iOS simulator, 'a' for Android emulator

---

## Production Readiness

### Pre-launch Checklist

- [ ] All core features implemented
- [ ] 150 questions generated and reviewed
- [ ] Supabase database migrated to production
- [ ] Environment variables configured
- [ ] App icons and splash screens
- [ ] Privacy policy and terms of service
- [ ] App store assets (screenshots, description)
- [ ] Beta testing completed
- [ ] Analytics configured
- [ ] Error tracking (Sentry or similar)
- [ ] OTA updates tested
- [ ] Performance testing
- [ ] Security audit (API keys, RLS policies)

---

## Scalability Considerations

### Current Architecture (MVP)
- Handles 10,000 users comfortably
- 100,000 questions answered per month
- Supabase free tier sufficient

### If scaling beyond free tier:
1. **Upgrade Supabase to Pro** ($25/month)
   - 8GB database
   - 100k monthly active users
   - More Edge Function invocations

2. **Add CDN for assets** (images, icons)

3. **Database optimizations:**
   - Partition user_answers table by date
   - Archive old data
   - Add more indexes

4. **Caching layer:**
   - Redis for frequently accessed data
   - CDN for question images (if added)

5. **Load testing:**
   - Test with 10k concurrent users
   - Optimize slow queries
   - Add database read replicas if needed

---

## Future Technology Additions

### When scaling:
- **Error Tracking**: Sentry
- **Analytics**: PostHog or Mixpanel
- **A/B Testing**: Statsig or LaunchDarkly
- **Customer Support**: Intercom or Zendesk
- **Video Tutorials**: Mux or Vimeo API
- **Social Features**: Real-time via Supabase Realtime
- **Payment Processing**: Stripe (for premium features)

### Alternative technologies considered:

**Instead of React Native:**
- Flutter: Great performance, but smaller ecosystem
- Native (Swift/Kotlin): Best performance, but 2x development time

**Instead of Supabase:**
- Firebase: Good alternative, but more expensive at scale
- AWS Amplify: More complex, steeper learning curve
- Custom backend (Node.js + Express): More control, more maintenance

**Choice:** React Native + Supabase is the best balance of speed, cost, and scalability for MVP.