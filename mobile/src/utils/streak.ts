/**
 * Parse date string to local Date at midnight
 */
const parseDate = (date: string | Date): Date => {
  if (date instanceof Date) {
    const d = new Date(date);
    d.setHours(0, 0, 0, 0);
    return d;
  }

  // Parse YYYY-MM-DD as local date at midnight
  const parts = date.split('T')[0].split('-');
  return new Date(parseInt(parts[0]), parseInt(parts[1]) - 1, parseInt(parts[2]), 0, 0, 0, 0);
};

/**
 * Check if two dates are consecutive days
 */
export const areConsecutiveDays = (date1: string | Date, date2: string | Date): boolean => {
  const d1 = parseDate(date1);
  const d2 = parseDate(date2);

  const diffTime = Math.abs(d2.getTime() - d1.getTime());
  const diffDays = Math.floor(diffTime / (1000 * 60 * 60 * 24));

  return diffDays === 1;
};

/**
 * Check if a date is today
 */
export const isToday = (date: string | Date): boolean => {
  const d = parseDate(date);
  const today = parseDate(new Date());

  return d.getTime() === today.getTime();
};

/**
 * Calculate new streak based on last practice date
 */
export const calculateNewStreak = (
  lastPracticeDate: string | null,
  currentStreak: number
): number => {
  if (!lastPracticeDate) return 1;

  const lastDate = parseDate(lastPracticeDate);
  const today = parseDate(new Date());

  // If already practiced today, don't change streak
  if (isToday(lastDate)) {
    return currentStreak;
  }

  // If consecutive day, increment streak
  if (areConsecutiveDays(lastDate, today)) {
    return currentStreak + 1;
  }

  // Otherwise, reset to 1
  return 1;
};