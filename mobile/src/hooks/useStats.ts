import { useQuery } from '@tanstack/react-query';
import { fetchUserProfile, fetchCategoryStats } from '../services/stats';
import { useAuth } from '../contexts/AuthContext';

/**
 * Fetch user profile
 */
export const useUserProfile = () => {
  const { user } = useAuth();

  return useQuery({
    queryKey: ['profile', user?.id],
    queryFn: () => fetchUserProfile(user!.id),
    enabled: !!user,
  });
};

/**
 * Fetch category stats
 */
export const useCategoryStats = () => {
  const { user } = useAuth();

  return useQuery({
    queryKey: ['stats', 'category', user?.id],
    queryFn: () => fetchCategoryStats(user!.id),
    enabled: !!user,
  });
};