export type PracticeMode = 'daily_challenge' | 'random_practice';

export interface UserAnswer {
  id: string;
  user_id: string;
  question_id: string;
  selected_answer: string;
  is_correct: boolean;
  practice_mode: PracticeMode;
  answered_at: string;
  time_taken_seconds?: number;
  challenge_date?: string;
}

export interface AnswerSubmission {
  user_id: string;
  question_id: string;
  selected_answer: string;
  is_correct: boolean;
  practice_mode: PracticeMode;
  time_taken_seconds?: number;
  challenge_date?: string;
}