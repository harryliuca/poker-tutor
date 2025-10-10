import { useQuery } from '@tanstack/react-query';
import { fetchRandomQuestion, fetchQuestionById, fetchPracticeQuestions } from '../services/questions';
import { Category, Difficulty } from '../types';

/**
 * Fetch a random question
 */
export const useRandomQuestion = (difficulty: Difficulty, category?: Category) => {
  return useQuery({
    queryKey: ['question', 'random', difficulty, category],
    queryFn: () => fetchRandomQuestion(difficulty, category),
  });
};

/**
 * Fetch a question by ID
 */
export const useQuestion = (questionId: string) => {
  return useQuery({
    queryKey: ['question', questionId],
    queryFn: () => fetchQuestionById(questionId),
    enabled: !!questionId,
  });
};

/**
 * Fetch practice questions
 */
export const usePracticeQuestions = (
  difficulty: Difficulty,
  category?: Category,
  limit: number = 10
) => {
  return useQuery({
    queryKey: ['questions', 'practice', difficulty, category, limit],
    queryFn: () => fetchPracticeQuestions(difficulty, category, limit),
  });
};