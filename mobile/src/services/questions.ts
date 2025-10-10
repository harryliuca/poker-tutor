import { supabase } from './supabase';
import { Question, Category, Difficulty } from '../types';

/**
 * Fetch a random question based on difficulty and optionally category
 */
export const fetchRandomQuestion = async (
  difficulty: Difficulty,
  category?: Category
) => {
  try {
    let query = supabase
      .from('questions')
      .select('*')
      .eq('difficulty', difficulty);

    if (category) {
      query = query.eq('category', category);
    }

    // Get all matching questions, then pick random on client side
    const { data, error } = await query;

    if (error) throw error;

    if (!data || data.length === 0) {
      return { question: null, error: null };
    }

    // Pick random question from results
    const randomIndex = Math.floor(Math.random() * data.length);
    return { question: data[randomIndex] as Question, error: null };
  } catch (error) {
    console.error('Error fetching random question:', error);
    return { question: null, error };
  }
};

/**
 * Fetch a question by ID
 */
export const fetchQuestionById = async (questionId: string) => {
  try {
    const { data, error } = await supabase
      .from('questions')
      .select('*')
      .eq('id', questionId)
      .single();

    if (error) throw error;
    return { question: data as Question, error: null };
  } catch (error) {
    console.error('Error fetching question by ID:', error);
    return { question: null, error };
  }
};

/**
 * Fetch multiple questions by IDs
 */
export const fetchQuestionsByIds = async (questionIds: string[]) => {
  try {
    const { data, error } = await supabase
      .from('questions')
      .select('*')
      .in('id', questionIds);

    if (error) throw error;
    return { questions: data as Question[], error: null };
  } catch (error) {
    console.error('Error fetching questions by IDs:', error);
    return { questions: [], error };
  }
};

/**
 * Fetch questions for practice (batch)
 */
export const fetchPracticeQuestions = async (
  difficulty: Difficulty,
  category?: Category,
  limit: number = 10
) => {
  try {
    let query = supabase
      .from('questions')
      .select('*');

    // Don't filter by difficulty to get more variety
    // .eq('difficulty', difficulty);

    if (category) {
      query = query.eq('category', category);
    }

    const { data, error } = await query;

    if (error) throw error;

    if (!data || data.length === 0) {
      return { questions: [], error: null };
    }

    // Shuffle and take limited number
    const shuffled = [...data].sort(() => Math.random() - 0.5);
    const limited = shuffled.slice(0, Math.min(limit, shuffled.length));

    return { questions: limited as Question[], error: null };
  } catch (error) {
    console.error('Error fetching practice questions:', error);
    return { questions: [], error };
  }
};