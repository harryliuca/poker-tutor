import React, { useState } from 'react';
import { StatusBar } from 'expo-status-bar';
import { AuthProvider, useAuth } from './src/contexts/AuthContext';
import { QueryProvider } from './src/contexts/QueryProvider';
import { ThemeProvider } from './src/contexts/ThemeProvider';
import { SimpleLoginScreen } from './src/screens/auth/SimpleLoginScreen';
import { HomeScreen } from './src/screens/home/HomeScreen';
import { ChallengeFlowScreen } from './src/screens/practice/ChallengeFlowScreen';
import { ProfileScreen } from './src/screens/profile/ProfileScreen';
import { LoadingSpinner } from './src/components/common/LoadingSpinner';

type Screen = 'home' | 'daily_challenge' | 'random_practice' | 'profile';

function AppContent() {
  const { user, loading } = useAuth();
  const [currentScreen, setCurrentScreen] = useState<Screen>('home');

  if (loading) {
    return <LoadingSpinner />;
  }

  if (!user) {
    return (
      <>
        <SimpleLoginScreen />
        <StatusBar style="light" />
      </>
    );
  }

  // Render different screens based on navigation
  const renderScreen = () => {
    switch (currentScreen) {
      case 'daily_challenge':
        return (
          <ChallengeFlowScreen
            mode="daily_challenge"
            onComplete={() => setCurrentScreen('home')}
            onExit={() => setCurrentScreen('home')}
          />
        );
      case 'random_practice':
        return (
          <ChallengeFlowScreen
            mode="random_practice"
            onComplete={() => setCurrentScreen('home')}
            onExit={() => setCurrentScreen('home')}
          />
        );
      case 'profile':
        return (
          <ProfileScreen
            onBack={() => setCurrentScreen('home')}
          />
        );
      case 'home':
      default:
        return (
          <HomeScreen
            onStartChallenge={() => setCurrentScreen('daily_challenge')}
            onStartPractice={() => setCurrentScreen('random_practice')}
            onViewProfile={() => setCurrentScreen('profile')}
          />
        );
    }
  };

  return (
    <>
      {renderScreen()}
      <StatusBar style="light" />
    </>
  );
}

export default function App() {
  return (
    <QueryProvider>
      <ThemeProvider>
        <AuthProvider>
          <AppContent />
        </AuthProvider>
      </ThemeProvider>
    </QueryProvider>
  );
}
