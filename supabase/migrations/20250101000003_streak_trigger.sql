-- Trigger to automatically update streaks when daily challenges are completed
-- Run this in Supabase SQL Editor AFTER running update-profile-stats-trigger.sql

-- Function to calculate and update streaks
CREATE OR REPLACE FUNCTION update_streak_on_challenge_complete()
RETURNS TRIGGER AS $$
DECLARE
  current_profile RECORD;
  new_streak INTEGER;
  practice_date DATE;
BEGIN
  -- Only process when challenge is completed
  IF NEW.completed = true AND (OLD IS NULL OR OLD.completed = false) THEN
    -- Get current profile data
    SELECT
      current_streak,
      longest_streak,
      last_practice_date
    INTO current_profile
    FROM profiles
    WHERE id = NEW.user_id;

    practice_date := NEW.challenge_date::date;

    -- Calculate new streak
    IF current_profile.last_practice_date IS NULL THEN
      -- First time practicing
      new_streak := 1;
    ELSIF current_profile.last_practice_date = practice_date THEN
      -- Already practiced today, keep current streak
      new_streak := current_profile.current_streak;
    ELSIF current_profile.last_practice_date = practice_date - INTERVAL '1 day' THEN
      -- Consecutive day, increment streak
      new_streak := current_profile.current_streak + 1;
    ELSE
      -- Streak broken, reset to 1
      new_streak := 1;
    END IF;

    -- Update profile with new streak
    UPDATE profiles
    SET
      current_streak = new_streak,
      longest_streak = GREATEST(current_profile.longest_streak, new_streak),
      last_practice_date = practice_date,
      updated_at = NOW()
    WHERE id = NEW.user_id;
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Drop old trigger if exists and create new one
DROP TRIGGER IF EXISTS trigger_update_streak ON user_daily_progress;
CREATE TRIGGER trigger_update_streak
  AFTER INSERT OR UPDATE ON user_daily_progress
  FOR EACH ROW
  EXECUTE FUNCTION update_streak_on_challenge_complete();

-- Recalculate streaks for existing users (one-time fix)
-- This calculates streaks based on completed challenges history
DO $$
DECLARE
  user_rec RECORD;
  challenge_rec RECORD;
  prev_date DATE := NULL;
  current_streak_val INTEGER := 0;
  max_streak_val INTEGER := 0;
  temp_streak INTEGER := 0;
BEGIN
  -- For each user
  FOR user_rec IN SELECT DISTINCT user_id FROM user_daily_progress WHERE completed = true
  LOOP
    prev_date := NULL;
    current_streak_val := 0;
    max_streak_val := 0;
    temp_streak := 0;

    -- Go through challenges in order to calculate streaks
    FOR challenge_rec IN
      SELECT challenge_date::date as cdate
      FROM user_daily_progress
      WHERE user_id = user_rec.user_id AND completed = true
      ORDER BY challenge_date ASC
    LOOP
      IF prev_date IS NULL THEN
        temp_streak := 1;
      ELSIF challenge_rec.cdate = prev_date + INTERVAL '1 day' THEN
        temp_streak := temp_streak + 1;
      ELSIF challenge_rec.cdate = prev_date THEN
        -- Same day, don't change streak
        temp_streak := temp_streak;
      ELSE
        -- Streak broken
        temp_streak := 1;
      END IF;

      max_streak_val := GREATEST(max_streak_val, temp_streak);
      prev_date := challenge_rec.cdate;
    END LOOP;

    -- Current streak is only valid if last practice was today or yesterday
    IF prev_date IS NOT NULL THEN
      IF prev_date = CURRENT_DATE OR prev_date = CURRENT_DATE - INTERVAL '1 day' THEN
        current_streak_val := temp_streak;
      ELSE
        current_streak_val := 0;
      END IF;
    END IF;

    -- Update the user's profile
    UPDATE profiles
    SET
      current_streak = current_streak_val,
      longest_streak = max_streak_val,
      updated_at = NOW()
    WHERE id = user_rec.user_id;
  END LOOP;
END $$;
