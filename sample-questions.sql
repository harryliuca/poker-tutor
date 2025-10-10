-- Sample Questions for Testing
-- Run this in Supabase SQL Editor to add test questions

INSERT INTO public.questions (category, difficulty, scenario, question_text, choices, correct_answer, explanation, key_concepts)
VALUES
-- Pre-flop questions
(
  'pre-flop',
  'beginner',
  '{"yourHand": "AA", "position": "Button", "stackSize": 100, "blinds": "1/2", "potSize": 3, "actionSoFar": "Folds to you", "playersRemaining": 3, "effectiveStacks": 100}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 2"}, {"id": "C", "action": "Raise to 6"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'C',
  'Pocket Aces is the strongest starting hand in poker. From the button with a strong hand, you should raise to build the pot and take control of the hand. A standard raise to 3BB (6 chips) is appropriate.',
  ARRAY['premium hands', 'position', 'aggression']
),
(
  'pre-flop',
  'beginner',
  '{"yourHand": "72o", "position": "Early", "stackSize": 100, "blinds": "1/2", "potSize": 3, "actionSoFar": "Action is on you", "playersRemaining": 9, "effectiveStacks": 100}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 2"}, {"id": "C", "action": "Raise to 6"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'A',
  '72o is the worst starting hand in poker. From early position with many players behind you, this is an easy fold. Only play premium hands from early position.',
  ARRAY['hand selection', 'position', 'discipline']
),
(
  'pre-flop',
  'intermediate',
  '{"yourHand": "AJs", "position": "Cutoff", "stackSize": 100, "blinds": "1/2", "potSize": 7, "actionSoFar": "MP raises to 6", "playersRemaining": 6, "effectiveStacks": 94}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 6"}, {"id": "C", "action": "Raise to 18"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'C',
  'AJs is a strong hand that plays well in 3-bet pots. From the cutoff, you have good position post-flop. A 3-bet to 18 chips puts pressure on the initial raiser and builds the pot with your strong hand.',
  ARRAY['3-betting', 'position', 'hand strength']
),

-- Post-flop questions
(
  'post-flop',
  'beginner',
  '{"yourHand": "AK", "position": "Button", "stackSize": 94, "blinds": "1/2", "potSize": 15, "actionSoFar": "You raised pre-flop, BB called", "communityCards": "K 7 2 rainbow", "playersRemaining": 2, "effectiveStacks": 85}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 8"}, {"id": "C", "action": "Bet 15"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'B',
  'You have top pair, top kicker on a dry board. You should continuation bet for value and protection. A bet of about half pot (8 chips) is appropriate to build the pot and charge worse hands to continue.',
  ARRAY['continuation betting', 'value betting', 'top pair']
),
(
  'post-flop',
  'intermediate',
  '{"yourHand": "QQ", "position": "Button", "stackSize": 85, "blinds": "1/2", "potSize": 20, "actionSoFar": "You c-bet 10, villain raises to 30", "communityCards": "J 9 5 two-tone", "playersRemaining": 2, "effectiveStacks": 75}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 20"}, {"id": "C", "action": "Re-raise to 70"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'B',
  'You have an overpair but face a check-raise on a connected board. Calling keeps the pot manageable and lets you see the turn. You have position and can reassess on later streets.',
  ARRAY['facing aggression', 'pot control', 'overpair']
),

-- Turn questions
(
  'turn',
  'beginner',
  '{"yourHand": "A♠ Q♠", "position": "Button", "stackSize": 60, "blinds": "1/2", "potSize": 35, "actionSoFar": "You called flop with flush draw", "communityCards": "K♠ 8♠ 3♥ 2♠", "playersRemaining": 2, "effectiveStacks": 60}'::jsonb,
  'Villain bets 20. What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 20"}, {"id": "C", "action": "Raise to 60"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'D',
  'You made the nut flush! This is a very strong hand and you should raise for value. With the flush-completing card on board, go all-in to get maximum value from worse hands that might call.',
  ARRAY['made flush', 'value betting', 'river']
),

-- River questions
(
  'river',
  'beginner',
  '{"yourHand": "KK", "position": "Button", "stackSize": 90, "blinds": "1/2", "potSize": 45, "actionSoFar": "You bet flop and turn, got called", "communityCards": "K 8 4 3 2 rainbow", "playersRemaining": 2, "effectiveStacks": 80}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 20"}, {"id": "C", "action": "Bet 45"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'B',
  'You have top set on a dry board - a very strong hand. Bet for value but keep the bet size reasonable (about half pot) to get called by worse hands. Villain called twice so they likely have something.',
  ARRAY['value betting', 'set', 'river']
),

-- Special situations
(
  'special',
  'beginner',
  '{"yourHand": "AQ", "position": "Small Blind", "stackSize": 12, "blinds": "1/2", "potSize": 3, "actionSoFar": "Folds to you", "playersRemaining": 2, "effectiveStacks": 12}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 1"}, {"id": "C", "action": "Raise to 6"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'D',
  'With only 12BB (6BB effective), you should go all-in with AQ. This is a push/fold situation. AQ is strong enough to shove, and you want to put maximum pressure on the big blind.',
  ARRAY['short stack', 'push/fold', 'ICM']
),
(
  'special',
  'intermediate',
  '{"yourHand": "KQ", "position": "Cutoff", "stackSize": 100, "blinds": "1/2", "potSize": 18, "actionSoFar": "UTG raises to 6, MP calls", "playersRemaining": 5, "effectiveStacks": 94}'::jsonb,
  'What is the best action in this 3-way pot?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 6"}, {"id": "C", "action": "Raise to 24"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'A',
  'In a multi-way pot with action in front of you, KQ is not strong enough to continue. Multi-way pots favor strong hands. Fold and wait for a better spot.',
  ARRAY['multi-way pot', 'hand selection', 'discipline']
),
(
  'pre-flop',
  'beginner',
  '{"yourHand": "JJ", "position": "Middle", "stackSize": 100, "blinds": "1/2", "potSize": 3, "actionSoFar": "Action is on you", "playersRemaining": 8, "effectiveStacks": 100}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 2"}, {"id": "C", "action": "Raise to 6"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'C',
  'JJ is a premium pocket pair and should be raised for value. A standard 3BB raise builds the pot and narrows the field to hands you dominate or can outplay post-flop.',
  ARRAY['premium pairs', 'value raising', 'isolation']
)
ON CONFLICT DO NOTHING;