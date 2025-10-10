/**
 * Parse date string to local Date at midnight
 */
const parseDate = (date: string | Date): Date => {
  if (date instanceof Date) {
    return date;
  }

  // Parse YYYY-MM-DD as local date at midnight
  const parts = date.split('T')[0].split('-');
  return new Date(parseInt(parts[0]), parseInt(parts[1]) - 1, parseInt(parts[2]), 0, 0, 0, 0);
};

/**
 * Format a date to a readable string
 */
export const formatDate = (date: string | Date): string => {
  const d = parseDate(date);
  return d.toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'short',
    day: 'numeric',
  });
};

/**
 * Format accuracy as percentage
 */
export const formatAccuracy = (correct: number, total: number): string => {
  if (total === 0) return '0%';
  return `${Math.round((correct / total) * 100)}%`;
};

/**
 * Format poker hand notation with suits
 */
export const formatHand = (hand: string): string => {
  // Convert hand notation like "AKs" to "A♠ K♠" or "72o" to "7♥ 2♦"
  // For now, just return the hand as-is
  // TODO: Implement proper suit rendering
  return hand;
};

/**
 * Get relative time string (e.g., "2 hours ago")
 */
export const getRelativeTime = (date: string | Date): string => {
  const d = parseDate(date);
  const now = new Date();
  const diffMs = now.getTime() - d.getTime();
  const diffSec = Math.floor(diffMs / 1000);
  const diffMin = Math.floor(diffSec / 60);
  const diffHour = Math.floor(diffMin / 60);
  const diffDay = Math.floor(diffHour / 24);

  if (diffSec < 60) return 'just now';
  if (diffMin < 60) return `${diffMin}m ago`;
  if (diffHour < 24) return `${diffHour}h ago`;
  if (diffDay < 7) return `${diffDay}d ago`;
  return formatDate(d);
};