import { supabase } from './supabase';
import { DailyChallenge, DailyProgress } from '../types';

/**
 * Fetch today's daily challenge
 */
export const fetchTodaysChallenge = async () => {
  const today = new Date().toISOString().split('T')[0];

  try {
    const { data, error } = await supabase
      .from('daily_challenges')
      .select('*')
      .eq('challenge_date', today)
      .single();

    // PGRST116 means no rows found - that's okay, just return null
    if (error && error.code !== 'PGRST116') {
      throw error;
    }

    return { challenge: data as DailyChallenge | null, error: null };
  } catch (error) {
    console.error('Error fetching today\'s challenge:', error);
    return { challenge: null, error };
  }
};

/**
 * Fetch user's daily progress for a specific date
 */
export const fetchDailyProgress = async (
  userId: string,
  date?: string
) => {
  const challengeDate = date || new Date().toISOString().split('T')[0];

  try {
    const { data, error } = await supabase
      .from('user_daily_progress')
      .select('*')
      .eq('user_id', userId)
      .eq('challenge_date', challengeDate)
      .single();

    if (error && error.code !== 'PGRST116') { // PGRST116 = no rows returned
      throw error;
    }

    return { progress: data as DailyProgress | null, error: null };
  } catch (error) {
    console.error('Error fetching daily progress:', error);
    return { progress: null, error };
  }
};

/**
 * Update user's daily progress
 */
export const updateDailyProgress = async (
  userId: string,
  challengeId: string,
  updates: Partial<DailyProgress>
) => {
  const today = new Date().toISOString().split('T')[0];

  try {
    const { data, error } = await supabase
      .from('user_daily_progress')
      .upsert({
        user_id: userId,
        challenge_id: challengeId,
        challenge_date: today,
        ...updates,
      })
      .select()
      .single();

    if (error) throw error;
    return { progress: data as DailyProgress, error: null };
  } catch (error) {
    console.error('Error updating daily progress:', error);
    return { progress: null, error };
  }
};