import { calculateScore, calculateAccuracy } from '../scoring';

describe('calculateScore', () => {
  it('should calculate base score for partial correct answers', () => {
    expect(calculateScore(5, 10)).toBe(50); // 5 * 10 points = 50
  });

  it('should add bonus for perfect score', () => {
    expect(calculateScore(10, 10)).toBe(120); // (10 * 10) + 20 bonus = 120
  });

  it('should handle zero correct answers', () => {
    expect(calculateScore(0, 10)).toBe(0);
  });

  it('should handle single question', () => {
    expect(calculateScore(1, 1)).toBe(30); // 10 + 20 bonus = 30
  });

  it('should not give bonus for non-perfect score', () => {
    expect(calculateScore(9, 10)).toBe(90); // No bonus
  });
});

describe('calculateAccuracy', () => {
  it('should calculate accuracy percentage correctly', () => {
    expect(calculateAccuracy(8, 10)).toBe(80);
    expect(calculateAccuracy(5, 10)).toBe(50);
    expect(calculateAccuracy(10, 10)).toBe(100);
  });

  it('should handle zero correct answers', () => {
    expect(calculateAccuracy(0, 10)).toBe(0);
  });

  it('should handle zero total questions', () => {
    expect(calculateAccuracy(0, 0)).toBe(0);
  });

  it('should round to nearest integer', () => {
    expect(calculateAccuracy(7, 9)).toBe(78); // 77.77... rounds to 78
    expect(calculateAccuracy(1, 3)).toBe(33); // 33.33... rounds to 33
  });
});