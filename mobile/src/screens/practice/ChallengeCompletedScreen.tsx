import React from 'react';
import { View, StyleSheet, ScrollView } from 'react-native';
import { Text, Card, Button } from 'react-native-paper';
import { SafeAreaView } from 'react-native-safe-area-context';
import { colors } from '../../constants/colors';
import { StatsCard } from '../../components/stats/StatsCard';
import { formatAccuracy } from '../../utils/formatting';

interface ChallengeCompletedScreenProps {
  score: { correct: number; total: number };
  onGoHome: () => void;
}

export const ChallengeCompletedScreen: React.FC<ChallengeCompletedScreenProps> = ({
  score,
  onGoHome,
}) => {
  const accuracy = score.total > 0 ? Math.round((score.correct / score.total) * 100) : 0;
  const isPerfect = score.correct === score.total;

  return (
    <SafeAreaView style={styles.container}>
      <ScrollView style={styles.scrollView} contentContainerStyle={styles.content}>
        {/* Celebration */}
        <View style={styles.celebration}>
          <Text style={styles.emoji}>{isPerfect ? '🏆' : '🎉'}</Text>
          <Text style={styles.title}>
            {isPerfect ? 'Perfect Score!' : 'Challenge Complete!'}
          </Text>
          <Text style={styles.subtitle}>Great job today!</Text>
        </View>

        {/* Results */}
        <Card style={styles.card}>
          <Card.Content>
            <Text style={styles.sectionTitle}>Today's Results</Text>
            <View style={styles.statsGrid}>
              <StatsCard
                label="Score"
                value={`${score.correct}/${score.total}`}
                icon="🎯"
              />
              <StatsCard
                label="Accuracy"
                value={formatAccuracy(score.correct, score.total)}
                icon="📊"
              />
            </View>
          </Card.Content>
        </Card>

        {/* Encouragement */}
        <Card style={styles.card}>
          <Card.Content>
            <Text style={styles.encouragementText}>
              {accuracy >= 90
                ? "Outstanding! You're mastering poker decision-making! 🌟"
                : accuracy >= 70
                ? "Great work! Keep practicing to improve even more! 💪"
                : accuracy >= 50
                ? "Good effort! Review the explanations to learn more. 📚"
                : "Keep going! Every question helps you learn. 🎓"}
            </Text>
          </Card.Content>
        </Card>

        {/* Message about tomorrow */}
        <Card style={styles.card}>
          <Card.Content style={styles.tomorrowCard}>
            <Text style={styles.tomorrowIcon}>📅</Text>
            <Text style={styles.tomorrowText}>
              Come back tomorrow for a new daily challenge!
            </Text>
          </Card.Content>
        </Card>
      </ScrollView>

      {/* Actions */}
      <View style={styles.footer}>
        <Button
          mode="contained"
          onPress={onGoHome}
          style={styles.button}
        >
          Back to Home
        </Button>
      </View>
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
  content: {
    padding: 16,
  },
  celebration: {
    alignItems: 'center',
    paddingVertical: 40,
  },
  emoji: {
    fontSize: 80,
    marginBottom: 16,
  },
  title: {
    fontSize: 32,
    fontWeight: 'bold',
    color: colors.text,
    marginBottom: 8,
  },
  subtitle: {
    fontSize: 18,
    color: colors.textSecondary,
  },
  card: {
    marginBottom: 16,
    backgroundColor: colors.surface,
  },
  sectionTitle: {
    fontSize: 20,
    fontWeight: 'bold',
    color: colors.text,
    marginBottom: 16,
  },
  statsGrid: {
    flexDirection: 'row',
    marginHorizontal: -8,
  },
  encouragementText: {
    fontSize: 16,
    color: colors.text,
    lineHeight: 24,
    textAlign: 'center',
  },
  tomorrowCard: {
    alignItems: 'center',
    paddingVertical: 8,
  },
  tomorrowIcon: {
    fontSize: 32,
    marginBottom: 8,
  },
  tomorrowText: {
    fontSize: 14,
    color: colors.textSecondary,
    textAlign: 'center',
  },
  footer: {
    padding: 16,
    borderTopWidth: 1,
    borderTopColor: colors.border,
  },
  button: {
    paddingVertical: 8,
  },
});