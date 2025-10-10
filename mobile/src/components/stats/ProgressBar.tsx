import React from 'react';
import { View, StyleSheet } from 'react-native';
import { Text, ProgressBar as PaperProgressBar } from 'react-native-paper';
import { colors } from '../../constants/colors';

interface ProgressBarProps {
  current: number;
  total: number;
  label?: string;
  showPercentage?: boolean;
  color?: string;
}

export const ProgressBar: React.FC<ProgressBarProps> = ({
  current,
  total,
  label,
  showPercentage = false,
  color,
}) => {
  const progress = total > 0 ? current / total : 0;
  const percentage = (progress * 100).toFixed(1);

  return (
    <View style={styles.container}>
      {label && (
        <View style={styles.labelRow}>
          <Text style={styles.label}>{label}</Text>
          <Text style={styles.fraction}>
            {showPercentage ? `${percentage}%` : `${current}/${total}`}
          </Text>
        </View>
      )}
      <PaperProgressBar
        progress={progress}
        color={color || colors.primary}
        style={styles.progressBar}
      />
      {showPercentage && !label && (
        <Text style={styles.percentageText}>{percentage}%</Text>
      )}
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    marginVertical: 8,
  },
  labelRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginBottom: 8,
  },
  label: {
    fontSize: 14,
    color: colors.text,
    fontWeight: '500',
  },
  fraction: {
    fontSize: 14,
    color: colors.textSecondary,
  },
  progressBar: {
    height: 8,
    borderRadius: 4,
    backgroundColor: colors.surfaceLight,
  },
  percentageText: {
    fontSize: 12,
    color: colors.textSecondary,
    textAlign: 'right',
    marginTop: 4,
  },
});