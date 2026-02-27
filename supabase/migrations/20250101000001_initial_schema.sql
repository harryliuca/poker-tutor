-- Poker Tutor Database Schema
-- Run this in Supabase SQL Editor

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ============================================
-- 1. PROFILES TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS public.profiles (
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

-- Policies
CREATE POLICY "Users can view own profile" ON public.profiles
  FOR SELECT USING (auth.uid() = id);

CREATE POLICY "Users can update own profile" ON public.profiles
  FOR UPDATE USING (auth.uid() = id);

-- ============================================
-- 2. QUESTIONS TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS public.questions (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  category TEXT NOT NULL CHECK (category IN ('pre-flop', 'post-flop', 'turn', 'river', 'special')),
  difficulty TEXT NOT NULL CHECK (difficulty IN ('beginner', 'intermediate', 'advanced')),

  -- Scenario data (JSONB for flexibility)
  scenario JSONB NOT NULL,
  question_text TEXT NOT NULL,
  choices JSONB NOT NULL,
  correct_answer TEXT NOT NULL,
  explanation TEXT NOT NULL,
  key_concepts TEXT[] NOT NULL,

  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),

  -- For future features
  difficulty_rating DECIMAL(3,2),
  times_answered INTEGER DEFAULT 0,
  times_correct INTEGER DEFAULT 0
);

-- Indexes
CREATE INDEX IF NOT EXISTS idx_questions_category ON public.questions(category);
CREATE INDEX IF NOT EXISTS idx_questions_difficulty ON public.questions(difficulty);
CREATE INDEX IF NOT EXISTS idx_questions_category_difficulty ON public.questions(category, difficulty);

-- RLS
ALTER TABLE public.questions ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Authenticated users can view questions" ON public.questions
  FOR SELECT USING (auth.role() = 'authenticated');

-- ============================================
-- 3. USER_ANSWERS TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS public.user_answers (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
  question_id UUID REFERENCES public.questions(id) ON DELETE CASCADE NOT NULL,

  selected_answer TEXT NOT NULL,
  is_correct BOOLEAN NOT NULL,

  practice_mode TEXT NOT NULL CHECK (practice_mode IN ('daily_challenge', 'random_practice')),
  answered_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  time_taken_seconds INTEGER,
  challenge_date DATE
);

-- Indexes
CREATE INDEX IF NOT EXISTS idx_user_answers_user_id ON public.user_answers(user_id);
CREATE INDEX IF NOT EXISTS idx_user_answers_question_id ON public.user_answers(question_id);
CREATE INDEX IF NOT EXISTS idx_user_answers_user_date ON public.user_answers(user_id, challenge_date);

-- RLS
ALTER TABLE public.user_answers ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view own answers" ON public.user_answers
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own answers" ON public.user_answers
  FOR INSERT WITH CHECK (auth.uid() = user_id);

-- ============================================
-- 4. DAILY_CHALLENGES TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS public.daily_challenges (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  challenge_date DATE UNIQUE NOT NULL,
  question_ids UUID[] NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Index
CREATE INDEX IF NOT EXISTS idx_daily_challenges_date ON public.daily_challenges(challenge_date);

-- RLS
ALTER TABLE public.daily_challenges ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Authenticated users can view daily challenges" ON public.daily_challenges
  FOR SELECT USING (auth.role() = 'authenticated');

-- ============================================
-- 5. USER_DAILY_PROGRESS TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS public.user_daily_progress (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
  challenge_id UUID REFERENCES public.daily_challenges(id) ON DELETE CASCADE NOT NULL,
  challenge_date DATE NOT NULL,

  questions_answered INTEGER DEFAULT 0,
  questions_correct INTEGER DEFAULT 0,
  total_questions INTEGER NOT NULL,

  score INTEGER DEFAULT 0,
  completed BOOLEAN DEFAULT FALSE,
  completed_at TIMESTAMP WITH TIME ZONE,

  started_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),

  UNIQUE(user_id, challenge_date)
);

-- Indexes
CREATE INDEX IF NOT EXISTS idx_user_daily_progress_user ON public.user_daily_progress(user_id);
CREATE INDEX IF NOT EXISTS idx_user_daily_progress_date ON public.user_daily_progress(challenge_date);

-- RLS
ALTER TABLE public.user_daily_progress ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view own progress" ON public.user_daily_progress
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own progress" ON public.user_daily_progress
  FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own progress" ON public.user_daily_progress
  FOR UPDATE USING (auth.uid() = user_id);

-- ============================================
-- 6. USER_CATEGORY_STATS TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS public.user_category_stats (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
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
CREATE INDEX IF NOT EXISTS idx_user_category_stats_user ON public.user_category_stats(user_id);

-- RLS
ALTER TABLE public.user_category_stats ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view own stats" ON public.user_category_stats
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own stats" ON public.user_category_stats
  FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own stats" ON public.user_category_stats
  FOR UPDATE USING (auth.uid() = user_id);

-- ============================================
-- TRIGGERS & FUNCTIONS
-- ============================================

-- Auto-update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_profiles_updated_at BEFORE UPDATE ON public.profiles
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_questions_updated_at BEFORE UPDATE ON public.questions
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Create profile on user signup
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, email, display_name, avatar_url, google_id)
  VALUES (
    NEW.id,
    NEW.email,
    NEW.raw_user_meta_data->>'full_name',
    NEW.raw_user_meta_data->>'avatar_url',
    NEW.raw_user_meta_data->>'sub'
  );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- ============================================
-- SAMPLE DATA (Optional - for testing)
-- ============================================

-- Insert a sample question
INSERT INTO public.questions (category, difficulty, scenario, question_text, choices, correct_answer, explanation, key_concepts)
VALUES (
  'pre-flop',
  'beginner',
  '{"yourHand": "AKs", "position": "Button", "stackSize": 100, "blinds": "1/2", "potSize": 3, "actionSoFar": "Folds to you", "playersRemaining": 3, "effectiveStacks": 100}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 2"}, {"id": "C", "action": "Raise to 6"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'C',
  'AKs is a premium hand and should be raised from the button for value. Raising builds the pot when you have an advantage and allows you to control the action post-flop. A standard raise to 3BB (6 chips) is appropriate.',
  ARRAY['hand strength', 'position', 'aggression']
);