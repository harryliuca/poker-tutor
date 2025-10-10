import React, { useState, useEffect } from 'react';
import { View, StyleSheet, Alert, Platform } from 'react-native';
import { QuestionScreen } from './QuestionScreen';
import { AnswerResultScreen } from './AnswerResultScreen';
import { ChallengeCompletedScreen } from './ChallengeCompletedScreen';
import { LoadingSpinner } from '../../components/common/LoadingSpinner';
import { ErrorMessage } from '../../components/common/ErrorMessage';
import { Question } from '../../types';
import { fetchPracticeQuestions, fetchQuestionsByIds } from '../../services/questions';
import { submitAnswer } from '../../services/answers';
import { useAuth } from '../../contexts/AuthContext';
import { supabase } from '../../services/supabase';
import { getOrCreateTodaysChallenge } from '../../services/dailyChallenge';

interface ChallengeFlowScreenProps {
  mode: 'daily_challenge' | 'random_practice';
  onComplete: () => void;
  onExit: () => void;
}

export const ChallengeFlowScreen: React.FC<ChallengeFlowScreenProps> = ({
  mode,
  onComplete,
  onExit,
}) => {
  const { user } = useAuth();
  const [questions, setQuestions] = useState<Question[]>([]);
  const [currentIndex, setCurrentIndex] = useState(0);
  const [showResult, setShowResult] = useState(false);
  const [userAnswer, setUserAnswer] = useState<string | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [score, setScore] = useState({ correct: 0, total: 0 });
  const [showCompletion, setShowCompletion] = useState(false);

  useEffect(() => {
    loadQuestions();
  }, []);

  const loadQuestions = async () => {
    try {
      setLoading(true);
      setError(null);

      console.log('🔵 Loading questions... mode:', mode);

      let fetchedQuestions: Question[] = [];

      if (mode === 'daily_challenge') {
        // For daily challenge, get fixed set of questions for today
        const { challenge, error: challengeError } = await getOrCreateTodaysChallenge();

        if (challengeError || !challenge) {
          console.error('🔴 Challenge error:', challengeError);
          throw new Error('Failed to load daily challenge');
        }

        console.log('📅 Loading challenge questions:', challenge.question_ids.length);
        const { questions, error: questionsError } = await fetchQuestionsByIds(challenge.question_ids);

        if (questionsError || !questions) {
          throw new Error('Failed to load challenge questions');
        }

        fetchedQuestions = questions;
      } else {
        // For random practice, fetch random questions
        const { questions, error: fetchError } = await fetchPracticeQuestions(
          'beginner',
          undefined,
          10
        );

        if (fetchError) {
          console.error('🔴 Fetch error:', fetchError);
          throw fetchError;
        }

        fetchedQuestions = questions || [];
      }

      console.log('🔵 Fetched questions:', fetchedQuestions?.length);

      if (!fetchedQuestions || fetchedQuestions.length === 0) {
        console.error('🔴 No questions available');
        setError('No questions available. Please add questions to the database.');
        return;
      }

      setQuestions(fetchedQuestions);
      console.log('🔵 Questions set');

      // If daily challenge, check if user already answered some questions today
      if (mode === 'daily_challenge' && user) {
        console.log('🔵 Checking for previous answers...');
        try {
          const today = new Date().toISOString().split('T')[0];
          const { data: answeredToday, error: answersError } = await supabase
            .from('user_answers')
            .select('question_id, is_correct')
            .eq('user_id', user.id)
            .eq('practice_mode', 'daily_challenge')
            .eq('challenge_date', today);

          console.log('🔵 Previous answers:', answeredToday?.length || 0);

          if (answersError) {
            console.error('🔴 Error fetching previous answers:', answersError);
          }

          if (answeredToday && answeredToday.length > 0) {
            // Find which questions in current batch were already answered
            const answeredIds = new Set(answeredToday.map(a => a.question_id));
            const currentBatchAnswered = fetchedQuestions.filter(q => answeredIds.has(q.id));

            // Calculate score only for current batch
            const correctInBatch = currentBatchAnswered.filter(q => {
              const answer = answeredToday.find(a => a.question_id === q.id);
              return answer?.is_correct;
            }).length;

            setScore({
              correct: correctInBatch,
              total: currentBatchAnswered.length,
            });
            console.log('🔵 Restored score for current batch:', correctInBatch, '/', currentBatchAnswered.length);

            // Find first unanswered question in current batch
            const firstUnansweredIndex = fetchedQuestions.findIndex(
              q => !answeredIds.has(q.id)
            );

            console.log('🔵 First unanswered index:', firstUnansweredIndex);
            console.log('🔵 Total questions:', fetchedQuestions.length);
            console.log('🔵 Answered:', currentBatchAnswered.length);

            if (firstUnansweredIndex === -1) {
              // All questions answered - show completion
              console.log('🟢 Daily challenge completed! Showing completion screen');
              setShowCompletion(true);
              setLoading(false);
              return;
            } else if (firstUnansweredIndex >= 0) {
              // Start from unanswered question
              setCurrentIndex(firstUnansweredIndex);
              console.log('🔵 Starting from question', firstUnansweredIndex + 1);
            }
          }
        } catch (err) {
          console.error('🔴 Error checking previous answers:', err);
          // Continue anyway with fresh start
        }
      }
      console.log('🟢 Questions loaded successfully');
    } catch (err: any) {
      console.error('Error loading questions:', err);
      setError(err.message || 'Failed to load questions');
    } finally {
      setLoading(false);
    }
  };

  const handleAnswer = async (answer: string) => {
    setUserAnswer(answer);
    setShowResult(true);

    const currentQuestion = questions[currentIndex];
    const isCorrect = answer === currentQuestion.correct_answer;

    // Update score
    setScore(prev => ({
      correct: prev.correct + (isCorrect ? 1 : 0),
      total: prev.total + 1,
    }));

    // Submit answer to database
    if (user) {
      try {
        await submitAnswer({
          user_id: user.id,
          question_id: currentQuestion.id,
          selected_answer: answer,
          is_correct: isCorrect,
          practice_mode: mode,
          challenge_date: mode === 'daily_challenge' ? new Date().toISOString().split('T')[0] : undefined,
        });
      } catch (err) {
        console.error('Error submitting answer:', err);
      }
    }
  };

  const handleNext = () => {
    setShowResult(false);
    setUserAnswer(null);

    if (currentIndex < questions.length - 1) {
      setCurrentIndex(currentIndex + 1);
    } else {
      // Challenge complete - show completion screen
      setShowCompletion(true);
    }
  };

  const handleExit = () => {
    const message = mode === 'daily_challenge'
      ? 'Your progress will be saved and you can continue later.'
      : 'Your progress will not be saved.';

    // Web doesn't support Alert.alert, use window.confirm instead
    if (Platform.OS === 'web') {
      const confirmed = window.confirm(
        `Are you sure you want to exit? ${message}`
      );
      if (confirmed) {
        onExit();
      }
    } else {
      Alert.alert(
        mode === 'daily_challenge' ? 'Exit Daily Challenge' : 'Exit Practice',
        `Are you sure you want to exit? ${message}`,
        [
          { text: 'Cancel', style: 'cancel' },
          { text: 'Exit', style: 'destructive', onPress: onExit },
        ]
      );
    }
  };

  if (loading) {
    return <LoadingSpinner message="Loading questions..." />;
  }

  if (error) {
    return <ErrorMessage message={error} onRetry={loadQuestions} />;
  }

  if (questions.length === 0) {
    return <ErrorMessage message="No questions available" onRetry={loadQuestions} />;
  }

  // Show completion screen
  if (showCompletion) {
    return (
      <ChallengeCompletedScreen
        score={score}
        onGoHome={onComplete}
      />
    );
  }

  const currentQuestion = questions[currentIndex];

  if (showResult && userAnswer) {
    return (
      <AnswerResultScreen
        question={currentQuestion}
        userAnswer={userAnswer}
        isCorrect={userAnswer === currentQuestion.correct_answer}
        onNext={handleNext}
        isLastQuestion={currentIndex === questions.length - 1}
      />
    );
  }

  return (
    <QuestionScreen
      question={currentQuestion}
      currentQuestion={currentIndex + 1}
      totalQuestions={questions.length}
      onAnswer={handleAnswer}
      onExit={handleExit}
    />
  );
};