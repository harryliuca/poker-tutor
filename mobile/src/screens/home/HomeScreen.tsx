import React from 'react';
import { View, StyleSheet, ScrollView } from 'react-native';
import { Text, Card, Button } from 'react-native-paper';
import { SafeAreaView } from 'react-native-safe-area-context';
import { useAuth } from '../../contexts/AuthContext';
import { useTodaysChallenge, useDailyProgress } from '../../hooks/useDailyChallenge';
import { LoadingSpinner } from '../../components/common/LoadingSpinner';
import { ErrorMessage } from '../../components/common/ErrorMessage';
import { StatsCard } from '../../components/stats/StatsCard';
import { ProgressBar } from '../../components/stats/ProgressBar';
import { colors } from '../../constants/colors';
import { formatAccuracy } from '../../utils/formatting';

interface HomeScreenProps {
  onStartChallenge: () => void;
  onStartPractice: () => void;
  onViewProfile: () => void;
}

export const HomeScreen: React.FC<HomeScreenProps> = ({
  onStartChallenge,
  onStartPractice,
  onViewProfile,
}) => {
  const { profile, user } = useAuth();
  const { data: challengeData, isLoading: challengeLoading, error: challengeError } = useTodaysChallenge();
  const { data: progressData, isLoading: progressLoading } = useDailyProgress();

  if (challengeLoading || progressLoading) {
    return <LoadingSpinner />;
  }

  // It's okay if there's no challenge yet - we can still start practice
  const challenge = challengeData?.challenge || null;
  const progress = progressData?.progress;

  return (
    <SafeAreaView style={styles.container}>
      <ScrollView style={styles.scrollView}>
        {/* Header */}
        <View style={styles.header}>
          <View style={styles.headerContent}>
            <View style={styles.greetingContainer}>
              <Text style={styles.greeting}>Welcome back, {profile?.display_name || 'Player'}!</Text>
              {profile && profile.current_streak > 0 && (
                <View style={styles.streakBadge}>
                  <Text style={styles.streakText}>🔥 {profile.current_streak} day streak</Text>
                </View>
              )}
            </View>
            <Button
              mode="outlined"
              onPress={onViewProfile}
              style={styles.profileButton}
              labelStyle={styles.profileButtonLabel}
            >
              👤
            </Button>
          </View>
        </View>

        {/* Daily Challenge Card */}
        <Card style={styles.challengeCard}>
          <Card.Content>
            <Text style={styles.challengeTitle}>Today's Challenge</Text>
            {progress ? (
              <>
                <ProgressBar
                  current={progress.questions_answered}
                  total={progress.total_questions}
                  label="Progress"
                />
                {progress.completed ? (
                  <View style={styles.completedBadge}>
                    <Text style={styles.completedText}>✓ Completed!</Text>
                    <Text style={styles.scoreText}>Score: {progress.score}</Text>
                  </View>
                ) : (
                  <Button
                    mode="contained"
                    onPress={onStartChallenge}
                    style={styles.challengeButton}
                  >
                    {progress.questions_answered > 0 ? 'Continue Challenge' : 'Start Challenge'}
                  </Button>
                )}
              </>
            ) : (
              <Button
                mode="contained"
                onPress={onStartChallenge}
                style={styles.challengeButton}
              >
                Start Today's Challenge
              </Button>
            )}
          </Card.Content>
        </Card>

        {/* Stats Grid */}
        <Text style={styles.sectionTitle}>Your Stats</Text>
        <View style={styles.statsGrid}>
          <StatsCard
            label="Questions"
            value={profile?.questions_answered || 0}
            icon="📝"
          />
          <StatsCard
            label="Accuracy"
            value={formatAccuracy(
              profile?.correct_answers || 0,
              profile?.questions_answered || 0
            )}
            icon="🎯"
          />
        </View>
        <View style={styles.statsGrid}>
          <StatsCard
            label="Current Streak"
            value={profile?.current_streak || 0}
            icon="🔥"
          />
          <StatsCard
            label="Best Streak"
            value={profile?.longest_streak || 0}
            icon="🏆"
          />
        </View>

        {/* Quick Actions */}
        <Text style={styles.sectionTitle}>Quick Actions</Text>
        <Button
          mode="outlined"
          onPress={onStartPractice}
          style={styles.actionButton}
        >
          Random Practice
        </Button>

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
    padding: 20,
    paddingBottom: 10,
  },
  headerContent: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    gap: 12,
  },
  greetingContainer: {
    flex: 1,
  },
  profileButton: {
    minWidth: 48,
    borderRadius: 24,
  },
  profileButtonLabel: {
    fontSize: 20,
    marginVertical: 4,
  },
  greeting: {
    fontSize: 24,
    fontWeight: 'bold',
    color: colors.text,
    marginBottom: 8,
  },
  streakBadge: {
    backgroundColor: colors.secondary,
    paddingHorizontal: 12,
    paddingVertical: 6,
    borderRadius: 16,
    alignSelf: 'flex-start',
  },
  streakText: {
    fontSize: 14,
    fontWeight: '600',
    color: colors.background,
  },
  challengeCard: {
    margin: 16,
    backgroundColor: colors.surface,
  },
  challengeTitle: {
    fontSize: 20,
    fontWeight: 'bold',
    color: colors.text,
    marginBottom: 16,
  },
  challengeButton: {
    marginTop: 16,
  },
  completedBadge: {
    backgroundColor: colors.success,
    padding: 16,
    borderRadius: 8,
    alignItems: 'center',
    marginTop: 16,
  },
  completedText: {
    fontSize: 18,
    fontWeight: 'bold',
    color: colors.text,
  },
  scoreText: {
    fontSize: 16,
    color: colors.text,
    marginTop: 4,
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
  actionButton: {
    marginHorizontal: 16,
    marginVertical: 8,
  },
});