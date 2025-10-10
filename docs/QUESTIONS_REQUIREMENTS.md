# Question Generation Requirements

## Overview

Use OpenAI API to generate 150 poker decision-making questions for Texas Hold'em No-Limit. Questions will be stored in the database and retrieved through secure API endpoints.

## Question Structure

Each question must include:

```json
{
  "id": "unique_identifier",
  "category": "pre-flop|post-flop|turn|river|special",
  "difficulty": "beginner|intermediate|advanced",
  "scenario": {
    "yourHand": "AK",
    "position": "Button|Cutoff|Middle|Early|Small Blind|Big Blind",
    "stackSize": 100,
    "blinds": "1/2",
    "potSize": 10,
    "actionSoFar": "UTG raises to 6, MP calls",
    "communityCards": "Ah 9s 3d",
    "playersRemaining": 3,
    "effectiveStacks": 85
  },
  "question": "What is the best action?",
  "choices": [
    {"id": "A", "action": "Fold"},
    {"id": "B", "action": "Call 6"},
    {"id": "C", "action": "Raise to 18"},
    {"id": "D", "action": "All-in"}
  ],
  "correctAnswer": "C",
  "explanation": "Detailed explanation of why this is the correct play, including poker theory concepts like pot odds, hand strength, position advantage, etc.",
  "keyConcepts": ["3-betting", "position", "hand strength"]
}
```

## Categories and Distribution

### 1. Pre-Flop (30 questions)
**Focus**: Starting hand selection, position play, 3-betting, 4-betting

**Beginner (10 questions)**:
- Basic hand strength (pocket pairs, suited connectors, premium hands)
- Position awareness (when to play vs fold)
- Facing a single raise
- Examples: "You have 72o in early position, UTG raises"

**Intermediate (10 questions)**:
- 3-betting for value and as bluff
- Facing 3-bets with marginal hands
- Adjusting to different stack sizes (20-50bb)
- Examples: "You have AJs in the cutoff, MP raises"

**Advanced (10 questions)**:
- 4-betting ranges
- Polarized vs linear ranges
- ICM considerations (bubble scenarios)
- Examples: "You have A5s on the button, CO raises, you 3-bet, CO 4-bets"

### 2. Post-Flop (30 questions)
**Focus**: Continuation betting, calling, folding to aggression

**Beginner (10 questions)**:
- Made hands (pair, two pair)
- Drawing hands (flush draw, straight draw)
- When to fold to a c-bet
- Examples: "You have AK, flop is K72 rainbow, opponent bets"

**Intermediate (10 questions)**:
- Semi-bluffing with draws
- Raising with strong hands vs slow-playing
- Facing check-raises
- Examples: "You have QQ, flop is J95 with flush draw, you c-bet and villain raises"

**Advanced (10 questions)**:
- Range vs range thinking
- Board texture analysis
- Balancing value and bluffs
- Examples: "You have AQ on A84ss, you bet, villain calls, turn is 2o"

### 3. Turn (30 questions)
**Focus**: Turn play after flop action, pot control, barrel decisions

**Beginner (10 questions)**:
- Made hands facing aggression
- Drawing hands with pot odds
- When hand improves on turn
- Examples: "You called flop with flush draw, turn completes flush"

**Intermediate (10 questions)**:
- Double barreling
- Turn probing after flop checks through
- Facing turn raises
- Examples: "You c-bet flop with AK on K93, get called, turn is 7"

**Advanced (10 questions)**:
- Thin value betting
- Bluff catching
- Polarized turn play
- Examples: "You have 88 on K932, opponent bets flop and turn"

### 4. River (30 questions)
**Focus**: Value betting, bluff catching, river decisions

**Beginner (10 questions)**:
- Value betting made hands
- Folding to obvious value
- Calling with good pairs
- Examples: "You have KK on K8432, river is 2, you bet flop and turn"

**Intermediate (10 questions)**:
- Thin value betting
- River bluffing missed draws
- Facing river overbet
- Examples: "You have AJ on AJ843, opponent bets big on river"

**Advanced (10 questions)**:
- Bluff catching vs polarized ranges
- Overbetting for value
- River check-raising
- Examples: "You have A9 on A8432, checked flop, called turn, river is 6"

### 5. Special Situations (30 questions)
**Focus**: All-in scenarios, short stack play, bubble play, multi-way pots

**Beginner (10 questions)**:
- Push/fold with 10-15bb
- Calling all-ins with premium hands
- Simple ICM spots
- Examples: "You have AQ with 12bb in the cutoff, blinds 1/2"

**Intermediate (10 questions)**:
- Resteal situations
- Multi-way pot decisions
- Short stack vs short stack
- Examples: "3-way pot, you have KQ on KT3, first player bets, second calls"

**Advanced (10 questions)**:
- Nash equilibrium spots
- Squeeze plays
- Final table ICM
- Examples: "Bubble of tournament, you have 88 in SB with 15bb, CO raises"

## OpenAI API Prompt Template

```
Generate a Texas Hold'em No-Limit poker question with the following parameters:

Category: {category}
Difficulty: {difficulty}

Requirements:
1. Create a realistic poker scenario with:
   - Specific hand notation (e.g., AKs, QQ, 76o)
   - Player position
   - Stack sizes in big blinds
   - Pot size
   - Action so far
   - Community cards (if post-flop/turn/river)

2. Provide 4 multiple choice answers:
   - Fold
   - Call [amount]
   - Raise to [amount]
   - All-in

3. Identify the correct answer

4. Write a detailed explanation (100-200 words) covering:
   - Why this action is optimal
   - Relevant poker concepts (pot odds, hand strength, position, etc.)
   - What makes other options suboptimal

5. List 2-3 key poker concepts being tested

Focus on decision-making and poker theory, not math calculations.

Return the response in JSON format matching this structure: {schema}
```

## Generation Process

### Step 1: Batch Generation
- Generate 10 questions per category per difficulty level
- Use OpenAI API (GPT-4 recommended for accuracy)
- Review each question for quality and accuracy

### Step 2: Manual Review
- Verify poker accuracy of scenarios
- Ensure explanations are clear and educational
- Check for duplicate scenarios
- Validate difficulty classification

### Step 3: Database Population
- Parse JSON responses
- Store in database with unique IDs
- Tag with category, difficulty, and key concepts
- Create indexes for efficient retrieval

## API Security

### Question Retrieval API
- Require authentication token from mobile app
- Rate limiting (max 100 questions per user per day)
- Never expose bulk question download endpoint
- Questions served one at a time
- Log all question retrievals for monitoring

### Security Measures
1. API key authentication (app-specific key)
2. User session validation
3. IP rate limiting
4. Randomized question selection (prevent prediction)
5. No bulk export capability

## Quality Standards

Each question must:
- Be factually accurate from a poker theory standpoint
- Have one clearly optimal answer (or specify it's a close decision)
- Include realistic stack sizes and pot sizes
- Use proper hand notation
- Have explanations that teach, not just state the answer
- Be appropriate for the difficulty level
- Test specific concepts, not be random scenarios

## Future Expansion

- Add questions regularly (target: 500+ total)
- User-submitted questions (moderated)
- Question voting/rating system
- Adaptive difficulty based on user performance
- Scenario variations to prevent memorization