export interface DailyChallenge {
  id: string;
  challenge_date: string;
  question_ids: string[];
  created_at: string;
}

export interface ChallengeResults {
  score: number;
  correct: number;
  total: number;
  newStreak: number;
  categoryStats: {
    category: string;
    accuracy: number;
    total: number;
  }[];
}