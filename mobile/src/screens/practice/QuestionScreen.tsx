import React, { useState } from 'react';
import { View, StyleSheet, ScrollView } from 'react-native';
import { Text, Card, Button, RadioButton } from 'react-native-paper';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Question } from '../../types';
import { colors } from '../../constants/colors';
import { ProgressBar } from '../../components/stats/ProgressBar';

interface QuestionScreenProps {
  question: Question;
  currentQuestion: number;
  totalQuestions: number;
  onAnswer: (answer: string) => void;
  onExit: () => void;
}

export const QuestionScreen: React.FC<QuestionScreenProps> = ({
  question,
  currentQuestion,
  totalQuestions,
  onAnswer,
  onExit,
}) => {
  const [selectedAnswer, setSelectedAnswer] = useState<string | null>(null);

  const handleSubmit = () => {
    if (selectedAnswer) {
      onAnswer(selectedAnswer);
    }
  };

  return (
    <SafeAreaView style={styles.container}>
      <View style={styles.header}>
        <ProgressBar
          current={currentQuestion}
          total={totalQuestions}
          label={`Question ${currentQuestion}/${totalQuestions}`}
        />
        <Button mode="text" onPress={onExit} textColor={colors.error}>
          Exit
        </Button>
      </View>

      <ScrollView style={styles.scrollView}>
        {/* Scenario Card */}
        <Card style={styles.scenarioCard}>
          <Card.Content>
            <Text style={styles.categoryBadge}>
              {question.category.toUpperCase()} • {question.difficulty.toUpperCase()}
            </Text>

            <View style={styles.handSection}>
              <Text style={styles.label}>Your Hand:</Text>
              <Text style={styles.handValue}>{question.scenario.yourHand}</Text>
            </View>

            <View style={styles.detailsGrid}>
              <DetailItem label="Position" value={question.scenario.position} />
              <DetailItem label="Stack" value={`${question.scenario.stackSize} BB`} />
              <DetailItem label="Pot" value={`${question.scenario.potSize} BB`} />
              <DetailItem label="Blinds" value={question.scenario.blinds} />
            </View>

            {question.scenario.communityCards && (
              <View style={styles.communitySection}>
                <Text style={styles.label}>Board:</Text>
                <Text style={styles.communityCards}>
                  {question.scenario.communityCards}
                </Text>
              </View>
            )}

            <View style={styles.actionSection}>
              <Text style={styles.label}>Action so far:</Text>
              <Text style={styles.actionText}>{question.scenario.actionSoFar}</Text>
            </View>
          </Card.Content>
        </Card>

        {/* Question */}
        <Text style={styles.questionText}>{question.question_text}</Text>

        {/* Answer Choices */}
        <Card style={styles.choicesCard}>
          <Card.Content>
            <RadioButton.Group
              onValueChange={setSelectedAnswer}
              value={selectedAnswer || ''}
            >
              {question.choices.map((choice) => (
                <View key={choice.id} style={styles.choiceItem}>
                  <RadioButton.Item
                    label={`${choice.id}. ${choice.action}`}
                    value={choice.id}
                    style={styles.radioButton}
                    labelStyle={styles.choiceLabel}
                    color={colors.primary}
                  />
                </View>
              ))}
            </RadioButton.Group>
          </Card.Content>
        </Card>
      </ScrollView>

      {/* Submit Button */}
      <View style={styles.footer}>
        <Button
          mode="contained"
          onPress={handleSubmit}
          disabled={!selectedAnswer}
          style={styles.submitButton}
        >
          Submit Answer
        </Button>
      </View>
    </SafeAreaView>
  );
};

const DetailItem: React.FC<{ label: string; value: string }> = ({ label, value }) => (
  <View style={styles.detailItem}>
    <Text style={styles.detailLabel}>{label}</Text>
    <Text style={styles.detailValue}>{value}</Text>
  </View>
);

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: colors.background,
  },
  header: {
    padding: 16,
    borderBottomWidth: 1,
    borderBottomColor: colors.border,
  },
  scrollView: {
    flex: 1,
  },
  scenarioCard: {
    margin: 16,
    backgroundColor: colors.surface,
  },
  categoryBadge: {
    fontSize: 12,
    fontWeight: '600',
    color: colors.secondary,
    marginBottom: 16,
  },
  handSection: {
    alignItems: 'center',
    marginBottom: 20,
    paddingVertical: 16,
    backgroundColor: colors.surfaceLight,
    borderRadius: 8,
  },
  label: {
    fontSize: 14,
    color: colors.textSecondary,
    marginBottom: 4,
  },
  handValue: {
    fontSize: 32,
    fontWeight: 'bold',
    color: colors.text,
  },
  detailsGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    marginBottom: 16,
  },
  detailItem: {
    width: '50%',
    marginBottom: 12,
  },
  detailLabel: {
    fontSize: 12,
    color: colors.textSecondary,
    marginBottom: 2,
  },
  detailValue: {
    fontSize: 16,
    color: colors.text,
    fontWeight: '500',
  },
  communitySection: {
    marginBottom: 16,
    padding: 12,
    backgroundColor: colors.surfaceLight,
    borderRadius: 8,
  },
  communityCards: {
    fontSize: 24,
    color: colors.text,
    fontWeight: 'bold',
  },
  actionSection: {
    marginTop: 8,
  },
  actionText: {
    fontSize: 14,
    color: colors.text,
    fontStyle: 'italic',
  },
  questionText: {
    fontSize: 20,
    fontWeight: 'bold',
    color: colors.text,
    marginHorizontal: 16,
    marginBottom: 16,
  },
  choicesCard: {
    margin: 16,
    backgroundColor: colors.surface,
  },
  choiceItem: {
    marginVertical: 4,
  },
  radioButton: {
    paddingVertical: 4,
  },
  choiceLabel: {
    fontSize: 16,
    color: colors.text,
  },
  footer: {
    padding: 16,
    borderTopWidth: 1,
    borderTopColor: colors.border,
  },
  submitButton: {
    paddingVertical: 8,
  },
});