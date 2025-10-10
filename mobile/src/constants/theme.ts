import { MD3DarkTheme, MD3LightTheme } from 'react-native-paper';
import { colors, lightColors } from './colors';

export const darkTheme = {
  ...MD3DarkTheme,
  colors: {
    ...MD3DarkTheme.colors,
    primary: colors.primary,
    secondary: colors.secondary,
    background: colors.background,
    surface: colors.surface,
    error: colors.error,
    onPrimary: colors.text,
    onSecondary: colors.text,
    onBackground: colors.text,
    onSurface: colors.text,
  },
  custom: colors,
};

export const lightTheme = {
  ...MD3LightTheme,
  colors: {
    ...MD3LightTheme.colors,
    primary: lightColors.primary,
    secondary: lightColors.secondary,
    background: lightColors.background,
    surface: lightColors.surface,
    error: lightColors.error,
    onPrimary: lightColors.text,
    onSecondary: lightColors.text,
    onBackground: lightColors.text,
    onSurface: lightColors.text,
  },
  custom: lightColors,
};

export type AppTheme = typeof darkTheme;