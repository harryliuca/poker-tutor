import { Difficulty, Category } from './question';

export interface UserProfile {
  id: string;
  email: string;
  display_name: string | null;
  google_id: string | null;
  avatar_url: string | null;
  created_at: string;
  updated_at: string;

  // Stats
  total_score: number;
  current_streak: number;
  longest_streak: number;
  last_practice_date: string | null;

  // Skill tracking
  current_difficulty: Difficulty;
  questions_answered: number;
  correct_answers: number;
}

export interface CategoryStats {
  id: string;
  user_id: string;
  category: Category;
  difficulty: Difficulty;
  questions_answered: number;
  questions_correct: number;
  accuracy: number;
  last_practiced: string | null;
  updated_at: string;
}

export interface DailyProgress {
  id: string;
  user_id: string;
  challenge_id: string;
  challenge_date: string;
  questions_answered: number;
  questions_correct: number;
  total_questions: number;
  score: number;
  completed: boolean;
  completed_at: string | null;
  started_at: string;
}