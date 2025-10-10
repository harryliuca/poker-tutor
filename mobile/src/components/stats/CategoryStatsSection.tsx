import React from 'react';
import { View, StyleSheet } from 'react-native';
import { Card, Text } from 'react-native-paper';
import { CategoryStats } from '../../types/user';
import { colors } from '../../constants/colors';
import { ProgressBar } from './ProgressBar';

interface CategoryStatsSectionProps {
  stats: CategoryStats[];
}

export const CategoryStatsSection: React.FC<CategoryStatsSectionProps> = ({ stats }) => {
  // Group stats by category
  const statsByCategory = stats.reduce((acc, stat) => {
    if (!acc[stat.category]) {
      acc[stat.category] = [];
    }
    acc[stat.category].push(stat);
    return acc;
  }, {} as Record<string, CategoryStats[]>);

  // Category display names and icons
  const categoryInfo: Record<string, { name: string; icon: string }> = {
    'pre-flop': { name: 'Pre-Flop', icon: '🃏' },
    'post-flop': { name: 'Post-Flop', icon: '🎴' },
    'turn': { name: 'Turn', icon: '🔄' },
    'river': { name: 'River', icon: '🌊' },
    'special': { name: 'Special Situations', icon: '⚡' },
  };

  // Difficulty colors
  const difficultyColors: Record<string, string> = {
    beginner: colors.success,
    intermediate: colors.secondary,
    advanced: colors.error,
  };

  if (stats.length === 0) {
    return (
      <Card style={styles.card}>
        <Card.Content>
          <Text style={styles.emptyText}>
            No practice data yet. Start a challenge to see your stats!
          </Text>
        </Card.Content>
      </Card>
    );
  }

  return (
    <View style={styles.container}>
      {Object.entries(statsByCategory).map(([category, categoryStats]) => {
        const info = categoryInfo[category] || { name: category, icon: '📊' };

        // Calculate category totals
        const totalQuestions = categoryStats.reduce((sum, s) => sum + s.questions_answered, 0);
        const totalCorrect = categoryStats.reduce((sum, s) => sum + s.questions_correct, 0);
        const categoryAccuracy = totalQuestions > 0
          ? ((totalCorrect / totalQuestions) * 100).toFixed(1)
          : '0.0';

        return (
          <Card key={category} style={styles.card}>
            <Card.Content>
              {/* Category Header */}
              <View style={styles.categoryHeader}>
                <Text style={styles.categoryIcon}>{info.icon}</Text>
                <View style={styles.categoryInfo}>
                  <Text style={styles.categoryName}>{info.name}</Text>
                  <Text style={styles.categoryStats}>
                    {totalQuestions} questions • {categoryAccuracy}% accuracy
                  </Text>
                </View>
              </View>

              {/* Difficulty Breakdown */}
              <View style={styles.difficultySection}>
                {categoryStats
                  .sort((a, b) => {
                    const order = { beginner: 0, intermediate: 1, advanced: 2 };
                    return order[a.difficulty] - order[b.difficulty];
                  })
                  .map((stat) => {
                    const accuracy = stat.questions_answered > 0
                      ? (stat.questions_correct / stat.questions_answered) * 100
                      : 0;

                    return (
                      <View key={`${category}-${stat.difficulty}`} style={styles.difficultyRow}>
                        <View style={styles.difficultyHeader}>
                          <View
                            style={[
                              styles.difficultyBadge,
                              { backgroundColor: difficultyColors[stat.difficulty] },
                            ]}
                          >
                            <Text style={styles.difficultyText}>
                              {stat.difficulty.charAt(0).toUpperCase() + stat.difficulty.slice(1)}
                            </Text>
                          </View>
                          <Text style={styles.difficultyStats}>
                            {stat.questions_correct}/{stat.questions_answered}
                          </Text>
                        </View>
                        <ProgressBar
                          current={accuracy}
                          total={100}
                          label=""
                          showPercentage
                          color={difficultyColors[stat.difficulty]}
                        />
                      </View>
                    );
                  })}
              </View>
            </Card.Content>
          </Card>
        );
      })}
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    marginHorizontal: 16,
  },
  card: {
    marginBottom: 16,
    backgroundColor: colors.surface,
  },
  emptyText: {
    textAlign: 'center',
    color: colors.textSecondary,
    fontSize: 14,
    padding: 16,
  },
  categoryHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 16,
  },
  categoryIcon: {
    fontSize: 32,
    marginRight: 12,
  },
  categoryInfo: {
    flex: 1,
  },
  categoryName: {
    fontSize: 18,
    fontWeight: 'bold',
    color: colors.text,
    marginBottom: 4,
  },
  categoryStats: {
    fontSize: 12,
    color: colors.textSecondary,
  },
  difficultySection: {
    gap: 12,
  },
  difficultyRow: {
    marginBottom: 8,
  },
  difficultyHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 6,
  },
  difficultyBadge: {
    paddingHorizontal: 12,
    paddingVertical: 4,
    borderRadius: 12,
  },
  difficultyText: {
    fontSize: 12,
    fontWeight: '600',
    color: colors.background,
  },
  difficultyStats: {
    fontSize: 14,
    fontWeight: '600',
    color: colors.text,
  },
});
