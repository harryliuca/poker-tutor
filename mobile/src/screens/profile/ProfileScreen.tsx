import React from 'react';
import { View, StyleSheet, ScrollView } from 'react-native';
import { Text, Card, Button, Divider } from 'react-native-paper';
import { SafeAreaView } from 'react-native-safe-area-context';
import { useAuth } from '../../contexts/AuthContext';
import { useCategoryStats } from '../../hooks/useStats';
import { LoadingSpinner } from '../../components/common/LoadingSpinner';
import { StatsCard } from '../../components/stats/StatsCard';
import { CategoryStatsSection } from '../../components/stats/CategoryStatsSection';
import { colors } from '../../constants/colors';
import { formatAccuracy } from '../../utils/formatting';

interface ProfileScreenProps {
  onBack: () => void;
}

export const ProfileScreen: React.FC<ProfileScreenProps> = ({ onBack }) => {
  const { profile, user, signOut } = useAuth();
  const { data: categoryStatsData, isLoading: statsLoading } = useCategoryStats();

  if (statsLoading) {
    return <LoadingSpinner />;
  }

  const categoryStats = categoryStatsData?.stats || [];

  // Calculate overall accuracy
  const overallAccuracy = profile?.questions_answered
    ? ((profile.correct_answers / profile.questions_answered) * 100).toFixed(1)
    : '0.0';

  return (
    <SafeAreaView style={styles.container}>
      <ScrollView style={styles.scrollView}>
        {/* Header */}
        <View style={styles.header}>
          <Button mode="text" onPress={onBack} style={styles.backButton}>
            ← Back
          </Button>
          <Text style={styles.title}>Profile</Text>
        </View>

        {/* User Info Card */}
        <Card style={styles.card}>
          <Card.Content>
            <View style={styles.userInfo}>
              <View style={styles.avatar}>
                <Text style={styles.avatarText}>
                  {(profile?.display_name || user?.email || 'U')[0].toUpperCase()}
                </Text>
              </View>
              <View style={styles.userDetails}>
                <Text style={styles.displayName}>
                  {profile?.display_name || 'Player'}
                </Text>
                <Text style={styles.email}>{user?.email}</Text>
              </View>
            </View>
          </Card.Content>
        </Card>

        {/* Overall Stats */}
        <Text style={styles.sectionTitle}>Overall Statistics</Text>
        <View style={styles.statsGrid}>
          <StatsCard
            label="Total Questions"
            value={profile?.questions_answered || 0}
            icon="📝"
          />
          <StatsCard
            label="Correct Answers"
            value={profile?.correct_answers || 0}
            icon="✅"
          />
        </View>
        <View style={styles.statsGrid}>
          <StatsCard
            label="Overall Accuracy"
            value={`${overallAccuracy}%`}
            icon="🎯"
          />
          <StatsCard
            label="Total Score"
            value={profile?.total_score || 0}
            icon="⭐"
          />
        </View>

        {/* Streak Stats */}
        <Text style={styles.sectionTitle}>Streaks</Text>
        <View style={styles.statsGrid}>
          <StatsCard
            label="Current Streak"
            value={`${profile?.current_streak || 0} days`}
            icon="🔥"
          />
          <StatsCard
            label="Longest Streak"
            value={`${profile?.longest_streak || 0} days`}
            icon="🏆"
          />
        </View>

        {/* Category Breakdown */}
        <Text style={styles.sectionTitle}>Performance by Category</Text>
        <CategoryStatsSection stats={categoryStats} />

        {/* Account Actions */}
        <View style={styles.actionsSection}>
          <Divider style={styles.divider} />
          <Button
            mode="outlined"
            onPress={signOut}
            style={styles.actionButton}
            textColor={colors.error}
          >
            Sign Out
          </Button>
        </View>
      </ScrollView>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: colors.background,
  },
  scrollView: {
    flex: 1,
  },
  header: {
    padding: 16,
    paddingBottom: 8,
  },
  backButton: {
    alignSelf: 'flex-start',
    marginBottom: 8,
  },
  title: {
    fontSize: 28,
    fontWeight: 'bold',
    color: colors.text,
  },
  card: {
    margin: 16,
    backgroundColor: colors.surface,
  },
  userInfo: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  avatar: {
    width: 60,
    height: 60,
    borderRadius: 30,
    backgroundColor: colors.primary,
    alignItems: 'center',
    justifyContent: 'center',
    marginRight: 16,
  },
  avatarText: {
    fontSize: 24,
    fontWeight: 'bold',
    color: colors.background,
  },
  userDetails: {
    flex: 1,
  },
  displayName: {
    fontSize: 20,
    fontWeight: 'bold',
    color: colors.text,
    marginBottom: 4,
  },
  email: {
    fontSize: 14,
    color: colors.textSecondary,
  },
  sectionTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    color: colors.text,
    marginHorizontal: 16,
    marginTop: 20,
    marginBottom: 12,
  },
  statsGrid: {
    flexDirection: 'row',
    marginHorizontal: 8,
  },
  actionsSection: {
    marginTop: 32,
    marginBottom: 32,
  },
  divider: {
    marginVertical: 16,
  },
  actionButton: {
    marginHorizontal: 16,
    marginVertical: 8,
  },
});
