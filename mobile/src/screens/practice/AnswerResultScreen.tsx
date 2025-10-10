import React from 'react';
import { View, StyleSheet, ScrollView } from 'react-native';
import { Text, Card, Button } from 'react-native-paper';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Question } from '../../types';
import { colors } from '../../constants/colors';

interface AnswerResultScreenProps {
  question: Question;
  userAnswer: string;
  isCorrect: boolean;
  onNext: () => void;
  isLastQuestion: boolean;
}

export const AnswerResultScreen: React.FC<AnswerResultScreenProps> = ({
  question,
  userAnswer,
  isCorrect,
  onNext,
  isLastQuestion,
}) => {
  const correctChoice = question.choices.find((c) => c.id === question.correct_answer);
  const userChoice = question.choices.find((c) => c.id === userAnswer);

  return (
    <SafeAreaView style={styles.container}>
      <ScrollView style={styles.scrollView}>
        {/* Result Header */}
        <View style={[styles.resultHeader, isCorrect ? styles.correctHeader : styles.incorrectHeader]}>
          <Text style={styles.resultEmoji}>{isCorrect ? '✓' : '✗'}</Text>
          <Text style={styles.resultTitle}>
            {isCorrect ? 'Correct!' : 'Incorrect'}
          </Text>
        </View>

        {/* Answer Comparison */}
        <Card style={styles.card}>
          <Card.Content>
            <Text style={styles.sectionTitle}>Your Answer:</Text>
            <View style={[styles.answerBox, !isCorrect && styles.incorrectBox]}>
              <Text style={styles.answerText}>
                {userChoice?.id}. {userChoice?.action}
              </Text>
            </View>

            {!isCorrect && (
              <>
                <Text style={[styles.sectionTitle, styles.marginTop]}>Correct Answer:</Text>
                <View style={[styles.answerBox, styles.correctBox]}>
                  <Text style={styles.answerText}>
                    {correctChoice?.id}. {correctChoice?.action}
                  </Text>
                </View>
              </>
            )}
          </Card.Content>
        </Card>

        {/* Explanation */}
        <Card style={styles.card}>
          <Card.Content>
            <Text style={styles.sectionTitle}>Explanation:</Text>
            <Text style={styles.explanationText}>{question.explanation}</Text>

            {question.key_concepts && question.key_concepts.length > 0 && (
              <View style={styles.conceptsSection}>
                <Text style={styles.conceptsLabel}>Key Concepts:</Text>
                <View style={styles.conceptsContainer}>
                  {question.key_concepts.map((concept, index) => (
                    <View key={index} style={styles.conceptBadge}>
                      <Text style={styles.conceptText}>{concept}</Text>
                    </View>
                  ))}
                </View>
              </View>
            )}
          </Card.Content>
        </Card>

        {/* Scenario Review */}
        <Card style={styles.card}>
          <Card.Content>
            <Text style={styles.sectionTitle}>Scenario:</Text>
            <Text style={styles.reviewText}>
              Hand: <Text style={styles.bold}>{question.scenario.yourHand}</Text>
            </Text>
            <Text style={styles.reviewText}>
              Position: <Text style={styles.bold}>{question.scenario.position}</Text>
            </Text>
            {question.scenario.communityCards && (
              <Text style={styles.reviewText}>
                Board: <Text style={styles.bold}>{question.scenario.communityCards}</Text>
              </Text>
            )}
            <Text style={styles.reviewText}>
              Action: <Text style={styles.bold}>{question.scenario.actionSoFar}</Text>
            </Text>
          </Card.Content>
        </Card>
      </ScrollView>

      {/* Next Button */}
      <View style={styles.footer}>
        <Button
          mode="contained"
          onPress={onNext}
          style={styles.nextButton}
        >
          {isLastQuestion ? 'Finish Challenge' : 'Next Question'}
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
  resultHeader: {
    alignItems: 'center',
    padding: 32,
    marginBottom: 16,
  },
  correctHeader: {
    backgroundColor: colors.success,
  },
  incorrectHeader: {
    backgroundColor: colors.error,
  },
  resultEmoji: {
    fontSize: 60,
    marginBottom: 12,
  },
  resultTitle: {
    fontSize: 28,
    fontWeight: 'bold',
    color: colors.text,
  },
  card: {
    margin: 16,
    marginTop: 0,
    backgroundColor: colors.surface,
  },
  sectionTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: colors.text,
    marginBottom: 12,
  },
  marginTop: {
    marginTop: 20,
  },
  answerBox: {
    padding: 16,
    borderRadius: 8,
    borderWidth: 2,
  },
  correctBox: {
    backgroundColor: `${colors.success}20`,
    borderColor: colors.success,
  },
  incorrectBox: {
    backgroundColor: `${colors.error}20`,
    borderColor: colors.error,
  },
  answerText: {
    fontSize: 16,
    color: colors.text,
    fontWeight: '500',
  },
  explanationText: {
    fontSize: 15,
    color: colors.text,
    lineHeight: 22,
  },
  conceptsSection: {
    marginTop: 20,
  },
  conceptsLabel: {
    fontSize: 14,
    color: colors.textSecondary,
    marginBottom: 8,
  },
  conceptsContainer: {
    flexDirection: 'row',
    flexWrap: 'wrap',
  },
  conceptBadge: {
    backgroundColor: colors.primary,
    paddingHorizontal: 12,
    paddingVertical: 6,
    borderRadius: 16,
    marginRight: 8,
    marginBottom: 8,
  },
  conceptText: {
    fontSize: 12,
    color: colors.text,
    fontWeight: '500',
  },
  reviewText: {
    fontSize: 14,
    color: colors.textSecondary,
    marginBottom: 8,
  },
  bold: {
    color: colors.text,
    fontWeight: '600',
  },
  footer: {
    padding: 16,
    borderTopWidth: 1,
    borderTopColor: colors.border,
  },
  nextButton: {
    paddingVertical: 8,
  },
});