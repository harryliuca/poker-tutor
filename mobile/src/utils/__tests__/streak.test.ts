import { areConsecutiveDays, isToday, calculateNewStreak } from '../streak';

describe('areConsecutiveDays', () => {
  it('should return true for consecutive days', () => {
    const date1 = new Date('2025-09-29');
    const date2 = new Date('2025-09-30');
    expect(areConsecutiveDays(date1, date2)).toBe(true);
  });

  it('should return false for non-consecutive days', () => {
    const date1 = new Date('2025-09-28');
    const date2 = new Date('2025-09-30');
    expect(areConsecutiveDays(date1, date2)).toBe(false);
  });

  it('should work with string dates', () => {
    expect(areConsecutiveDays('2025-09-29', '2025-09-30')).toBe(true);
  });

  it('should return false for same day', () => {
    const date = new Date('2025-09-30');
    expect(areConsecutiveDays(date, date)).toBe(false);
  });

  it('should handle month boundaries', () => {
    expect(areConsecutiveDays('2025-09-30', '2025-10-01')).toBe(true);
  });
});

describe('isToday', () => {
  it('should return true for today', () => {
    const today = new Date();
    expect(isToday(today)).toBe(true);
  });

  it('should return false for yesterday', () => {
    const yesterday = new Date();
    yesterday.setDate(yesterday.getDate() - 1);
    expect(isToday(yesterday)).toBe(false);
  });

  it('should work with string dates', () => {
    const todayString = new Date().toISOString().split('T')[0];
    expect(isToday(todayString)).toBe(true);
  });
});

describe('calculateNewStreak', () => {
  it('should start streak at 1 for first practice', () => {
    expect(calculateNewStreak(null, 0)).toBe(1);
  });

  it('should increment streak for consecutive days', () => {
    const yesterday = new Date();
    yesterday.setDate(yesterday.getDate() - 1);
    const yesterdayString = yesterday.toISOString().split('T')[0];

    expect(calculateNewStreak(yesterdayString, 5)).toBe(6);
  });

  it('should reset streak for non-consecutive days', () => {
    const twoDaysAgo = new Date();
    twoDaysAgo.setDate(twoDaysAgo.getDate() - 2);
    const dateString = twoDaysAgo.toISOString().split('T')[0];

    expect(calculateNewStreak(dateString, 10)).toBe(1);
  });

  it('should maintain streak if already practiced today', () => {
    const today = new Date().toISOString().split('T')[0];
    expect(calculateNewStreak(today, 7)).toBe(7);
  });
});