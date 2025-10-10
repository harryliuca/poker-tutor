import Constants from 'expo-constants';

// Supabase configuration
export const SUPABASE_URL = process.env.EXPO_PUBLIC_SUPABASE_URL || '';
export const SUPABASE_ANON_KEY = process.env.EXPO_PUBLIC_SUPABASE_ANON_KEY || '';

// App configuration
export const APP_NAME = 'Poker Tutor';
export const DAILY_CHALLENGE_QUESTIONS = 10;

// Scoring
export const POINTS_PER_CORRECT_ANSWER = 10;
export const BONUS_POINTS_FOR_PERFECT_SCORE = 20;

// Navigation
export const AUTH_CALLBACK_URL = 'pokertutor://auth/callback';

// Validation
if (!SUPABASE_URL || !SUPABASE_ANON_KEY) {
  console.warn('⚠️  Supabase credentials not found. Please configure .env file.');
}