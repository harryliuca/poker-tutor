import React, { useState } from 'react';
import { View, StyleSheet, Image } from 'react-native';
import { Text, Button } from 'react-native-paper';
import { SafeAreaView } from 'react-native-safe-area-context';
import { useAuth } from '../../contexts/AuthContext';
import { LoadingSpinner } from '../../components/common/LoadingSpinner';
import { colors } from '../../constants/colors';

export const LoginScreen: React.FC = () => {
  const { signIn } = useAuth();
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const handleGoogleSignIn = async () => {
    console.log('🔵 Button clicked - starting sign in...');
    try {
      setLoading(true);
      setError(null);
      console.log('🔵 Calling signIn()...');
      const result = await signIn();
      console.log('🔵 Sign in result:', result);
    } catch (err: any) {
      const errorMessage = err?.message || 'Failed to sign in. Please try again.';
      setError(errorMessage);
      console.error('🔴 Sign in error:', err);
      console.error('🔴 Error details:', JSON.stringify(err, null, 2));
    } finally {
      setLoading(false);
      console.log('🔵 Sign in process completed');
    }
  };

  if (loading) {
    return <LoadingSpinner message="Signing in..." />;
  }

  return (
    <SafeAreaView style={styles.container}>
      <View style={styles.content}>
        {/* Logo section */}
        <View style={styles.logoSection}>
          <Text style={styles.logoEmoji}>♠️♥️</Text>
          <Text style={styles.appName}>Poker Tutor</Text>
          <Text style={styles.tagline}>Master Texas Hold'em, one decision at a time</Text>
        </View>

        {/* Features section */}
        <View style={styles.featuresSection}>
          <FeatureItem icon="🎯" text="Daily challenges to build habits" />
          <FeatureItem icon="📊" text="Track your progress and streaks" />
          <FeatureItem icon="🎓" text="Learn from expert explanations" />
        </View>

        {/* Sign in button */}
        <View style={styles.authSection}>
          <Button
            mode="contained"
            onPress={handleGoogleSignIn}
            icon="google"
            style={styles.signInButton}
            labelStyle={styles.signInButtonLabel}
            disabled={loading}
          >
            Sign in with Google
          </Button>

          {error && <Text style={styles.errorText}>{error}</Text>}
        </View>
      </View>
    </SafeAreaView>
  );
};

const FeatureItem: React.FC<{ icon: string; text: string }> = ({ icon, text }) => (
  <View style={styles.featureItem}>
    <Text style={styles.featureIcon}>{icon}</Text>
    <Text style={styles.featureText}>{text}</Text>
  </View>
);

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: colors.background,
  },
  content: {
    flex: 1,
    justifyContent: 'space-between',
    padding: 24,
  },
  logoSection: {
    alignItems: 'center',
    marginTop: 60,
  },
  logoEmoji: {
    fontSize: 80,
    marginBottom: 20,
  },
  appName: {
    fontSize: 36,
    fontWeight: 'bold',
    color: colors.text,
    marginBottom: 12,
  },
  tagline: {
    fontSize: 16,
    color: colors.textSecondary,
    textAlign: 'center',
    paddingHorizontal: 20,
  },
  featuresSection: {
    marginVertical: 40,
  },
  featureItem: {
    flexDirection: 'row',
    alignItems: 'center',
    marginVertical: 12,
    paddingHorizontal: 20,
  },
  featureIcon: {
    fontSize: 24,
    marginRight: 16,
  },
  featureText: {
    fontSize: 16,
    color: colors.text,
    flex: 1,
  },
  authSection: {
    marginBottom: 40,
  },
  signInButton: {
    paddingVertical: 8,
    borderRadius: 8,
  },
  signInButtonLabel: {
    fontSize: 16,
    fontWeight: '600',
  },
  errorText: {
    color: colors.error,
    textAlign: 'center',
    marginTop: 16,
    fontSize: 14,
  },
});