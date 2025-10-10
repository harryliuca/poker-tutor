import { supabase } from './supabase';
import { UserProfile, CategoryStats } from '../types';

/**
 * Fetch user profile
 */
export const fetchUserProfile = async (userId: string) => {
  try {
    const { data, error } = await supabase
      .from('profiles')
      .select('*')
      .eq('id', userId)
      .single();

    if (error) throw error;
    return { profile: data as UserProfile, error: null };
  } catch (error) {
    console.error('Error fetching user profile:', error);
    return { profile: null, error };
  }
};

/**
 * Update user profile
 */
export const updateUserProfile = async (
  userId: string,
  updates: Partial<UserProfile>
) => {
  try {
    const { data, error } = await supabase
      .from('profiles')
      .update(updates)
      .eq('id', userId)
      .select()
      .single();

    if (error) throw error;
    return { profile: data as UserProfile, error: null };
  } catch (error) {
    console.error('Error updating user profile:', error);
    return { profile: null, error };
  }
};

/**
 * Fetch user's category stats
 */
export const fetchCategoryStats = async (userId: string) => {
  try {
    const { data, error } = await supabase
      .from('user_category_stats')
      .select('*')
      .eq('user_id', userId);

    if (error) throw error;
    return { stats: data as CategoryStats[], error: null };
  } catch (error) {
    console.error('Error fetching category stats:', error);
    return { stats: [], error };
  }
};