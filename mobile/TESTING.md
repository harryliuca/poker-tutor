# Testing Guide

## Running Tests

```bash
# Run all tests
npm test

# Run tests in watch mode (re-runs on file changes)
npm run test:watch

# Run tests with coverage report
npm run test:coverage
```

## Test Structure

```
src/
├── utils/
│   ├── __tests__/
│   │   ├── scoring.test.ts        # Scoring logic tests
│   │   ├── streak.test.ts         # Streak calculation tests
│   │   └── formatting.test.ts     # Formatting utilities tests
│   ├── scoring.ts
│   ├── streak.ts
│   └── formatting.ts
```

## Test Coverage

### Utility Functions

#### `scoring.ts`
- ✅ `calculateScore()` - Score calculation with bonus
- ✅ `calculateAccuracy()` - Accuracy percentage calculation

#### `streak.ts`
- ✅ `areConsecutiveDays()` - Check if two dates are consecutive
- ✅ `isToday()` - Check if date is today
- ✅ `calculateNewStreak()` - Calculate streak based on last practice

#### `formatting.ts`
- ✅ `formatDate()` - Format dates for display
- ✅ `formatAccuracy()` - Format accuracy as percentage
- ✅ `getRelativeTime()` - Get relative time strings

## Test Examples

### Testing Scoring Logic

```typescript
import { calculateScore } from '../scoring';

describe('calculateScore', () => {
  it('should add bonus for perfect score', () => {
    expect(calculateScore(10, 10)).toBe(120); // (10 * 10) + 20 bonus
  });
});
```

### Testing Streak Calculation

```typescript
import { calculateNewStreak } from '../streak';

describe('calculateNewStreak', () => {
  it('should increment streak for consecutive days', () => {
    const yesterday = '2025-09-29';
    expect(calculateNewStreak(yesterday, 5)).toBe(6);
  });
});
```

## Adding New Tests

1. Create a `__tests__` directory next to the file you're testing
2. Create a test file with `.test.ts` or `.test.tsx` extension
3. Write tests using Jest's `describe`, `it`, and `expect`

Example:
```typescript
import { myFunction } from '../myFile';

describe('myFunction', () => {
  it('should do something', () => {
    expect(myFunction(input)).toBe(expectedOutput);
  });
});
```

## Mocking Supabase

For tests that interact with Supabase, you'll need to mock it:

```typescript
jest.mock('../../services/supabase', () => ({
  supabase: {
    from: jest.fn(() => ({
      select: jest.fn(() => ({
        eq: jest.fn(() => Promise.resolve({ data: mockData, error: null })),
      })),
    })),
  },
}));
```

## Coverage Goals

- **Utility functions**: 100% coverage
- **Services**: 80%+ coverage
- **Components**: 60%+ coverage
- **Overall**: 70%+ coverage

## CI/CD Integration

Tests should be run automatically in CI/CD:

```yaml
# .github/workflows/test.yml
- name: Run tests
  run: npm test -- --coverage
```

## Best Practices

1. **Test behavior, not implementation** - Test what the function does, not how
2. **Keep tests simple** - One assertion per test when possible
3. **Use descriptive test names** - "should calculate bonus for perfect score"
4. **Test edge cases** - Zero values, null, undefined, boundaries
5. **Mock external dependencies** - Database, API calls, etc.

## Common Test Patterns

### Testing with dates
```typescript
const today = new Date();
const yesterday = new Date();
yesterday.setDate(yesterday.getDate() - 1);
```

### Testing async functions
```typescript
it('should fetch data', async () => {
  const result = await fetchData();
  expect(result).toBeDefined();
});
```

### Testing error handling
```typescript
it('should handle errors', () => {
  expect(() => functionThatThrows()).toThrow();
});
```