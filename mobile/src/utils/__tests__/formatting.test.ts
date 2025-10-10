import { formatDate, formatAccuracy, getRelativeTime } from '../formatting';

describe('formatDate', () => {
  it('should format date string correctly', () => {
    const date = '2025-09-30';
    const formatted = formatDate(date);
    expect(formatted).toContain('Sep');
    expect(formatted).toContain('30');
    expect(formatted).toContain('2025');
  });

  it('should format Date object correctly', () => {
    const date = new Date('2025-09-30');
    const formatted = formatDate(date);
    expect(formatted).toContain('Sep');
  });
});

describe('formatAccuracy', () => {
  it('should format accuracy as percentage', () => {
    expect(formatAccuracy(8, 10)).toBe('80%');
    expect(formatAccuracy(10, 10)).toBe('100%');
    expect(formatAccuracy(0, 10)).toBe('0%');
  });

  it('should handle zero total', () => {
    expect(formatAccuracy(0, 0)).toBe('0%');
  });

  it('should round correctly', () => {
    expect(formatAccuracy(7, 9)).toBe('78%');
    expect(formatAccuracy(1, 3)).toBe('33%');
  });
});

describe('getRelativeTime', () => {
  it('should return "just now" for recent times', () => {
    const now = new Date();
    expect(getRelativeTime(now)).toBe('just now');
  });

  it('should return minutes for times less than an hour ago', () => {
    const time = new Date();
    time.setMinutes(time.getMinutes() - 5);
    expect(getRelativeTime(time)).toBe('5m ago');
  });

  it('should return hours for times less than a day ago', () => {
    const time = new Date();
    time.setHours(time.getHours() - 3);
    expect(getRelativeTime(time)).toBe('3h ago');
  });

  it('should return days for times less than a week ago', () => {
    const time = new Date();
    time.setDate(time.getDate() - 2);
    expect(getRelativeTime(time)).toBe('2d ago');
  });

  it('should return formatted date for times over a week ago', () => {
    const time = '2025-01-01';
    const result = getRelativeTime(time);
    expect(result).toContain('Jan');
  });
});