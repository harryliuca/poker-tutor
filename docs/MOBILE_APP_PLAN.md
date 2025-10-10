# Mobile App Plan

## Overview

React Native + Expo mobile app for iOS and Android with OTA updates capability.

## App Navigation Structure

```
App
├── Auth Stack (Not logged in)
│   └── Login Screen
│
└── Main Stack (Logged in)
    ├── Home (Tab)
    ├── Practice (Tab)
    ├── Profile (Tab)
    └── Modal Stack
        ├── Question Screen
        ├── Answer Result Screen
        └── Challenge Complete Screen
```

## Screens & Components

### 1. Login Screen

**Purpose**: Google authentication

**UI Elements:**
- App logo and name "Poker Tutor"
- Tagline: "Master Texas Hold'em, one decision at a time"
- "Sign in with Google" button
- Brief features list (Daily challenges, Track progress, Learn from experts)

**State:**
- Loading state during authentication
- Error handling for failed login

**Navigation:**
- On success → Home Screen
- Auto-login if session exists

```typescript
// Pseudocode
<LoginScreen>
  <Logo />
  <Tagline />
  <FeaturesList />
  <GoogleSignInButton onPress={handleGoogleSignIn} />
  {loading && <LoadingSpinner />}
  {error && <ErrorMessage />}
</LoginScreen>
```

---

### 2. Home Screen (Tab 1)

**Purpose**: Dashboard showing daily challenge, streak, and quick stats

**UI Elements:**

**Header:**
- Welcome message: "Welcome back, [Name]!"
- Current streak: "🔥 5 day streak"

**Daily Challenge Card:**
- "Today's Challenge"
- Progress: "3/10 questions answered"
- Start/Continue button
- Time remaining (optional): "Resets in 8 hours"

**Stats Summary:**
- Total questions answered
- Overall accuracy %
- Longest streak

**Quick Actions:**
- "Random Practice" button
- "View Progress" button

**State:**
- User profile data
- Today's challenge progress
- Loading states

**Navigation:**
- "Start Challenge" → Question Screen (daily mode)
- "Random Practice" → Practice Screen
- "View Progress" → Profile Tab

```typescript
// Pseudocode
<HomeScreen>
  <Header streak={currentStreak} userName={displayName} />

  <DailyChallengeCard
    progress={questionsAnswered}
    total={10}
    onPress={() => navigate('Question', { mode: 'daily' })}
  />

  <StatsGrid
    questionsAnswered={totalQuestions}
    accuracy={accuracy}
    longestStreak={longestStreak}
  />

  <QuickActions>
    <Button onPress={() => navigate('Practice')}>Random Practice</Button>
  </QuickActions>
</HomeScreen>
```

---

### 3. Practice Screen (Tab 2)

**Purpose**: Select practice mode and difficulty

**UI Elements:**

**Practice Modes:**
- **Daily Challenge** (highlighted)
  - Description: "Complete today's 10 questions"
  - Badge if incomplete: "Not completed"
  - Badge if completed: "✓ Completed"

- **Random Practice** (Free practice)
  - Description: "Practice without affecting your score"
  - Select difficulty: Beginner / Intermediate / Advanced
  - Select category (optional): All, Pre-Flop, Post-Flop, etc.

**Start Button:**
- "Start Practice"

**State:**
- Selected mode
- Selected difficulty
- Selected category

**Navigation:**
- "Start" → Question Screen with selected params

```typescript
// Pseudocode
<PracticeScreen>
  <ModeSelector selected={mode} onChange={setMode}>
    <ModeCard
      title="Daily Challenge"
      description="Complete today's 10 questions"
      completed={isDailyChallengeComplete}
    />
    <ModeCard
      title="Random Practice"
      description="Practice without affecting your score"
    />
  </ModeSelector>

  {mode === 'random' && (
    <>
      <DifficultySelector value={difficulty} onChange={setDifficulty} />
      <CategorySelector value={category} onChange={setCategory} />
    </>
  )}

  <StartButton onPress={handleStart} />
</PracticeScreen>
```

---

### 4. Question Screen (Modal/Full Screen)

**Purpose**: Display poker scenario and answer choices

**UI Elements:**

**Header:**
- Progress bar: "Question 3/10" (for daily challenge)
- Exit button (with confirmation)

**Scenario Section:**
- Your Hand: "♠A ♥K" (visual card display)
- Position: "Button"
- Stack: "100 BB"
- Pot: "10 BB"
- Action so far: "UTG raises to 6, MP calls"
- Community Cards: (if applicable) "♠A ♥9 ♦3"

**Question:**
- "What is the best action?"

**Answer Choices (4 buttons):**
- A. Fold
- B. Call 6
- C. Raise to 18
- D. All-in

**Timer (optional):**
- Track time taken (not displayed to user initially)

**State:**
- Current question data
- Selected answer
- Loading state while submitting

**Navigation:**
- Select answer → Submit → Answer Result Screen
- Exit → Back to previous screen (with confirmation)

```typescript
// Pseudocode
<QuestionScreen question={currentQuestion}>
  <Header>
    <ProgressBar current={3} total={10} />
    <ExitButton onPress={handleExit} />
  </Header>

  <ScenarioCard>
    <HandDisplay cards={question.scenario.yourHand} />
    <ScenarioDetails
      position={question.scenario.position}
      stackSize={question.scenario.stackSize}
      potSize={question.scenario.potSize}
      actionSoFar={question.scenario.actionSoFar}
    />
    {question.scenario.communityCards && (
      <CommunityCards cards={question.scenario.communityCards} />
    )}
  </ScenarioCard>

  <QuestionText>{question.question_text}</QuestionText>

  <AnswerChoices>
    {question.choices.map(choice => (
      <AnswerButton
        key={choice.id}
        choice={choice}
        onSelect={handleSelectAnswer}
      />
    ))}
  </AnswerChoices>
</QuestionScreen>
```

---

### 5. Answer Result Screen (Modal)

**Purpose**: Show if answer was correct and explain why

**UI Elements:**

**Result Header:**
- ✓ "Correct!" (green) or ✗ "Incorrect" (red)
- User's answer highlighted
- Correct answer highlighted (if wrong)

**Explanation:**
- Detailed explanation of the correct play
- Key concepts tags (e.g., "Hand Strength", "Position")

**Score Update (Daily Challenge only):**
- "+10 points" animation
- Updated streak (if applicable)

**Actions:**
- "Next Question" button (or "Finish Challenge" if last question)
- "Review Question" button (collapse/expand question details)

**State:**
- Answer correctness
- Explanation text
- Score/streak updates

**Navigation:**
- "Next Question" → Next Question Screen
- "Finish Challenge" → Challenge Complete Screen

```typescript
// Pseudocode
<AnswerResultScreen
  isCorrect={isCorrect}
  userAnswer={selectedAnswer}
  correctAnswer={correctAnswer}
  explanation={explanation}
>
  <ResultHeader isCorrect={isCorrect}>
    {isCorrect ? '✓ Correct!' : '✗ Incorrect'}
  </ResultHeader>

  <AnswerComparison>
    <YourAnswer answer={userAnswer} isCorrect={isCorrect} />
    {!isCorrect && <CorrectAnswer answer={correctAnswer} />}
  </AnswerComparison>

  <ExplanationCard>
    <ExplanationText>{explanation}</ExplanationText>
    <KeyConcepts concepts={keyConcepts} />
  </ExplanationCard>

  {isDailyChallenge && (
    <ScoreUpdate points={pointsEarned} streak={newStreak} />
  )}

  <NextButton onPress={handleNext}>
    {isLastQuestion ? 'Finish Challenge' : 'Next Question'}
  </NextButton>
</AnswerResultScreen>
```

---

### 6. Challenge Complete Screen (Modal)

**Purpose**: Celebrate completion of daily challenge

**UI Elements:**

**Celebration:**
- Confetti animation (if good score)
- "Challenge Complete!" title

**Results Summary:**
- Score: "80/100 points"
- Accuracy: "8/10 correct (80%)"
- Streak updated: "🔥 6 day streak"

**Performance Breakdown:**
- Accuracy by category (Pre-Flop: 100%, Post-Flop: 67%, etc.)

**Actions:**
- "Back to Home" button
- "Practice More" button (random practice)
- "Share Results" button (optional)

**State:**
- Challenge results
- Updated stats

**Navigation:**
- "Back to Home" → Home Screen
- "Practice More" → Practice Screen

```typescript
// Pseudocode
<ChallengeCompleteScreen results={challengeResults}>
  <ConfettiAnimation />

  <Header>Challenge Complete!</Header>

  <ResultsSummary>
    <ScoreDisplay score={results.score} maxScore={100} />
    <AccuracyDisplay correct={results.correct} total={results.total} />
    <StreakDisplay streak={results.newStreak} />
  </ResultsSummary>

  <CategoryBreakdown categories={results.categoryStats} />

  <Actions>
    <Button onPress={() => navigate('Home')}>Back to Home</Button>
    <Button onPress={() => navigate('Practice')}>Practice More</Button>
  </Actions>
</ChallengeCompleteScreen>
```

---

### 7. Profile Screen (Tab 3)

**Purpose**: View progress, stats, and settings

**UI Elements:**

**Profile Header:**
- Avatar (from Google)
- Name
- Email
- "Edit" button (optional)

**Stats Overview:**
- Current streak
- Longest streak
- Total questions answered
- Overall accuracy

**Performance by Category:**
- Table/cards showing:
  - Pre-Flop: 85% (50 questions)
  - Post-Flop: 72% (45 questions)
  - Turn: 68% (30 questions)
  - River: 80% (40 questions)
  - Special: 75% (20 questions)

**Performance by Difficulty:**
- Beginner: 90% (60 questions)
- Intermediate: 75% (80 questions)
- Advanced: 60% (45 questions)

**Recent Activity:**
- Last 10 questions answered (date, category, correct/incorrect)

**Settings:**
- Logout button
- Notifications (toggle)
- About / Help
- Privacy Policy / Terms

**State:**
- User profile data
- Stats by category and difficulty
- Recent answers

**Navigation:**
- "Logout" → Login Screen
- Settings items → respective screens

```typescript
// Pseudocode
<ProfileScreen profile={userProfile}>
  <ProfileHeader
    avatar={profile.avatar_url}
    name={profile.display_name}
    email={profile.email}
  />

  <StatsOverview
    currentStreak={profile.current_streak}
    longestStreak={profile.longest_streak}
    questionsAnswered={profile.questions_answered}
    accuracy={profile.accuracy}
  />

  <CategoryPerformance stats={categoryStats} />
  <DifficultyPerformance stats={difficultyStats} />

  <RecentActivity answers={recentAnswers} />

  <Settings>
    <SettingItem title="Notifications" toggle />
    <SettingItem title="About" onPress={() => navigate('About')} />
    <SettingItem title="Logout" onPress={handleLogout} destructive />
  </Settings>
</ProfileScreen>
```

---

## UI/UX Design Principles

### Color Scheme
- **Primary**: Poker green (#0B7F4F)
- **Secondary**: Gold/yellow for streaks and achievements (#FFD700)
- **Accent**: White text on dark backgrounds
- **Success**: Green (#10B981)
- **Error**: Red (#EF4444)
- **Background**: Dark theme (optional light theme)

### Typography
- **Headers**: Bold, 24-32px
- **Body**: Regular, 16px
- **Small text**: 12-14px

### Card Design
- Poker cards: Visual representation (♠A ♥K)
- Use card suits and colors
- Material design elevated cards for sections

### Animations
- Smooth transitions between screens
- Card flip animation for revealing answers
- Confetti for challenge completion
- Streak fire animation

### Accessibility
- High contrast text
- Large touch targets (min 44x44px)
- Screen reader support
- Color-blind friendly (don't rely only on color)

---

## State Management

### Global State (React Context / Redux)
- User authentication state
- User profile data
- Current daily challenge progress
- App settings (notifications, theme)

### Local State
- Screen-specific data (current question, selected answer)
- UI state (loading, errors, modals)

### Data Persistence
- AsyncStorage for:
  - Auth token (handled by Supabase)
  - Cached questions for offline mode
  - User preferences

---

## Offline Support

### Cached Data
- Daily challenge questions (cache on first load)
- User profile and stats
- Recent answers history

### Offline Behavior
- Allow viewing cached questions
- Queue answer submissions for when online
- Show "Offline" indicator
- Sync when connection restored

### Implementation
```typescript
// Using @react-native-async-storage/async-storage
// and NetInfo for connection status

import NetInfo from '@react-native-community/netinfo'

const isOnline = await NetInfo.fetch().then(state => state.isConnected)

if (!isOnline) {
  // Queue answer for later submission
  await AsyncStorage.setItem('pendingAnswers', JSON.stringify(answers))
} else {
  // Submit immediately
  await supabase.from('user_answers').insert(answer)
}
```

---

## Push Notifications (Future)

### Notification Types
1. **Daily Reminder**: "Don't break your streak! Complete today's challenge"
2. **Streak Achievement**: "🔥 7 day streak! Keep it up!"
3. **New Content**: "10 new advanced questions added!"

### Implementation
- Expo Notifications API
- Scheduled local notifications (daily at user's preferred time)
- Optional server-triggered notifications via Supabase

---

## Performance Optimization

### Lazy Loading
- Load questions on demand
- Paginate history/stats

### Image Optimization
- Use SVG for card suits
- Optimize avatar images

### Code Splitting
- Separate bundles for auth vs main app
- Lazy load heavy components

### Caching Strategy
- Cache questions for 24 hours
- Invalidate on app update
- Prefetch next day's challenge in background

---

## Testing Strategy

### Unit Tests
- Utility functions (scoring, streak calculation)
- Component logic (answer validation)

### Integration Tests
- Auth flow
- Question fetch and submission
- Streak updates

### E2E Tests (Detox)
- Complete user journey (login → answer questions → view results)
- Daily challenge flow
- Random practice flow

---

## App Distribution

### Development
- Expo Go app for testing
- Development builds for testing OTA updates

### Production

**iOS:**
1. Build with EAS Build
2. Submit to App Store
3. Enable OTA updates via Expo Updates

**Android:**
1. Build APK/AAB with EAS Build
2. Submit to Google Play
3. Enable OTA updates via Expo Updates

### OTA Updates
- Push JavaScript updates without app store review
- Update questions, fix bugs, add features
- Use channels (production, staging, beta)

```bash
# Push OTA update
eas update --branch production --message "Add new questions"
```

---

## Development Phases

### Phase 1: MVP (Current) - 80% Complete ✅
- [x] Setup Expo project
- [x] Implement authentication (email/password)
- [x] Build question display component
- [x] Implement answer submission and result screen
- [x] Create Home screen with daily challenge
- [x] Connect to Supabase backend
- [x] Add random practice mode
- [x] Daily challenge progress persistence
- [x] Challenge completion screen
- [x] Unit testing framework (31 tests passing)
- [ ] Build Profile screen with basic stats (IN PROGRESS)
- [ ] Google authentication option
- [ ] Complete question library (10/150 done)

**Status**: Core features working. Need profile screen and more questions.

### Phase 2: Polish (2-3 weeks)
- [ ] Migrate to React Navigation (proper tabs/stack)
- [ ] Implement offline support
- [ ] Add animations and transitions
- [ ] Improve UI/UX based on feedback
- [ ] Implement adaptive difficulty
- [ ] Error handling and retry logic
- [ ] Loading states and skeletons
- [ ] Comprehensive testing (services, components)

### Phase 3: Launch (1-2 weeks)
- [ ] Beta testing with users
- [ ] Fix critical bugs
- [ ] Setup OTA update pipeline (EAS Updates)
- [ ] Submit to app stores
- [ ] Marketing materials (screenshots, description)
- [ ] Launch! 🚀

---

## Implementation Status

### ✅ Completed Screens
1. **SimpleLoginScreen** - Email/password auth
2. **HomeScreen** - Daily challenge card with progress
3. **ChallengeFlowScreen** - Main practice flow logic
4. **QuestionScreen** - Scenario and answer choices
5. **AnswerResultScreen** - Feedback with explanations
6. **ChallengeCompletedScreen** - Summary with score/accuracy

### ⏳ In Progress
7. **ProfileScreen** - Stats and progress breakdown

### 🔜 Not Started
8. **Proper Navigation** - React Navigation tabs
9. **Settings Screen**
10. **About/Help Screens**

### ✅ Completed Services
- `auth.ts` - Login, signup, logout
- `supabase.ts` - Client configuration
- `questions.ts` - Fetch questions (with client-side shuffle)
- `dailyChallenge.ts` - Get/create daily challenges

### ✅ Completed Utilities
- `scoring.ts` - Score and accuracy calculation
- `streak.ts` - Streak tracking logic
- `formatting.ts` - Date and time formatting

### ✅ Tests
- All utility functions have 100% test coverage
- 31/31 tests passing
- Timezone issues resolved

---

## File Structure

```
poker-tutor/
├── App.tsx                       # Entry point
├── app.json                      # Expo config
├── package.json
│
├── src/
│   ├── navigation/
│   │   ├── AppNavigator.tsx      # Main navigation
│   │   ├── AuthStack.tsx
│   │   └── MainStack.tsx
│   │
│   ├── screens/
│   │   ├── auth/
│   │   │   └── LoginScreen.tsx
│   │   ├── home/
│   │   │   └── HomeScreen.tsx
│   │   ├── practice/
│   │   │   ├── PracticeScreen.tsx
│   │   │   ├── QuestionScreen.tsx
│   │   │   ├── AnswerResultScreen.tsx
│   │   │   └── ChallengeCompleteScreen.tsx
│   │   └── profile/
│   │       └── ProfileScreen.tsx
│   │
│   ├── components/
│   │   ├── cards/
│   │   │   ├── HandDisplay.tsx
│   │   │   ├── CommunityCards.tsx
│   │   │   └── ScenarioCard.tsx
│   │   ├── buttons/
│   │   │   ├── AnswerButton.tsx
│   │   │   └── PrimaryButton.tsx
│   │   ├── stats/
│   │   │   ├── StatsCard.tsx
│   │   │   └── ProgressBar.tsx
│   │   └── common/
│   │       ├── LoadingSpinner.tsx
│   │       └── ErrorMessage.tsx
│   │
│   ├── services/
│   │   ├── supabase.ts           # Supabase client
│   │   ├── auth.ts               # Auth methods
│   │   ├── questions.ts          # Question fetching
│   │   ├── answers.ts            # Answer submission
│   │   └── stats.ts              # Stats fetching
│   │
│   ├── hooks/
│   │   ├── useAuth.ts
│   │   ├── useQuestions.ts
│   │   ├── useDailyChallenge.ts
│   │   └── useStats.ts
│   │
│   ├── contexts/
│   │   ├── AuthContext.tsx
│   │   └── AppContext.tsx
│   │
│   ├── types/
│   │   ├── question.ts
│   │   ├── user.ts
│   │   └── answer.ts
│   │
│   ├── utils/
│   │   ├── scoring.ts
│   │   ├── streak.ts
│   │   └── formatting.ts
│   │
│   └── constants/
│       ├── colors.ts
│       └── config.ts
│
└── assets/
    ├── images/
    ├── fonts/
    └── icons/
```