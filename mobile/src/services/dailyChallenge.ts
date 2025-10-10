import { supabase } from './supabase';
import { fetchPracticeQuestions } from './questions';

/**
 * Get or create today's daily challenge with fixed question IDs
 */
export const getOrCreateTodaysChallenge = async () => {
  const today = new Date().toISOString().split('T')[0];

  try {
    // Check if challenge exists for today
    const { data: existing, error: fetchError } = await supabase
      .from('daily_challenges')
      .select('*')
      .eq('challenge_date', today)
      .single();

    // If exists, return it
    if (existing) {
      console.log('📅 Found existing challenge for today');
      return { challenge: existing, error: null };
    }

    // If no challenge exists (PGRST116 error is okay), create one
    if (fetchError && fetchError.code !== 'PGRST116') {
      throw fetchError;
    }

    console.log('📅 Creating new challenge for today');

    // Fetch 10 random questions for today's challenge
    const { questions, error: questionsError } = await fetchPracticeQuestions(
      'beginner',
      undefined,
      10
    );

    if (questionsError || !questions || questions.length === 0) {
      throw new Error('Failed to fetch questions for challenge');
    }

    // Create the challenge with fixed question IDs
    const questionIds = questions.map(q => q.id);
    const { data: newChallenge, error: createError } = await supabase
      .from('daily_challenges')
      .insert({
        challenge_date: today,
        question_ids: questionIds,
      })
      .select()
      .single();

    if (createError) throw createError;

    console.log('📅 Created new challenge with', questionIds.length, 'questions');
    return { challenge: newChallenge, error: null };
  } catch (error) {
    console.error('Error getting/creating daily challenge:', error);
    return { challenge: null, error };
  }
};