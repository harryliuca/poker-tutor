import { POINTS_PER_CORRECT_ANSWER, BONUS_POINTS_FOR_PERFECT_SCORE } from '../constants/config';

/**
 * Calculate score for a set of answers
 */
export const calculateScore = (correct: number, total: number): number => {
  const baseScore = correct * POINTS_PER_CORRECT_ANSWER;

  // Bonus for perfect score
  if (correct === total) {
    return baseScore + BONUS_POINTS_FOR_PERFECT_SCORE;
  }

  return baseScore;
};

/**
 * Calculate accuracy percentage
 */
export const calculateAccuracy = (correct: number, total: number): number => {
  if (total === 0) return 0;
  return Math.round((correct / total) * 100);
};