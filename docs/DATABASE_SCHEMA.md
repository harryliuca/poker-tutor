# Database Schema

## Overview

Using **Supabase** (PostgreSQL) for database management with built-in authentication and real-time capabilities.

## Tables

### 1. users
Managed by Supabase Auth, extended with custom profile data.

```sql
CREATE TABLE public.profiles (
  id UUID REFERENCES auth.users(id) PRIMARY KEY,
  email TEXT UNIQUE NOT NULL,
  display_name TEXT,
  google_id TEXT UNIQUE,
  avatar_url TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),

  -- Stats
  total_score INTEGER DEFAULT 0,
  current_streak INTEGER DEFAULT 0,
  longest_streak INTEGER DEFAULT 0,
  last_practice_date DATE,

  -- Skill tracking
  current_difficulty TEXT DEFAULT 'beginner' CHECK (current_difficulty IN ('beginner', 'intermediate', 'advanced')),
  questions_answered INTEGER DEFAULT 0,
  correct_answers INTEGER DEFAULT 0
);

-- Enable Row Level Security
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

-- Users can only read/update their own profile
CREATE POLICY "Users can view own profile" ON public.profiles
  FOR SELECT USING (auth.uid() = id);

CREATE POLICY "Users can update own profile" ON public.profiles
  FOR UPDATE USING (auth.uid() = id);
```

### 2. questions

```sql
CREATE TABLE public.questions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  category TEXT NOT NULL CHECK (category IN ('pre-flop', 'post-flop', 'turn', 'river', 'special')),
  difficulty TEXT NOT NULL CHECK (difficulty IN ('beginner', 'intermediate', 'advanced')),

  -- Scenario data (stored as JSONB for flexibility)
  scenario JSONB NOT NULL,
  -- Example: {"yourHand": "AK", "position": "Button", "stackSize": 100, ...}

  question_text TEXT NOT NULL,

  -- Choices as JSONB array
  choices JSONB NOT NULL,
  -- Example: [{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 6"}]

  correct_answer TEXT NOT NULL, -- e.g., "C"
  explanation TEXT NOT NULL,
  key_concepts TEXT[] NOT NULL, -- Array of concepts

  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),

  -- For future features
  difficulty_rating DECIMAL(3,2), -- Actual difficulty based on user performance
  times_answered INTEGER DEFAULT 0,
  times_correct INTEGER DEFAULT 0
);

-- Indexes for efficient querying
CREATE INDEX idx_questions_category ON public.questions(category);
CREATE INDEX idx_questions_difficulty ON public.questions(difficulty);
CREATE INDEX idx_questions_category_difficulty ON public.questions(category, difficulty);

-- RLS: Questions are readable by authenticated users
ALTER TABLE public.questions ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Authenticated users can view questions" ON public.questions
  FOR SELECT USING (auth.role() = 'authenticated');
```

### 3. user_answers

Tracks all answers for analytics and progress tracking.

```sql
CREATE TABLE public.user_answers (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
  question_id UUID REFERENCES public.questions(id) ON DELETE CASCADE NOT NULL,

  selected_answer TEXT NOT NULL,
  is_correct BOOLEAN NOT NULL,

  -- Context
  practice_mode TEXT NOT NULL CHECK (practice_mode IN ('daily_challenge', 'random_practice')),
  answered_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  time_taken_seconds INTEGER, -- Optional: track how long they took

  -- For daily challenge tracking
  challenge_date DATE
);

-- Indexes
CREATE INDEX idx_user_answers_user_id ON public.user_answers(user_id);
CREATE INDEX idx_user_answers_question_id ON public.user_answers(question_id);
CREATE INDEX idx_user_answers_user_date ON public.user_answers(user_id, challenge_date);

-- RLS: Users can only view/insert their own answers
ALTER TABLE public.user_answers ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view own answers" ON public.user_answers
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own answers" ON public.user_answers
  FOR INSERT WITH CHECK (auth.uid() = user_id);
```

### 4. daily_challenges

Tracks daily challenge generations and completions.

```sql
CREATE TABLE public.daily_challenges (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  challenge_date DATE UNIQUE NOT NULL,

  -- Questions selected for this day (array of question IDs)
  question_ids UUID[] NOT NULL,

  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Index
CREATE INDEX idx_daily_challenges_date ON public.daily_challenges(challenge_date);

-- RLS: Anyone authenticated can view daily challenges
ALTER TABLE public.daily_challenges ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Authenticated users can view daily challenges" ON public.daily_challenges
  FOR SELECT USING (auth.role() = 'authenticated');
```

### 5. user_daily_progress

Tracks user progress on daily challenges.

```sql
CREATE TABLE public.user_daily_progress (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
  challenge_id UUID REFERENCES public.daily_challenges(id) ON DELETE CASCADE NOT NULL,
  challenge_date DATE NOT NULL,

  questions_answered INTEGER DEFAULT 0,
  questions_correct INTEGER DEFAULT 0,
  total_questions INTEGER NOT NULL,

  score INTEGER DEFAULT 0, -- Points earned
  completed BOOLEAN DEFAULT FALSE,
  completed_at TIMESTAMP WITH TIME ZONE,

  started_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),

  UNIQUE(user_id, challenge_date)
);

-- Indexes
CREATE INDEX idx_user_daily_progress_user ON public.user_daily_progress(user_id);
CREATE INDEX idx_user_daily_progress_date ON public.user_daily_progress(challenge_date);

-- RLS: Users can only view/update their own progress
ALTER TABLE public.user_daily_progress ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view own progress" ON public.user_daily_progress
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own progress" ON public.user_daily_progress
  FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own progress" ON public.user_daily_progress
  FOR UPDATE USING (auth.uid() = user_id);
```

### 6. user_category_stats

Tracks performance by category and difficulty for adaptive learning.

```sql
CREATE TABLE public.user_category_stats (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,

  category TEXT NOT NULL CHECK (category IN ('pre-flop', 'post-flop', 'turn', 'river', 'special')),
  difficulty TEXT NOT NULL CHECK (difficulty IN ('beginner', 'intermediate', 'advanced')),

  questions_answered INTEGER DEFAULT 0,
  questions_correct INTEGER DEFAULT 0,
  accuracy DECIMAL(5,2) GENERATED ALWAYS AS (
    CASE
      WHEN questions_answered = 0 THEN 0
      ELSE (questions_correct::DECIMAL / questions_answered * 100)
    END
  ) STORED,

  last_practiced TIMESTAMP WITH TIME ZONE,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),

  UNIQUE(user_id, category, difficulty)
);

-- Indexes
CREATE INDEX idx_user_category_stats_user ON public.user_category_stats(user_id);

-- RLS: Users can only view their own stats
ALTER TABLE public.user_category_stats ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view own stats" ON public.user_category_stats
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own stats" ON public.user_category_stats
  FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own stats" ON public.user_category_stats
  FOR UPDATE USING (auth.uid() = user_id);
```

## Database Functions

### Auto-update updated_at timestamp

```sql
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Apply to relevant tables
CREATE TRIGGER update_profiles_updated_at BEFORE UPDATE ON public.profiles
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_questions_updated_at BEFORE UPDATE ON public.questions
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
```

### Calculate and update streak

```sql
CREATE OR REPLACE FUNCTION update_user_streak(p_user_id UUID, p_practice_date DATE)
RETURNS VOID AS $$
DECLARE
  last_date DATE;
  current_streak INT;
  longest_streak INT;
BEGIN
  SELECT last_practice_date, profiles.current_streak, profiles.longest_streak
  INTO last_date, current_streak, longest_streak
  FROM public.profiles
  WHERE id = p_user_id;

  -- If practiced today, don't update
  IF last_date = p_practice_date THEN
    RETURN;
  END IF;

  -- Check if consecutive day
  IF last_date = p_practice_date - 1 THEN
    current_streak := current_streak + 1;
  ELSE
    current_streak := 1;
  END IF;

  -- Update longest streak
  IF current_streak > longest_streak THEN
    longest_streak := current_streak;
  END IF;

  -- Update profile
  UPDATE public.profiles
  SET
    current_streak = current_streak,
    longest_streak = longest_streak,
    last_practice_date = p_practice_date
  WHERE id = p_user_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
```

## Initial Data Seeding

After question generation via OpenAI API:

```sql
-- Insert questions (example)
INSERT INTO public.questions (category, difficulty, scenario, question_text, choices, correct_answer, explanation, key_concepts)
VALUES (
  'pre-flop',
  'beginner',
  '{"yourHand": "AKs", "position": "Button", "stackSize": 100, "blinds": "1/2", "actionSoFar": "Folds to you"}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 2"}, {"id": "C", "action": "Raise to 6"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'C',
  'AKs is a premium hand and should be raised from the button for value. Raising builds the pot when you have an advantage and allows you to control the action post-flop.',
  ARRAY['hand strength', 'position', 'aggression']
);
```

## Backup and Migration Strategy

- Supabase provides automatic backups
- Export questions periodically to JSON for version control
- Use Supabase migrations for schema changes
- Keep local seed data file for development/testing

## Performance Considerations

- Questions table: ~150 rows initially (will grow to 500+)
- User answers: High volume (millions over time)
  - Partition by date if needed in future
  - Archive old data after 1 year
- Indexes on foreign keys and frequently queried columns
- Use JSONB for flexible scenario data (supports indexing if needed)

## Privacy & Data Retention

- User data belongs to the user
- No PII beyond email (from Google auth)
- Users can request data deletion (delete profile cascade)
- Anonymous analytics only (no user identification)