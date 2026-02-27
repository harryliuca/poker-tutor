-- Trigger to automatically update profile stats when answers are submitted
-- Run this in Supabase SQL Editor

-- Function to update profile stats
CREATE OR REPLACE FUNCTION update_profile_stats()
RETURNS TRIGGER AS $$
BEGIN
  -- Update questions_answered and correct_answers
  UPDATE profiles
  SET
    questions_answered = (
      SELECT COUNT(*)
      FROM user_answers
      WHERE user_id = NEW.user_id
    ),
    correct_answers = (
      SELECT COUNT(*)
      FROM user_answers
      WHERE user_id = NEW.user_id AND is_correct = true
    ),
    updated_at = NOW()
  WHERE id = NEW.user_id;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Create trigger on user_answers insert
DROP TRIGGER IF EXISTS trigger_update_profile_stats ON user_answers;
CREATE TRIGGER trigger_update_profile_stats
  AFTER INSERT ON user_answers
  FOR EACH ROW
  EXECUTE FUNCTION update_profile_stats();

-- Function to update profile stats when daily progress is completed
CREATE OR REPLACE FUNCTION update_profile_on_challenge_complete()
RETURNS TRIGGER AS $$
BEGIN
  -- Only update when challenge is completed
  IF NEW.completed = true AND (OLD.completed IS NULL OR OLD.completed = false) THEN
    UPDATE profiles
    SET
      total_score = total_score + NEW.score,
      last_practice_date = NEW.challenge_date,
      updated_at = NOW()
    WHERE id = NEW.user_id;
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Create trigger on user_daily_progress update
DROP TRIGGER IF EXISTS trigger_update_profile_on_complete ON user_daily_progress;
CREATE TRIGGER trigger_update_profile_on_complete
  AFTER INSERT OR UPDATE ON user_daily_progress
  FOR EACH ROW
  EXECUTE FUNCTION update_profile_on_challenge_complete();

-- Manually recalculate stats for existing users (one-time fix)
-- This will update all existing profiles with correct stats
UPDATE profiles p
SET
  questions_answered = (
    SELECT COALESCE(COUNT(*), 0)
    FROM user_answers
    WHERE user_id = p.id
  ),
  correct_answers = (
    SELECT COALESCE(COUNT(*), 0)
    FROM user_answers
    WHERE user_id = p.id AND is_correct = true
  ),
  total_score = (
    SELECT COALESCE(SUM(score), 0)
    FROM user_daily_progress
    WHERE user_id = p.id AND completed = true
  ),
  updated_at = NOW();

-- Update last_practice_date
UPDATE profiles p
SET last_practice_date = (
  SELECT MAX(challenge_date)
  FROM user_daily_progress
  WHERE user_id = p.id AND completed = true
)
WHERE EXISTS (
  SELECT 1 FROM user_daily_progress
  WHERE user_id = p.id AND completed = true
);
