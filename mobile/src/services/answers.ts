import { supabase } from './supabase';
import { AnswerSubmission } from '../types';

/**
 * Submit an answer to a question
 */
export const submitAnswer = async (answer: AnswerSubmission) => {
  try {
    const { data, error } = await supabase
      .from('user_answers')
      .insert(answer)
      .select()
      .single();

    if (error) throw error;
    return { data, error: null };
  } catch (error) {
    console.error('Error submitting answer:', error);
    return { data: null, error };
  }
};

/**
 * Fetch user's answer history
 */
export const fetchAnswerHistory = async (
  userId: string,
  limit: number = 50
) => {
  try {
    const { data, error } = await supabase
      .from('user_answers')
      .select('*, questions(*)')
      .eq('user_id', userId)
      .order('answered_at', { ascending: false })
      .limit(limit);

    if (error) throw error;
    return { history: data, error: null };
  } catch (error) {
    console.error('Error fetching answer history:', error);
    return { history: [], error };
  }
};