import { supabase } from './supabase';
import { AUTH_CALLBACK_URL } from '../constants/config';
import * as WebBrowser from 'expo-web-browser';
import * as Linking from 'expo-linking';

// This is required for proper OAuth redirect handling
WebBrowser.maybeCompleteAuthSession();

/**
 * Sign in with Google OAuth
 */
export const signInWithGoogle = async () => {
  try {
    console.log('🟡 signInWithGoogle: Starting...');
    const redirectUrl = Linking.createURL('auth/callback');
    console.log('🟡 Redirect URL:', redirectUrl);

    console.log('🟡 Calling supabase.auth.signInWithOAuth...');
    const { data, error } = await supabase.auth.signInWithOAuth({
      provider: 'google',
      options: {
        redirectTo: redirectUrl,
        skipBrowserRedirect: false,
      },
    });

    console.log('🟡 OAuth data:', data);
    console.log('🟡 OAuth error:', error);

    if (error) throw error;

    // Open the OAuth URL in a browser
    if (data?.url) {
      console.log('🟡 Opening browser with URL:', data.url);
      const result = await WebBrowser.openAuthSessionAsync(
        data.url,
        redirectUrl
      );

      console.log('🟡 Browser result:', result);

      if (result.type === 'success') {
        console.log('🟡 Success! Result URL:', result.url);
        // Extract the session from the URL
        const url = result.url;
        const params = new URLSearchParams(url.split('#')[1] || url.split('?')[1]);
        const accessToken = params.get('access_token');
        const refreshToken = params.get('refresh_token');

        console.log('🟡 Access token found:', !!accessToken);

        if (accessToken) {
          // Set the session
          console.log('🟡 Setting session...');
          const { data: sessionData, error: sessionError } = await supabase.auth.setSession({
            access_token: accessToken,
            refresh_token: refreshToken || '',
          });

          console.log('🟡 Session data:', sessionData);
          if (sessionError) {
            console.error('🔴 Session error:', sessionError);
            throw sessionError;
          }
          return { data: sessionData, error: null };
        }
      } else {
        console.log('🟡 Browser result type:', result.type);
      }
    } else {
      console.log('🔴 No URL in OAuth data!');
    }

    return { data, error: null };
  } catch (error) {
    console.error('🔴 Error signing in with Google:', error);
    return { data: null, error };
  }
};

/**
 * Sign out the current user
 */
export const signOut = async () => {
  try {
    const { error } = await supabase.auth.signOut();
    if (error) throw error;
    return { error: null };
  } catch (error) {
    console.error('Error signing out:', error);
    return { error };
  }
};

/**
 * Get the current user session
 */
export const getSession = async () => {
  try {
    const { data, error } = await supabase.auth.getSession();
    if (error) throw error;
    return { session: data.session, error: null };
  } catch (error) {
    console.error('Error getting session:', error);
    return { session: null, error };
  }
};

/**
 * Get the current user
 */
export const getCurrentUser = async () => {
  try {
    const { data: { user }, error } = await supabase.auth.getUser();
    if (error) throw error;
    return { user, error: null };
  } catch (error) {
    console.error('Error getting current user:', error);
    return { user: null, error };
  }
};