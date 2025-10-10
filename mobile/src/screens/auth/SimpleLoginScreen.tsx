import React, { useState } from 'react';
import { View, StyleSheet } from 'react-native';
import { Text, TextInput, Button } from 'react-native-paper';
import { SafeAreaView } from 'react-native-safe-area-context';
import { supabase } from '../../services/supabase';
import { LoadingSpinner } from '../../components/common/LoadingSpinner';
import { colors } from '../../constants/colors';

export const SimpleLoginScreen: React.FC = () => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [isSignUp, setIsSignUp] = useState(false);

  const handleAuth = async () => {
    if (!email || !password) {
      setError('Please enter email and password');
      return;
    }

    try {
      setLoading(true);
      setError(null);

      if (isSignUp) {
        // Sign up
        const { data, error } = await supabase.auth.signUp({
          email,
          password,
          options: {
            data: {
              full_name: email.split('@')[0], // Use email prefix as name
            },
          },
        });

        if (error) throw error;

        if (data.user && !data.session) {
          setError('Please check your email to verify your account!');
        }
      } else {
        // Sign in
        const { error } = await supabase.auth.signInWithPassword({
          email,
          password,
        });

        if (error) throw error;
      }
    } catch (err: any) {
      setError(err.message || 'Authentication failed');
      console.error('Auth error:', err);
    } finally {
      setLoading(false);
    }
  };

  if (loading) {
    return <LoadingSpinner message={isSignUp ? 'Creating account...' : 'Signing in...'} />;
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

        {/* Auth form */}
        <View style={styles.formSection}>
          <TextInput
            label="Email"
            value={email}
            onChangeText={setEmail}
            autoCapitalize="none"
            keyboardType="email-address"
            style={styles.input}
            mode="outlined"
          />

          <TextInput
            label="Password"
            value={password}
            onChangeText={setPassword}
            secureTextEntry
            style={styles.input}
            mode="outlined"
          />

          {error && <Text style={styles.errorText}>{error}</Text>}

          <Button
            mode="contained"
            onPress={handleAuth}
            style={styles.button}
            disabled={loading}
          >
            {isSignUp ? 'Sign Up' : 'Sign In'}
          </Button>

          <Button
            mode="text"
            onPress={() => {
              setIsSignUp(!isSignUp);
              setError(null);
            }}
            style={styles.switchButton}
          >
            {isSignUp ? 'Already have an account? Sign In' : "Don't have an account? Sign Up"}
          </Button>
        </View>

        {/* Features section */}
        <View style={styles.featuresSection}>
          <Text style={styles.featureText}>🎯 Daily challenges</Text>
          <Text style={styles.featureText}>📊 Track your progress</Text>
          <Text style={styles.featureText}>🎓 Learn from experts</Text>
        </View>
      </View>
    </SafeAreaView>
  );
};

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
    marginTop: 40,
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
  formSection: {
    width: '100%',
  },
  input: {
    marginBottom: 16,
  },
  button: {
    marginTop: 8,
    paddingVertical: 8,
  },
  switchButton: {
    marginTop: 16,
  },
  errorText: {
    color: colors.error,
    textAlign: 'center',
    marginBottom: 16,
    fontSize: 14,
  },
  featuresSection: {
    alignItems: 'center',
    marginBottom: 20,
  },
  featureText: {
    fontSize: 14,
    color: colors.textSecondary,
    marginVertical: 4,
  },
});