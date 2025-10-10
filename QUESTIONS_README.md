# Poker Tutor - Question Library

## Overview

Complete set of **161 high-quality poker decision-making questions** for Texas Hold'em No-Limit poker.

---

## Question Breakdown

### By Category (5 categories)

| Category | Beginner | Intermediate | Advanced | **Total** |
|----------|----------|--------------|----------|-----------|
| **Pre-Flop** | 14 | 21 | 20 | **55** |
| **Post-Flop** | 11 | 11 | 10 | **32** |
| **Turn** | 11 | 10 | 10 | **31** |
| **River** | 11 | 10 | 10 | **31** |
| **Special** | 4 | 5 | 3 | **12** |
| **TOTAL** | **51** | **57** | **53** | **161** |

---

## SQL Files

The questions are split across 4 SQL files for easier management:

1. **`questions-150.sql`** - Pre-Flop questions (55 total)
   - Beginner: 14 questions
   - Intermediate: 21 questions
   - Advanced: 20 questions

2. **`questions-part2.sql`** - Post-Flop questions (32 total)
   - Beginner: 11 questions
   - Intermediate: 11 questions
   - Advanced: 10 questions

3. **`questions-part3.sql`** - Turn questions (31 total)
   - Beginner: 11 questions
   - Intermediate: 10 questions
   - Advanced: 10 questions

4. **`questions-part4-final.sql`** - River + Special (43 total)
   - River Beginner: 11 questions
   - River Intermediate: 10 questions
   - River Advanced: 10 questions
   - Special Situations: 12 questions (mixed difficulty)

---

## Installation

### Option 1: Run all files sequentially

```bash
# In Supabase SQL Editor, run each file in order:
1. questions-150.sql
2. questions-part2.sql
3. questions-part3.sql
4. questions-part4-final.sql
```

### Option 2: Merge and run as one file

```bash
# Merge all files:
cat questions-150.sql questions-part2.sql questions-part3.sql questions-part4-final.sql > all-questions.sql

# Then run all-questions.sql in Supabase SQL Editor
```

---

## Question Structure

Each question follows this format:

```sql
INSERT INTO public.questions (category, difficulty, scenario, question_text, choices, correct_answer, explanation, key_concepts)
VALUES
(
  'pre-flop',                          -- Category
  'beginner',                          -- Difficulty
  '{                                    -- Scenario (JSONB)
    "yourHand": "AA",
    "position": "Button",
    "stackSize": 100,
    "blinds": "1/2",
    "potSize": 3,
    "actionSoFar": "Folds to you",
    "playersRemaining": 3,
    "effectiveStacks": 100
  }'::jsonb,
  'What is the best action?',          -- Question text
  '[                                    -- Choices (JSONB)
    {"id": "A", "action": "Fold"},
    {"id": "B", "action": "Call 2"},
    {"id": "C", "action": "Raise to 6"},
    {"id": "D", "action": "All-in"}
  ]'::jsonb,
  'C',                                  -- Correct answer
  'Pocket Aces is the strongest starting hand...',  -- Explanation
  ARRAY['premium hands', 'position', 'value raising']  -- Key concepts
);
```

---

## Category Details

### 1. Pre-Flop (55 questions)

**Focus**: Starting hand selection, position play, 3-betting, 4-betting

- **Beginner (14)**: Basic hand strength, position awareness, facing single raises
- **Intermediate (21)**: 3-betting ranges, adjusting to stack sizes, multi-way pots
- **Advanced (20)**: 4-bet pots, polarized ranges, ICM considerations

**Key Concepts**: Premium hands, position, 3-betting, 4-betting, hand selection, stack depth

---

### 2. Post-Flop (32 questions)

**Focus**: Continuation betting, calling, folding to aggression, semi-bluffing

- **Beginner (11)**: Made hands, drawing hands, basic c-betting
- **Intermediate (11)**: Check-raising, pot control, facing aggression
- **Advanced (10)**: Range betting, bluff frequency, board texture analysis

**Key Concepts**: C-betting, value betting, semi-bluffing, draws, check-raising, range advantage

---

### 3. Turn (31 questions)

**Focus**: Turn play after flop action, double barreling, pot control

- **Beginner (11)**: Turn improvements, scare cards, simple decisions
- **Intermediate (10)**: Double barreling, probe betting, pot control
- **Advanced (10)**: Merge betting, polarization, giving up bluffs

**Key Concepts**: Double barrel, turn aggression, pot control, made hands, draws

---

### 4. River (31 questions)

**Focus**: Value betting, bluff catching, river decisions, bet sizing

- **Beginner (11)**: Value betting strong hands, folding weak hands
- **Intermediate (10)**: Thin value, triple barrel bluffs, pot odds
- **Advanced (10)**: Polarization, showdown value, exploiting capped ranges

**Key Concepts**: River value, bluff catching, pot odds, triple barrel, showdown value

---

### 5. Special Situations (12 questions)

**Focus**: Short stack play, multi-way pots, bubble play, push/fold

- **Beginner (4)**: Basic short stack decisions, simple push/fold spots
- **Intermediate (5)**: Multi-way dynamics, squeeze plays, bubble considerations
- **Advanced (3)**: Complex ICM spots, advanced tournament strategy

**Key Concepts**: Short stack, push/fold, multi-way pots, ICM, bubble play

---

## Difficulty Levels

### Beginner (51 questions)
- Focus on fundamental concepts
- Clear correct answers
- Basic scenarios
- **Topics**: Hand strength, position, basic betting, simple math

### Intermediate (57 questions)
- More complex situations
- Multiple viable options
- Requires understanding ranges
- **Topics**: 3-betting, c-betting, semi-bluffing, pot control, aggression

### Advanced (53 questions)
- Nuanced decision-making
- Polarized strategies
- ICM and game theory
- **Topics**: 4-betting, range balancing, exploitative play, merge betting, GTO concepts

---

## Testing the Questions

### Quick Test (10 questions)
```sql
-- Get 10 random questions
SELECT * FROM questions ORDER BY random() LIMIT 10;
```

### Test by Category
```sql
-- Get all pre-flop beginner questions
SELECT * FROM questions
WHERE category = 'pre-flop' AND difficulty = 'beginner';
```

### Test Daily Challenge Format
```sql
-- Simulate a daily challenge (10 beginner questions)
SELECT * FROM questions
WHERE difficulty = 'beginner'
ORDER BY random()
LIMIT 10;
```

---

## Question Quality Standards

Each question meets these criteria:

✅ **Poker Accuracy**: Correct from a poker theory standpoint
✅ **Clear Correct Answer**: One optimal action (or specified close decisions)
✅ **Realistic Scenarios**: Believable stack sizes, positions, and actions
✅ **Educational Explanations**: Teach concepts, not just state answers
✅ **Proper Notation**: Standard hand notation (AK, QQ, 72o, etc.)
✅ **Difficulty Appropriate**: Matches the assigned skill level
✅ **Key Concepts**: 2-3 tags for each question

---

## Key Concepts Covered

### Pre-Flop Concepts
- Premium hands
- Hand selection
- Position awareness
- 3-betting (value & bluff)
- 4-betting
- Stack depth
- ICM

### Post-Flop Concepts
- Continuation betting
- Value betting
- Semi-bluffing
- Check-raising
- Draws (flush, straight)
- Range advantage
- Board texture

### Turn Concepts
- Double barrel
- Pot control
- Scare cards
- Giving up bluffs
- Merge betting
- Probe betting

### River Concepts
- Triple barrel
- Value betting
- Bluff catching
- Showdown value
- Pot odds
- Thin value
- River sizing

### Special Situations
- Short stack play
- Push/fold decisions
- Multi-way pots
- Bubble play
- ICM (Independent Chip Model)
- Squeeze plays

---

## Next Steps

After loading the questions:

1. ✅ **Verify Count**: Confirm 161 questions loaded
   ```sql
   SELECT category, difficulty, COUNT(*)
   FROM questions
   GROUP BY category, difficulty
   ORDER BY category, difficulty;
   ```

2. ✅ **Test Random Selection**: Ensure randomization works
   ```sql
   SELECT * FROM questions ORDER BY random() LIMIT 10;
   ```

3. ✅ **Test in App**: Create a daily challenge and verify questions display correctly

4. 🔄 **Continuous Improvement**:
   - Track which questions users get wrong most often
   - Add more questions based on user feedback
   - Update explanations based on common misconceptions
   - Balance difficulty distribution

---

## Future Enhancements

- 🎯 **User Submissions**: Allow experienced players to submit questions
- 📊 **Question Analytics**: Track accuracy rates per question
- 🔄 **Question Variations**: Create similar questions with different values
- 🏆 **Difficulty Adjustment**: Adapt question difficulty based on user performance
- 🎓 **Learning Paths**: Curated question sequences for specific concepts
- 📚 **More Categories**: Add tournament-specific, cash game-specific questions

---

## Contributing

To add new questions:

1. Follow the existing structure
2. Ensure poker accuracy
3. Write clear, educational explanations
4. Tag with appropriate key concepts
5. Test thoroughly before adding to production

---

## Credits

**Question Design**: Custom-created for Poker Tutor
**Poker Theory**: Based on modern GTO and exploitative strategies
**Quality Assurance**: All questions reviewed for accuracy and clarity

---

**Total Questions**: 161
**Last Updated**: 2025-09-30
**Version**: 1.1.0
