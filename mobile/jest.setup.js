// Set test environment variables
process.env.EXPO_PUBLIC_SUPABASE_URL = 'https://test.supabase.co';
process.env.EXPO_PUBLIC_SUPABASE_ANON_KEY = 'test-anon-key';

// Mock AsyncStorage
jest.mock('@react-native-async-storage/async-storage', () => ({
  setItem: jest.fn(() => Promise.resolve()),
  getItem: jest.fn(() => Promise.resolve(null)),
  removeItem: jest.fn(() => Promise.resolve()),
  clear: jest.fn(() => Promise.resolve()),
}));

// Mock react-native-paper components
jest.mock('react-native-paper', () => {
  const React = require('react');
  const { View, Text } = require('react-native');

  return {
    Provider: ({ children }: any) => children,
    DefaultTheme: {},
    Text: (props: any) => React.createElement(Text, props),
    Button: (props: any) => React.createElement(View, { testID: 'button', ...props }),
    Card: ({ children, ...props }: any) => React.createElement(View, { testID: 'card', ...props }, children),
    Divider: (props: any) => React.createElement(View, { testID: 'divider', ...props }),
    ProgressBar: (props: any) => React.createElement(View, { testID: 'progress-bar', ...props }),
  };
});
