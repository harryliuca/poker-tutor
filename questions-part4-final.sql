-- Final Part of 150 Questions - Part 4
-- RIVER and SPECIAL SITUATIONS (completing the 150 questions)

INSERT INTO public.questions (category, difficulty, scenario, question_text, choices, correct_answer, explanation, key_concepts)
VALUES

-- ============================================================================
-- RIVER QUESTIONS (30 total: 10 beginner, 10 intermediate, 10 advanced)
-- ============================================================================

-- RIVER BEGINNER (10 questions)
(
  'river',
  'beginner',
  '{"yourHand": "KK", "position": "Button", "stackSize": 62, "blinds": "1/2", "potSize": 38, "actionSoFar": "You bet flop and turn, BB called both times", "communityCards": "K 8 4 3 2 rainbow", "playersRemaining": 2, "effectiveStacks": 62}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 20"}, {"id": "C", "action": "Bet 38"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'B',
  'You have top set on a very dry board. Bet about half pot (20 chips) for value. The BB called twice so they have something. Extract value with a reasonable bet size that can get called by worse hands.',
  ARRAY['river value betting', 'set', 'bet sizing']
),

(
  'river',
  'beginner',
  '{"yourHand": "AQ", "position": "Cutoff", "stackSize": 62, "blinds": "1/2", "potSize": 38, "actionSoFar": "You bet flop and turn, Button called both", "communityCards": "A J 6 3 9 rainbow", "playersRemaining": 2, "effectiveStacks": 62}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 20"}, {"id": "C", "action": "Bet 38"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'B',
  'You have top pair good kicker on a safe river. Bet about half pot (20 chips) for value. The button has called twice, indicating a hand that might pay off one more street. Go for three streets of value.',
  ARRAY['triple barrel value', 'top pair', 'river betting']
),

(
  'river',
  'beginner',
  '{"yourHand": "99", "position": "Big Blind", "stackSize": 62, "blinds": "1/2", "potSize": 38, "actionSoFar": "Button bet flop and turn, you called both", "communityCards": "K Q 7 4 2 rainbow", "playersRemaining": 2, "effectiveStacks": 62}'::jsonb,
  'Button bets 30. What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 30"}, {"id": "C", "action": "Raise to 62 (all-in)"}, {"id": "D", "action": "Raise to 90"}]'::jsonb,
  'A',
  'You have a weak pair facing three barrels on a board with two overcards. The button has shown consistent aggression representing a strong hand. Fold and preserve your chips. You''re beat too often to call.',
  ARRAY['folding weak hands', 'triple barrel', 'river decisions']
),

(
  'river',
  'beginner',
  '{"yourHand": "AJ", "position": "Button", "stackSize": 62, "blinds": "1/2", "potSize": 38, "actionSoFar": "You bet flop and turn, BB called both", "communityCards": "A 8 4 3 J rainbow", "playersRemaining": 2, "effectiveStacks": 62}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 20"}, {"id": "C", "action": "Bet 38"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'B',
  'You have two pair after improving on the river. Bet about half pot (20 chips) for value. The BB has called twice and you improved. This is a strong hand that should bet for value.',
  ARRAY['river improvement', 'two pair', 'value betting']
),

(
  'river',
  'beginner',
  '{"yourHand": "A♠ 8♠", "position": "Cutoff", "stackSize": 62, "blinds": "1/2", "potSize": 38, "actionSoFar": "You bet flop and turn with flush draw, BB called both", "communityCards": "K♠ 9♠ 3♥ 2♦ 4♠", "playersRemaining": 2, "effectiveStacks": 62}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 20"}, {"id": "C", "action": "Bet 38"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'B',
  'You made the nut flush on the river! Bet about half pot (20 chips) for value. The flush completed on board so don''t over-bet. Extract value from hands that can call - pairs, worse flushes, straights.',
  ARRAY['river made flush', 'value betting', 'obvious draws completing']
),

(
  'river',
  'beginner',
  '{"yourHand": "QQ", "position": "Middle", "stackSize": 62, "blinds": "1/2", "potSize": 38, "actionSoFar": "You bet flop and turn, CO called both", "communityCards": "9 6 3 rainbow → 6 → 2", "playersRemaining": 2, "effectiveStacks": 62}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 20"}, {"id": "C", "action": "Bet 38"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'B',
  'You have an overpair on a dry river. Bet about half pot (20 chips) for thin value. The CO called twice and the river is a brick. You likely have the best hand - extract value with a reasonable bet.',
  ARRAY['thin value betting', 'overpair', 'dry boards']
),

(
  'river',
  'beginner',
  '{"yourHand": "JT", "position": "Button", "stackSize": 62, "blinds": "1/2", "potSize": 38, "actionSoFar": "You bet flop and turn with straight draw, BB called both", "communityCards": "9 8 3 rainbow → Q → 2", "playersRemaining": 2, "effectiveStacks": 62}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 20"}, {"id": "C", "action": "Bet 38"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'B',
  'You made the nut straight on the turn and now the river is a brick. Bet about half pot (20 chips) for value. The BB has called twice - extract maximum value from your strong hand.',
  ARRAY['value betting made hands', 'nut straight', 'river']
),

(
  'river',
  'beginner',
  '{"yourHand": "K9", "position": "Big Blind", "stackSize": 62, "blinds": "1/2", "potSize": 38, "actionSoFar": "Button bet flop and turn, you called with top pair weak kicker", "communityCards": "K 7 3 rainbow → 8 → Q", "playersRemaining": 2, "effectiveStacks": 62}'::jsonb,
  'Button bets 25. What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 25"}, {"id": "C", "action": "Raise to 62 (all-in)"}, {"id": "D", "action": "Raise to 75"}]'::jsonb,
  'B',
  'You have top pair weak kicker facing a third barrel. The Q on the river is concerning but you''ve called twice showing strength. The pot is laying you good odds (25 to win 63). Call and hope your pair is good.',
  ARRAY['bluff catching', 'pot odds', 'river decisions']
),

(
  'river',
  'beginner',
  '{"yourHand": "A8", "position": "Cutoff", "stackSize": 62, "blinds": "1/2", "potSize": 38, "actionSoFar": "You c-bet flop, checked turn, Button checked back both streets", "communityCards": "A 6 3 rainbow → 9 → 2", "playersRemaining": 2, "effectiveStacks": 62}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 20"}, {"id": "C", "action": "Bet 38"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'B',
  'You have top pair weak kicker. Both players checked the turn showing weakness. Bet about half pot (20 chips) for value on the river. The button likely has a weak hand - extract value.',
  ARRAY['river value betting', 'delayed value', 'top pair']
),

(
  'river',
  'beginner',
  '{"yourHand": "TT", "position": "Button", "stackSize": 62, "blinds": "1/2", "potSize": 38, "actionSoFar": "You bet flop, checked turn, BB checked both", "communityCards": "J 7 4 rainbow → K → 9", "playersRemaining": 2, "effectiveStacks": 62}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 20"}, {"id": "C", "action": "Bet 38"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'A',
  'You have a weak pair with two overcards on board. Both players showed weakness by checking the turn. Check and go to showdown. Your hand has showdown value but betting risks getting raised or called by better.',
  ARRAY['showdown value', 'pot control', 'way ahead/way behind']
),

-- RIVER INTERMEDIATE (10 questions)
(
  'river',
  'intermediate',
  '{"yourHand": "AK", "position": "Cutoff", "stackSize": 46, "blinds": "1/2", "potSize": 54, "actionSoFar": "You bet flop and turn, BB called both", "communityCards": "K 9 3 rainbow → 7 → 2", "playersRemaining": 2, "effectiveStacks": 46}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 27"}, {"id": "C", "action": "Bet 40"}, {"id": "D", "action": "All-in 46"}]'::jsonb,
  'B',
  'You have top pair top kicker and bet flop and turn. Bet river for value at about half pot (27 chips). You want to extract value from worse hands while maintaining a reasonable bet size for your stack depth.',
  ARRAY['triple barrel value', 'top pair', 'stack depth']
),

(
  'river',
  'intermediate',
  '{"yourHand": "JJ", "position": "Button", "stackSize": 27, "blinds": "1/2", "potSize": 73, "actionSoFar": "You called check-raise on flop, called turn bet", "communityCards": "Q T 5 two-tone → 2 → 8 rainbow", "playersRemaining": 2, "effectiveStacks": 27}'::jsonb,
  'BB bets 27 (all-in). What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 27"}, {"id": "C", "action": "Raise to 54"}, {"id": "D", "action": "Raise to 100"}]'::jsonb,
  'B',
  'You''re getting 100:27 (almost 4:1) pot odds. You need to be good 25% of the time. The BB could be bluffing or value-betting. With an overpair and these pot odds, call and hope you''re ahead. This is a bluff catch.',
  ARRAY['bluff catching', 'pot odds', 'river calls']
),

(
  'river',
  'intermediate',
  '{"yourHand": "A♠ Q♠", "position": "Button", "stackSize": 62, "blinds": "1/2", "potSize": 38, "actionSoFar": "You bet flop and turn with nut flush draw, BB called both", "communityCards": "K♠ 9♠ 3♥ 2♦ 6♣", "playersRemaining": 2, "effectiveStacks": 62}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 20"}, {"id": "C", "action": "Bet 38"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'B',
  'You missed your flush draw but bet flop and turn. Bluff the river with about half pot (20 chips) to represent your range. The BB might have a weak hand or missed draw themselves. Complete your story with a river bet.',
  ARRAY['river bluff', 'triple barrel bluff', 'range representation']
),

(
  'river',
  'intermediate',
  '{"yourHand": "99", "position": "Cutoff", "stackSize": 62, "blinds": "1/2", "potSize": 38, "actionSoFar": "You bet flop, checked turn, Button checked back", "communityCards": "9 6 2 rainbow → K → 7", "playersRemaining": 2, "effectiveStacks": 62}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 20"}, {"id": "C", "action": "Bet 38"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'B',
  'You have a set and both players checked the turn. Bet about half pot (20 chips) for value on the river. The K doesn''t change much. Extract value from hands that can call - pairs, worse hands that were checking the turn.',
  ARRAY['delayed value betting', 'set', 'river']
),

(
  'river',
  'intermediate',
  '{"yourHand": "AJ", "position": "Big Blind", "stackSize": 62, "blinds": "1/2", "potSize": 38, "actionSoFar": "Button bet flop and turn, you called both with top pair", "communityCards": "A 8 4 rainbow → 9 → K", "playersRemaining": 2, "effectiveStacks": 62}'::jsonb,
  'Button checks. What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 20"}, {"id": "C", "action": "Bet 38"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'A',
  'The button checked after betting flop and turn. The K on the river is concerning. Check and go to showdown. The button might have a K now, or is giving you a free showdown. Don''t bet into strength.',
  ARRAY['river pot control', 'showdown value', 'reading checks']
),

(
  'river',
  'intermediate',
  '{"yourHand": "K8", "position": "Button", "stackSize": 62, "blinds": "1/2", "potSize": 38, "actionSoFar": "You bet flop and turn with top pair weak kicker, BB called both", "communityCards": "K 7 3 rainbow → 6 → 2", "playersRemaining": 2, "effectiveStacks": 62}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 20"}, {"id": "C", "action": "Bet 38"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'A',
  'You have top pair weak kicker and bet twice. The river is a complete brick. Check and go to showdown. Betting risks getting called by better or check-raised as a bluff. Your hand has showdown value - realize it.',
  ARRAY['checking back river', 'showdown value', 'pot control']
),

(
  'river',
  'intermediate',
  '{"yourHand": "QQ", "position": "Middle", "stackSize": 62, "blinds": "1/2", "potSize": 38, "actionSoFar": "You bet flop, Button raised, you called, checked turn, Button checked back", "communityCards": "J 9 5 two-tone → 2 → 7 rainbow", "playersRemaining": 2, "effectiveStacks": 62}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 20"}, {"id": "C", "action": "Bet 38"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'B',
  'You have an overpair. The button raised the flop but checked the turn, capping their range. Bet about half pot (20 chips) for value. Many hands that raised the flop will call the river - draws that missed, weaker pairs.',
  ARRAY['exploiting capped ranges', 'value betting', 'river']
),

(
  'river',
  'intermediate',
  '{"yourHand": "A9", "position": "Cutoff", "stackSize": 62, "blinds": "1/2", "potSize": 38, "actionSoFar": "You c-bet flop, checked turn, Button bet turn, you called", "communityCards": "A 6 3 two-tone → 9 → 5", "playersRemaining": 2, "effectiveStacks": 62}'::jsonb,
  'Button bets 25. What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 25"}, {"id": "C", "action": "Raise to 62 (all-in)"}, {"id": "D", "action": "Raise to 75"}]'::jsonb,
  'C',
  'You have two pair after hitting the turn. The button bet the turn and now bets the river. Raise all-in (62) for value. Your hand improved to a very strong two pair. Get maximum value from worse aces or bluffs.',
  ARRAY['river value raise', 'two pair', 'aggression']
),

(
  'river',
  'intermediate',
  '{"yourHand": "TT", "position": "Big Blind", "stackSize": 40, "blinds": "1/2", "potSize": 60, "actionSoFar": "Button bet flop and turn, you called both", "communityCards": "K Q 7 rainbow → 8 → 2", "playersRemaining": 2, "effectiveStacks": 40}'::jsonb,
  'Button checks. What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 30"}, {"id": "C", "action": "Bet 40 (all-in)"}, {"id": "D", "action": "Bet 60"}]'::jsonb,
  'A',
  'You have a weak pair and the button checked the river after betting flop and turn. They''re giving up on their hand. Check and go to showdown. Your pair might be good, but betting turns your hand into a bluff.',
  ARRAY['checking back showdown value', 'river', 'pot control']
),

(
  'river',
  'intermediate',
  '{"yourHand": "K7", "position": "Button", "stackSize": 62, "blinds": "1/2", "potSize": 38, "actionSoFar": "You c-bet flop with top pair, checked turn, BB checked both", "communityCards": "K 9 3 rainbow → 6 → 2", "playersRemaining": 2, "effectiveStacks": 62}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 20"}, {"id": "C", "action": "Bet 38"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'B',
  'You have top pair weak kicker. Both players checked the turn showing weakness. Bet about half pot (20 chips) for thin value. The BB likely has a weak hand - extract value when both players show weakness.',
  ARRAY['thin value betting', 'delayed value', 'river']
),

-- RIVER ADVANCED (10 questions)
(
  'river',
  'advanced',
  '{"yourHand": "88", "position": "Cutoff", "stackSize": 62, "blinds": "1/2", "potSize": 38, "actionSoFar": "You 3-bet pre-flop, bet flop and turn, BB called both", "communityCards": "K 9 3 rainbow → 7 → 2", "playersRemaining": 2, "effectiveStacks": 62}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 20"}, {"id": "C", "action": "Bet 38"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'A',
  'You have a weak pair in a 3-bet pot after triple barreling as a bluff. Give up on the river. The BB called twice showing strength. Checking realizes your showdown value. Betting is turning a showdown hand into a bluff.',
  ARRAY['giving up bluffs', 'showdown value', 'river']
),

(
  'river',
  'advanced',
  '{"yourHand": "AQ", "position": "Button", "stackSize": 46, "blinds": "1/2", "potSize": 54, "actionSoFar": "You 3-bet pre-flop, bet flop and turn, BB called both", "communityCards": "A 8 4 rainbow → 9 → 3", "playersRemaining": 2, "effectiveStacks": 46}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 27"}, {"id": "C", "action": "Bet 46 (all-in)"}, {"id": "D", "action": "Bet 54"}]'::jsonb,
  'B',
  'You have top pair good kicker in a 3-bet pot. Bet about half pot (27 chips) for value. The BB called twice in a 3-bet pot - they have a hand. Extract value with your strong top pair while keeping bet sizing reasonable.',
  ARRAY['3-bet pot value', 'river sizing', 'top pair']
),

(
  'river',
  'advanced',
  '{"yourHand": "JJ", "position": "Middle", "stackSize": 27, "blinds": "1/2", "potSize": 73, "actionSoFar": "You called 3-bet pre-flop, called flop and turn bets", "communityCards": "Q T 5 two-tone → 9 → 8", "playersRemaining": 2, "effectiveStacks": 27}'::jsonb,
  'Opponent bets 20. What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 20"}, {"id": "C", "action": "Raise to 27 (all-in)"}, {"id": "D", "action": "Raise to 60"}]'::jsonb,
  'B',
  'The board now has a straight possible (J makes nuts). You''re getting 93:20 (4.65:1) pot odds. You need to be good 18% of the time. With an overpair and massive pot odds, call. The opponent could be bluffing or value-betting worse.',
  ARRAY['pot odds', 'bluff catching', 'scary rivers']
),

(
  'river',
  'advanced',
  '{"yourHand": "A5s", "position": "Button", "stackSize": 46, "blinds": "1/2", "potSize": 54, "actionSoFar": "You 3-bet as bluff pre-flop, bet flop and turn as bluff, BB called both", "communityCards": "K 8 2 rainbow → 3 → 7", "playersRemaining": 2, "effectiveStacks": 46}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 27"}, {"id": "C", "action": "Bet 46 (all-in)"}, {"id": "D", "action": "Bet 54"}]'::jsonb,
  'A',
  'You have nothing after triple barreling as a bluff. Give up on the river. The BB called flop and turn in a 3-bet pot - they have a strong hand. Check and lose the minimum. Not every bluff needs to fire all three streets.',
  ARRAY['giving up bluffs', 'triple barrel', 'river']
),

(
  'river',
  'advanced',
  '{"yourHand": "99", "position": "Cutoff", "stackSize": 30, "blinds": "1/2", "potSize": 70, "actionSoFar": "You 4-bet pre-flop, bet flop and turn, Button called both", "communityCards": "7 4 2 rainbow → 3 → 6", "playersRemaining": 2, "effectiveStacks": 30}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 30 (all-in)"}, {"id": "C", "action": "Bet 50"}, {"id": "D", "action": "Bet 70"}]'::jsonb,
  'B',
  'You have an overpair in a 4-bet pot with less than half pot-sized bet remaining. Shove all-in (30) for value. The button called your flop and turn bets - extract maximum value. Stack-to-pot ratio dictates commitment.',
  ARRAY['stack commitment', '4-bet pots', 'value shoving']
),

(
  'river',
  'advanced',
  '{"yourHand": "AK", "position": "Button", "stackSize": 46, "blinds": "1/2", "potSize": 54, "actionSoFar": "You 3-bet pre-flop, c-bet flop as bluff, checked turn, BB checked back", "communityCards": "Q 8 3 rainbow → 7 → 2", "playersRemaining": 2, "effectiveStacks": 46}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 27"}, {"id": "C", "action": "Bet 46 (all-in)"}, {"id": "D", "action": "Bet 54"}]'::jsonb,
  'A',
  'You have ace-high after both players checked the turn. Check and go to showdown. Your hand has showdown value against bluffs. The BB might check-raise as a bluff if you bet. Realize your equity by checking.',
  ARRAY['showdown value', 'checking back', 'river']
),

(
  'river',
  'advanced',
  '{"yourHand": "K9", "position": "Big Blind", "stackSize": 62, "blinds": "1/2", "potSize": 38, "actionSoFar": "Button bet flop, checked turn, you checked both streets", "communityCards": "K 7 3 rainbow → 8 → 2", "playersRemaining": 2, "effectiveStacks": 62}'::jsonb,
  'Button bets 30. What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 30"}, {"id": "C", "action": "Raise to 62 (all-in)"}, {"id": "D", "action": "Raise to 90"}]'::jsonb,
  'B',
  'You have top pair weak kicker. The button checked the turn then bet the river - this is a polarized line (nuts or bluff). You''re getting 68:30 (2.3:1) pot odds. Call and hope your pair is good or they''re bluffing.',
  ARRAY['bluff catching', 'polarized lines', 'river calls']
),

(
  'river',
  'advanced',
  '{"yourHand": "TT", "position": "Cutoff", "stackSize": 40, "blinds": "1/2", "potSize": 60, "actionSoFar": "You 3-bet pre-flop, Button called, you c-bet flop, Button called, you checked turn, Button bet 25, you called", "communityCards": "K K 5 rainbow → T → 9", "playersRemaining": 2, "effectiveStacks": 15}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 15 (all-in)"}, {"id": "C", "action": "Bet 30"}, {"id": "D", "action": "Bet 60"}]'::jsonb,
  'B',
  'You have a full house (tens full of kings)! Shove all-in (15) for value. The opponent might have a king or bluff. Your hand is very strong on this paired board. Get your remaining stack in.',
  ARRAY['full house', 'value shoving', 'river']
),

(
  'river',
  'advanced',
  '{"yourHand": "A8", "position": "Button", "stackSize": 62, "blinds": "1/2", "potSize": 38, "actionSoFar": "You c-bet flop, BB raised, you called, both checked turn", "communityCards": "A 6 3 two-tone → 9 → K", "playersRemaining": 2, "effectiveStacks": 62}'::jsonb,
  'BB bets 30. What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 30"}, {"id": "C", "action": "Raise to 62 (all-in)"}, {"id": "D", "action": "Raise to 90"}]'::jsonb,
  'A',
  'You have top pair weak kicker. The BB check-raised the flop, both checked the turn, and now they bet the river after a K came. They likely have a K or better ace. Fold and preserve your chips.',
  ARRAY['folding weak hands', 'range reading', 'river']
),

(
  'river',
  'advanced',
  '{"yourHand": "QQ", "position": "Middle", "stackSize": 35, "blinds": "1/2", "potSize": 65, "actionSoFar": "You called 3-bet pre-flop, bet flop, Button called, bet turn, Button called", "communityCards": "9 6 3 rainbow → 7 → 2", "playersRemaining": 2, "effectiveStacks": 35}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 25"}, {"id": "C", "action": "Bet 35 (all-in)"}, {"id": "D", "action": "Bet 65"}]'::jsonb,
  'C',
  'You have an overpair after betting flop and turn. Shove all-in (35) for value on this brick river. The button called twice - extract maximum value. With less than 1 PSR remaining, commit your stack.',
  ARRAY['value shoving', 'stack-to-pot ratio', 'overpair']
),

-- ============================================================================
-- SPECIAL SITUATIONS (10 total - all difficulty levels mixed)
-- ============================================================================

(
  'special',
  'beginner',
  '{"yourHand": "AQ", "position": "Small Blind", "stackSize": 12, "blinds": "1/2", "potSize": 3, "actionSoFar": "Folds to you", "playersRemaining": 2, "effectiveStacks": 12}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 1"}, {"id": "C", "action": "Raise to 6"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'D',
  'With only 12BB (6BB effective heads-up), you should go all-in with AQ. This is push/fold territory. AQ is strong enough to shove and you want to put maximum pressure on the big blind. Don''t limp or min-raise with short stacks.',
  ARRAY['short stack', 'push/fold', 'heads-up']
),

(
  'special',
  'intermediate',
  '{"yourHand": "KQ", "position": "Cutoff", "stackSize": 100, "blinds": "1/2", "potSize": 18, "actionSoFar": "UTG raises to 6, MP calls", "playersRemaining": 5, "effectiveStacks": 94}'::jsonb,
  'What is the best action in this 3-way pot?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 6"}, {"id": "C", "action": "Raise to 24"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'A',
  'In a multi-way pot with action in front of you, KQ offsuit is not strong enough to continue. Multi-way pots favor strong made hands and strong draws. Fold and wait for a better spot with a stronger hand.',
  ARRAY['multi-way pots', 'hand selection', 'discipline']
),

(
  'special',
  'advanced',
  '{"yourHand": "88", "position": "Small Blind", "stackSize": 15, "blinds": "1/2", "potSize": 8, "actionSoFar": "CO raises to 6, folds to you. You are on the bubble of a tournament", "playersRemaining": 2, "effectiveStacks": 9}'::jsonb,
  'What is the best action in this bubble situation?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 5"}, {"id": "C", "action": "Raise to 12"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'D',
  'Even on the bubble with 15BB, pocket 88 is strong enough to shove. The CO is stealing wide from late position. Shoving has fold equity and 88 has good equity when called. Don''t be too tight even on the bubble.',
  ARRAY['bubble play', 'ICM', 'push/fold']
),

(
  'special',
  'beginner',
  '{"yourHand": "AK", "position": "Button", "stackSize": 25, "blinds": "1/2", "potSize": 3, "actionSoFar": "Folds to you", "playersRemaining": 3, "effectiveStacks": 25}'::jsonb,
  'What is the best action with 25BB?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 2"}, {"id": "C", "action": "Raise to 6"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'C',
  'With 25BB, you still have room to raise and fold. Raise to 3BB (6 chips) with AK. This is standard opening size and allows you to fold if someone 3-bets. Don''t shove - you''re not quite in push/fold territory yet.',
  ARRAY['stack depth', 'opening ranges', 'short stack']
),

(
  'special',
  'intermediate',
  '{"yourHand": "J9s", "position": "Big Blind", "stackSize": 100, "blinds": "1/2", "potSize": 20, "actionSoFar": "Button raises to 6, SB calls, creating 3-way pot", "playersRemaining": 3, "effectiveStacks": 94}'::jsonb,
  'What is the best action in this 3-way pot?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 4"}, {"id": "C", "action": "Raise to 20"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'B',
  'J9 suited getting great pot odds (4 to win 16) from the big blind is a call. You''re closing the action and have a playable hand. The hand has straight and flush potential. Multi-way pots favor speculative hands with good odds.',
  ARRAY['multi-way pots', 'pot odds', 'speculative hands']
),

(
  'special',
  'advanced',
  '{"yourHand": "ATs", "position": "Cutoff", "stackSize": 18, "blinds": "1/2", "potSize": 11, "actionSoFar": "MP raises to 6, HJ calls", "playersRemaining": 5, "effectiveStacks": 12}'::jsonb,
  'What is the best action with 18BB?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 6"}, {"id": "C", "action": "Raise to 18 (all-in)"}, {"id": "D", "action": "Raise to 15"}]'::jsonb,
  'C',
  'AT suited with 18BB facing a raise and call should shove all-in. You have a strong hand but can''t afford to call and play post-flop with a short stack. Shoving has fold equity and realizes your equity now.',
  ARRAY['short stack', 'squeeze shove', 'push/fold']
),

(
  'special',
  'intermediate',
  '{"yourHand": "77", "position": "Button", "stackSize": 100, "blinds": "1/2", "potSize": 20, "actionSoFar": "UTG raises to 6, MP calls, CO calls, creating 4-way pot", "playersRemaining": 6, "effectiveStacks": 94}'::jsonb,
  'What is the best action in this 4-way pot?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 6"}, {"id": "C", "action": "Raise to 28"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'B',
  'Small pocket pairs play well in multi-way pots with deep stacks. Call to try to flop a set. If you hit (happens 1 in 8 times), you can win a huge pot. If you miss, fold easily to aggression. Position is perfect.',
  ARRAY['multi-way pots', 'set mining', 'implied odds']
),

(
  'special',
  'beginner',
  '{"yourHand": "KK", "position": "Middle", "stackSize": 20, "blinds": "1/2", "potSize": 3, "actionSoFar": "UTG raises to 6", "playersRemaining": 7, "effectiveStacks": 14}'::jsonb,
  'What is the best action with 20BB?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 6"}, {"id": "C", "action": "Raise to 12"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'D',
  'With pocket kings and only 20BB, go all-in. You can''t afford to raise and then fold. You have a premium hand - realize your equity by shoving. This is a clear shove in push/fold territory.',
  ARRAY['short stack', 'premium pairs', 'push/fold']
),

(
  'special',
  'advanced',
  '{"yourHand": "QJs", "position": "Small Blind", "stackSize": 100, "blinds": "1/2", "potSize": 18, "actionSoFar": "MP raises to 6, CO calls, Button calls, creating 4-way pot", "playersRemaining": 5, "effectiveStacks": 94}'::jsonb,
  'What is the best action in this multi-way pot?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 5"}, {"id": "C", "action": "Raise to 28"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'C',
  'QJ suited is a premium squeezing hand in this multi-way pot. Raise to 28 chips to apply maximum pressure. You can represent a premium hand and have good playability when called. This balances your squeeze range.',
  ARRAY['squeeze play', 'multi-way pots', 'polarized raising']
),

(
  'special',
  'intermediate',
  '{"yourHand": "A9o", "position": "Button", "stackSize": 14, "blinds": "1/2", "potSize": 3, "actionSoFar": "Folds to you", "playersRemaining": 3, "effectiveStacks": 14}'::jsonb,
  'What is the best action with 14BB?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 2"}, {"id": "C", "action": "Raise to 6"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'D',
  'With 14BB from the button, A9 offsuit is strong enough to shove. This is push/fold territory. Shoving puts maximum pressure on the blinds and realizes your equity. Don''t min-raise or limp with short stacks.',
  ARRAY['short stack', 'push/fold', 'button stealing']
);
