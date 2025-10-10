import React from 'react';
import { View, StyleSheet } from 'react-native';
import { Card, Text } from 'react-native-paper';
import { colors } from '../../constants/colors';

interface StatsCardProps {
  label: string;
  value: string | number;
  icon?: string;
}

export const StatsCard: React.FC<StatsCardProps> = ({ label, value, icon }) => {
  return (
    <Card style={styles.card}>
      <Card.Content style={styles.content}>
        {icon && <Text style={styles.icon}>{icon}</Text>}
        <Text style={styles.value}>{value}</Text>
        <Text style={styles.label}>{label}</Text>
      </Card.Content>
    </Card>
  );
};

const styles = StyleSheet.create({
  card: {
    flex: 1,
    margin: 8,
    backgroundColor: colors.surface,
  },
  content: {
    alignItems: 'center',
    padding: 16,
  },
  icon: {
    fontSize: 24,
    marginBottom: 8,
  },
  value: {
    fontSize: 24,
    fontWeight: 'bold',
    color: colors.text,
    marginBottom: 4,
  },
  label: {
    fontSize: 12,
    color: colors.textSecondary,
  },
});