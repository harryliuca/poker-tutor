import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { fetchTodaysChallenge, fetchDailyProgress, updateDailyProgress } from '../services/challenge';
import { fetchQuestionsByIds } from '../services/questions';
import { useAuth } from '../contexts/AuthContext';

/**
 * Fetch today's daily challenge
 */
export const useTodaysChallenge = () => {
  return useQuery({
    queryKey: ['challenge', 'today'],
    queryFn: fetchTodaysChallenge,
  });
};

/**
 * Fetch daily challenge questions
 */
export const useChallengeQuestions = (questionIds: string[]) => {
  return useQuery({
    queryKey: ['challenge', 'questions', questionIds],
    queryFn: () => fetchQuestionsByIds(questionIds),
    enabled: questionIds.length > 0,
  });
};

/**
 * Fetch user's daily progress
 */
export const useDailyProgress = (date?: string) => {
  const { user } = useAuth();

  return useQuery({
    queryKey: ['progress', 'daily', user?.id, date],
    queryFn: () => fetchDailyProgress(user!.id, date),
    enabled: !!user,
  });
};

/**
 * Update daily progress mutation
 */
export const useUpdateDailyProgress = () => {
  const { user } = useAuth();
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: ({ challengeId, updates }: any) =>
      updateDailyProgress(user!.id, challengeId, updates),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['progress', 'daily'] });
      queryClient.invalidateQueries({ queryKey: ['profile'] });
    },
  });
};