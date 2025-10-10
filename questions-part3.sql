-- Continuation of 150 Questions - Part 3
-- TURN, RIVER, and SPECIAL SITUATIONS

INSERT INTO public.questions (category, difficulty, scenario, question_text, choices, correct_answer, explanation, key_concepts)
VALUES

-- ============================================================================
-- TURN QUESTIONS (30 total: 10 beginner, 10 intermediate, 10 advanced)
-- ============================================================================

-- TURN BEGINNER (10 questions)
(
  'turn',
  'beginner',
  '{"yourHand": "A♠ Q♠", "position": "Button", "stackSize": 77, "blinds": "1/2", "potSize": 23, "actionSoFar": "You called flop with flush draw", "communityCards": "K♠ 8♠ 3♥ 2♠", "playersRemaining": 2, "effectiveStacks": 77}'::jsonb,
  'BB bets 15. What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 15"}, {"id": "C", "action": "Raise to 45"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'D',
  'You made the nut flush! The turn completed your draw. Go all-in to get maximum value. The flush-completing card on board means your opponent might have a worse flush, a set, or top pair. Build the pot aggressively.',
  ARRAY['made flush', 'value betting', 'nuts']
),

(
  'turn',
  'beginner',
  '{"yourHand": "KK", "position": "Cutoff", "stackSize": 75, "blinds": "1/2", "potSize": 25, "actionSoFar": "You bet flop 10, BB called", "communityCards": "9 6 3 rainbow → A", "playersRemaining": 2, "effectiveStacks": 75}'::jsonb,
  'BB checks. What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 12"}, {"id": "C", "action": "Bet 25"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'A',
  'The ace on the turn is a scare card. You had an overpair but now face an overcard. Check behind to control the pot size. The BB could have an ace and might check-raise. See the river cheaply and reassess.',
  ARRAY['pot control', 'scare cards', 'showdown value']
),

(
  'turn',
  'beginner',
  '{"yourHand": "JT", "position": "Button", "stackSize": 77, "blinds": "1/2", "potSize": 23, "actionSoFar": "You bet flop with straight draw, BB called", "communityCards": "9 8 3 rainbow → Q", "playersRemaining": 2, "effectiveStacks": 77}'::jsonb,
  'BB checks. What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 15"}, {"id": "C", "action": "Bet 25"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'B',
  'You made the nut straight! Bet about 2/3 pot (15 chips) for value. The Q completing your straight isn''t obvious to your opponent. Build the pot with your strong hand. Don''t slow-play.',
  ARRAY['made straight', 'value betting', 'disguised hand']
),

(
  'turn',
  'beginner',
  '{"yourHand": "AK", "position": "Button", "stackSize": 77, "blinds": "1/2", "potSize": 23, "actionSoFar": "You c-bet flop 10, BB called", "communityCards": "K 7 2 rainbow → 5", "playersRemaining": 2, "effectiveStacks": 77}'::jsonb,
  'BB checks. What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 12"}, {"id": "C", "action": "Bet 23"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'B',
  'You have top pair top kicker. Continue betting for value on this safe turn card. About half pot (12 chips) is appropriate to build the pot and get value from weaker hands while maintaining control.',
  ARRAY['double barreling', 'top pair', 'value betting']
),

(
  'turn',
  'beginner',
  '{"yourHand": "QQ", "position": "Middle", "stackSize": 75, "blinds": "1/2", "potSize": 25, "actionSoFar": "You bet flop 10, CO called", "communityCards": "9 6 3 two-tone → 6", "playersRemaining": 2, "effectiveStacks": 75}'::jsonb,
  'You bet 15, CO raises to 45. What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 30"}, {"id": "C", "action": "Raise to 75 (all-in)"}, {"id": "D", "action": "Raise to 100"}]'::jsonb,
  'A',
  'The turn paired the 6 and you face a big raise. The CO likely has trips (a six) or a strong hand. Your overpair is vulnerable. Fold and preserve your chips. Don''t get married to pocket queens when facing aggression on paired boards.',
  ARRAY['folding overpairs', 'paired boards', 'aggression']
),

(
  'turn',
  'beginner',
  '{"yourHand": "99", "position": "Button", "stackSize": 77, "blinds": "1/2", "potSize": 23, "actionSoFar": "You c-bet flop 10, BB called", "communityCards": "9 6 2 rainbow → 9", "playersRemaining": 2, "effectiveStacks": 77}'::jsonb,
  'BB checks. What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 12"}, {"id": "C", "action": "Bet 23"}, {"id": "D", "action": "Bet 50"}]'::jsonb,
  'B',
  'You have quad 9s! Bet about half pot (12 chips) to extract value. Don''t over-bet or you''ll scare away hands that can pay you off. Make it look like a standard value bet. Build the pot gradually.',
  ARRAY['quads', 'value betting', 'deception']
),

(
  'turn',
  'beginner',
  '{"yourHand": "AJ", "position": "Big Blind", "stackSize": 77, "blinds": "1/2", "potSize": 23, "actionSoFar": "Button bet flop 10, you called", "communityCards": "A 8 3 rainbow → J", "playersRemaining": 2, "effectiveStacks": 77}'::jsonb,
  'Button bets 15. What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 15"}, {"id": "C", "action": "Raise to 45"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'C',
  'You have two pair on the turn. This is a strong hand. Raise to 45 to build the pot and get value. The button could have an ace or worse hand. Don''t slow-play - build the pot with your strong hand.',
  ARRAY['two pair', 'value raising', 'turn aggression']
),

(
  'turn',
  'beginner',
  '{"yourHand": "A♥ 5♥", "position": "Button", "stackSize": 77, "blinds": "1/2", "potSize": 23, "actionSoFar": "You c-bet flop 10, BB called", "communityCards": "K♥ 9♥ 3♠ → 2♦", "playersRemaining": 2, "effectiveStacks": 77}'::jsonb,
  'BB checks. What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 12"}, {"id": "C", "action": "Bet 23"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'B',
  'You still have the nut flush draw (9 outs). Continue semi-bluffing with another bet of about half pot (12 chips). You can win now or make the nuts on the river. Maintain pressure with your strong draw.',
  ARRAY['semi-bluffing', 'flush draw', 'double barrel']
),

(
  'turn',
  'beginner',
  '{"yourHand": "TT", "position": "Cutoff", "stackSize": 75, "blinds": "1/2", "potSize": 25, "actionSoFar": "You bet flop 10, Button called", "communityCards": "J 7 4 rainbow → T", "playersRemaining": 2, "effectiveStacks": 75}'::jsonb,
  'You bet 15, Button calls. What is your river plan?',
  '[{"id": "A", "action": "Check any river"}, {"id": "B", "action": "Bet most rivers"}, {"id": "C", "action": "Only bet if you improve"}, {"id": "D", "action": "Check-fold any bet"}]'::jsonb,
  'B',
  'You have a set - a very strong hand. Continue betting most rivers for value. The button has called twice so likely has a hand that can pay you off. Build the pot and extract maximum value.',
  ARRAY['three streets of value', 'set', 'value betting']
),

(
  'turn',
  'beginner',
  '{"yourHand": "K9", "position": "Button", "stackSize": 77, "blinds": "1/2", "potSize": 23, "actionSoFar": "You c-bet flop 10, BB called", "communityCards": "K 6 2 rainbow → Q", "playersRemaining": 2, "effectiveStacks": 77}'::jsonb,
  'BB checks. What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 12"}, {"id": "C", "action": "Bet 23"}, {"id": "D", "action": "Bet 50"}]'::jsonb,
  'B',
  'You have top pair weak kicker. The Q is a potential scare card but you should still bet for value on most turns. Bet about half pot (12 chips). Your hand is still likely best and you want to build the pot.',
  ARRAY['thin value betting', 'top pair weak kicker', 'double barrel']
),

-- TURN INTERMEDIATE (10 questions)
(
  'turn',
  'intermediate',
  '{"yourHand": "AK", "position": "Cutoff", "stackSize": 64, "blinds": "1/2", "potSize": 36, "actionSoFar": "You c-bet flop 15, BB called", "communityCards": "K 9 3 rainbow → 7", "playersRemaining": 2, "effectiveStacks": 64}'::jsonb,
  'BB checks. What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 18"}, {"id": "C", "action": "Bet 36"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'B',
  'You have top pair top kicker. Continue betting for value on this safe turn card. About half pot (18 chips) maintains pressure and builds the pot. You want to bet three streets for value with this hand.',
  ARRAY['triple barrel value', 'top pair', 'value betting']
),

(
  'turn',
  'intermediate',
  '{"yourHand": "QQ", "position": "Button", "stackSize": 65, "blinds": "1/2", "potSize": 40, "actionSoFar": "You called a check-raise on flop", "communityCards": "J 9 5 two-tone → 2", "playersRemaining": 2, "effectiveStacks": 65}'::jsonb,
  'BB bets 25. What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 25"}, {"id": "C", "action": "Raise to 65 (all-in)"}, {"id": "D", "action": "Raise to 75"}]'::jsonb,
  'B',
  'You have an overpair facing a second barrel. The turn card is a blank. Call to keep the pot manageable and see the river. The BB could be bluffing or have a worse hand. You have position to make the final decision on the river.',
  ARRAY['bluff catching', 'overpair', 'pot control']
),

(
  'turn',
  'intermediate',
  '{"yourHand": "A9", "position": "Big Blind", "stackSize": 77, "blinds": "1/2", "potSize": 23, "actionSoFar": "Button bet flop 10, you called", "communityCards": "A 6 3 two-tone → 9", "playersRemaining": 2, "effectiveStacks": 77}'::jsonb,
  'Button checks. What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 15"}, {"id": "C", "action": "Bet 23"}, {"id": "D", "action": "Bet 40"}]'::jsonb,
  'B',
  'The button''s check shows weakness. You improved to two pair. Bet about 2/3 pot (15 chips) for value. Take control of the hand when your opponent shows weakness. Extract value from weaker aces or pairs.',
  ARRAY['probe betting', 'two pair', 'value betting']
),

(
  'turn',
  'intermediate',
  '{"yourHand": "JJ", "position": "Button", "stackSize": 82, "blinds": "1/2", "potSize": 32, "actionSoFar": "You bet flop 15, BB called", "communityCards": "T 7 3 rainbow → K", "playersRemaining": 2, "effectiveStacks": 67}'::jsonb,
  'BB checks. What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 16"}, {"id": "C", "action": "Bet 32"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'A',
  'The K is an overcard to your overpair. Check behind to control the pot. The BB could have a king or is trapping with a better hand. Check and reevaluate on the river. Your hand still has showdown value.',
  ARRAY['pot control', 'scary turn cards', 'way ahead/way behind']
),

(
  'turn',
  'intermediate',
  '{"yourHand": "K♠ Q♠", "position": "Cutoff", "stackSize": 77, "blinds": "1/2", "potSize": 23, "actionSoFar": "You c-bet flop 10, Button called", "communityCards": "A♠ J♠ 6♥ → 3♠", "playersRemaining": 2, "effectiveStacks": 77}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 15"}, {"id": "C", "action": "Bet 23"}, {"id": "D", "action": "Bet 50"}]'::jsonb,
  'B',
  'You made the nut flush on the turn! Bet about 2/3 pot (15 chips) to build the pot. The button called the flop so they likely have something. Extract value with your nuts but don''t over-bet and scare them away.',
  ARRAY['nut flush', 'value betting', 'turn made hands']
),

(
  'turn',
  'intermediate',
  '{"yourHand": "88", "position": "Middle", "stackSize": 64, "blinds": "1/2", "potSize": 36, "actionSoFar": "You called a raise pre-flop, bet flop 15, original raiser called", "communityCards": "8 7 6 two-tone → 9", "playersRemaining": 2, "effectiveStacks": 64}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 18"}, {"id": "C", "action": "Bet 36"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'B',
  'You have top set but the board is very wet with a straight now possible (T or 5). Bet about half pot (18 chips) to charge hands that might have made a straight or still drawing. Don''t slow-play on dangerous boards.',
  ARRAY['set on dangerous board', 'value betting', 'protection']
),

(
  'turn',
  'intermediate',
  '{"yourHand": "AQ", "position": "Button", "stackSize": 77, "blinds": "1/2", "potSize": 23, "actionSoFar": "You c-bet flop 10, BB called", "communityCards": "A K 5 rainbow → 8", "playersRemaining": 2, "effectiveStacks": 77}'::jsonb,
  'BB checks. What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 12"}, {"id": "C", "action": "Bet 23"}, {"id": "D", "action": "Bet 40"}]'::jsonb,
  'A',
  'You have second pair with the K on board. This is a marginal hand. Check behind to control the pot and get to showdown. The BB could have a king or better ace. Preserve your stack and realize your showdown value.',
  ARRAY['pot control', 'showdown value', 'marginal hands']
),

(
  'turn',
  'intermediate',
  '{"yourHand": "T9", "position": "Cutoff", "stackSize": 64, "blinds": "1/2", "potSize": 36, "actionSoFar": "You c-bet flop 15 as bluff, BB called", "communityCards": "K 6 3 rainbow → 2", "playersRemaining": 2, "effectiveStacks": 64}'::jsonb,
  'BB checks. What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 18"}, {"id": "C", "action": "Bet 36"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'A',
  'Your bluff was called and you have nothing. Give up on the turn. The BB showed strength by calling. Don''t continue bluffing without equity or a strong read. Check and give up cheaply.',
  ARRAY['giving up bluffs', 'pot control', 'bluff frequency']
),

(
  'turn',
  'intermediate',
  '{"yourHand": "77", "position": "Big Blind", "stackSize": 77, "blinds": "1/2", "potSize": 23, "actionSoFar": "Button bet flop 10, you called", "communityCards": "7 6 5 two-tone → 8", "playersRemaining": 2, "effectiveStacks": 77}'::jsonb,
  'Button bets 20. What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 20"}, {"id": "C", "action": "Raise to 60"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'B',
  'You have top set but a straight is now possible (any 4 or 9). Call to control the pot size. The button could have made a straight. Don''t raise and inflate the pot when you might be behind. Call and reassess on the river.',
  ARRAY['set vs straight', 'pot control', 'dangerous boards']
),

(
  'turn',
  'intermediate',
  '{"yourHand": "AK", "position": "Button", "stackSize": 64, "blinds": "1/2", "potSize": 36, "actionSoFar": "You c-bet flop 15 as bluff, BB called", "communityCards": "Q 8 3 rainbow → K", "playersRemaining": 2, "effectiveStacks": 64}'::jsonb,
  'BB checks. What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 18"}, {"id": "C", "action": "Bet 36"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'B',
  'You improved to second pair on the turn. This changes everything. Now bet for value (18 chips). The K is a good card for your c-betting range. Extract value from worse hands and maintain your betting line.',
  ARRAY['turn improvement', 'value betting', 'range advantage']
),

-- TURN ADVANCED (10 questions)
(
  'turn',
  'advanced',
  '{"yourHand": "A5s", "position": "Button", "stackSize": 58, "blinds": "1/2", "potSize": 45, "actionSoFar": "You 3-bet pre-flop as bluff, c-bet flop 20, BB called", "communityCards": "K 8 2 rainbow → 3", "playersRemaining": 2, "effectiveStacks": 58}'::jsonb,
  'BB checks. What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 25"}, {"id": "C", "action": "Bet 45"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'A',
  'Your bluff got called on the flop and you have minimal equity. Give up. The BB has shown strength by calling your c-bet in a 3-bet pot. Don''t continue firing without significant equity or fold equity. Check and give up.',
  ARRAY['giving up multi-street bluffs', 'equity', 'range reading']
),

(
  'turn',
  'advanced',
  '{"yourHand": "JJ", "position": "Cutoff", "stackSize": 67, "blinds": "1/2", "potSize": 40, "actionSoFar": "You bet flop 15, Button called", "communityCards": "Q T 5 two-tone → 9", "playersRemaining": 2, "effectiveStacks": 67}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 20"}, {"id": "C", "action": "Bet 40"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'B',
  'This is a mixed strategy spot with an underpair on a connected board. Bet small (20 chips) as a merge bet - not quite value, not quite bluff. This allows you to fold to a raise but wins when villain gives up.',
  ARRAY['merge betting', 'polarization', 'board texture']
),

(
  'turn',
  'advanced',
  '{"yourHand": "K9", "position": "Big Blind", "stackSize": 77, "blinds": "1/2", "potSize": 23, "actionSoFar": "Button bet flop 10, you called with top pair", "communityCards": "K 7 3 rainbow → 7", "playersRemaining": 2, "effectiveStacks": 77}'::jsonb,
  'Button checks. What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 15"}, {"id": "C", "action": "Bet 23"}, {"id": "D", "action": "Bet 40"}]'::jsonb,
  'B',
  'The button checked after betting the flop, showing weakness. The paired board is good for your range. Bet about 2/3 pot (15 chips) to take control and get value from weaker hands that might call. Don''t give free cards.',
  ARRAY['probe betting', 'exploiting weakness', 'paired boards']
),

(
  'turn',
  'advanced',
  '{"yourHand": "AQ", "position": "Button", "stackSize": 82, "blinds": "1/2", "potSize": 32, "actionSoFar": "You 3-bet pre-flop, bet flop 15, BB called", "communityCards": "A 9 4 two-tone → 6", "playersRemaining": 2, "effectiveStacks": 67}'::jsonb,
  'BB checks. What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 16"}, {"id": "C", "action": "Bet 32"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'B',
  'You have top pair good kicker in a 3-bet pot. Continue betting for value on this safe turn. About half pot (16 chips) maintains pressure and builds the pot for a river bet. You likely have the best hand.',
  ARRAY['3-bet pot dynamics', 'value betting', 'range advantage']
),

(
  'turn',
  'advanced',
  '{"yourHand": "99", "position": "Cutoff", "stackSize": 40, "blinds": "1/2", "potSize": 65, "actionSoFar": "You 3-bet, Button 4-bet, you called, bet flop 25, Button called", "communityCards": "7 4 2 rainbow → 3", "playersRemaining": 2, "effectiveStacks": 40}'::jsonb,
  'Button checks. What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 30"}, {"id": "C", "action": "Bet 40 (all-in)"}, {"id": "D", "action": "Bet 65"}]'::jsonb,
  'C',
  'You have an overpair in a 4-bet pot with perfect stack depth (less than 1 PSR). Go all-in for value. The button 4-bet pre-flop but just called your flop bet. They could have AK or QQ-JJ. Get your remaining chips in.',
  ARRAY['4-bet pots', 'stack-to-pot ratio', 'commitment']
),

(
  'turn',
  'advanced',
  '{"yourHand": "K♥ T♥", "position": "Button", "stackSize": 77, "blinds": "1/2", "potSize": 23, "actionSoFar": "You c-bet flop 10, BB called", "communityCards": "Q♥ 9♥ 3♠ → 2♠", "playersRemaining": 2, "effectiveStacks": 77}'::jsonb,
  'BB checks. What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 12"}, {"id": "C", "action": "Bet 23"}, {"id": "D", "action": "Bet 40"}]'::jsonb,
  'B',
  'You have a flush draw and gutshot (12 outs total). Continue semi-bluffing with half pot (12 chips). You have massive equity and can win now or on the river. This is a profitable barrel with your draw.',
  ARRAY['semi-bluff double barrel', 'combo draws', 'equity']
),

(
  'turn',
  'advanced',
  '{"yourHand": "AK", "position": "Cutoff", "stackSize": 58, "blinds": "1/2", "potSize": 45, "actionSoFar": "You 3-bet pre, BB called, c-bet 20, BB called", "communityCards": "Q J 4 rainbow → 2", "playersRemaining": 2, "effectiveStacks": 58}'::jsonb,
  'BB checks. What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 25"}, {"id": "C", "action": "Bet 45"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'A',
  'Your bluff got called in a 3-bet pot and you still have nothing. Give up on the turn. You have a gutshot (4 outs) which isn''t enough to continue firing. Check and realize your minimal showdown value.',
  ARRAY['giving up air', 'bluff frequency', 'equity realization']
),

(
  'turn',
  'advanced',
  '{"yourHand": "TT", "position": "Button", "stackSize": 67, "blinds": "1/2", "potSize": 40, "actionSoFar": "You called 3-bet pre-flop, called flop bet 15", "communityCards": "K K 5 rainbow → T", "playersRemaining": 2, "effectiveStacks": 52}'::jsonb,
  'Opponent bets 25. What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 25"}, {"id": "C", "action": "Raise to 52 (all-in)"}, {"id": "D", "action": "Raise to 75"}]'::jsonb,
  'C',
  'You have a full house! The turn gave you boats. Raise all-in (52 chips) for value. The opponent is betting on a paired board and likely has a king or bluff. Your hand is very strong - get your stack in.',
  ARRAY['slowplay vs aggression', 'full house', 'nuts']
),

(
  'turn',
  'advanced',
  '{"yourHand": "87s", "position": "Cutoff", "stackSize": 70, "blinds": "1/2", "potSize": 30, "actionSoFar": "You squeeze 3-bet pre-flop, MP called, c-bet 15, called", "communityCards": "6 5 2 rainbow → 9", "playersRemaining": 2, "effectiveStacks": 55}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 18"}, {"id": "C", "action": "Bet 30"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'B',
  'You have an open-ended straight draw (8 outs) as the 3-bettor. Continue with a small barrel (18 chips). You can represent an overpair and have good equity to improve. This maintains your polarized range.',
  ARRAY['polarized barreling', 'semi-bluff', 'squeeze pots']
),

(
  'turn',
  'advanced',
  '{"yourHand": "A3", "position": "Big Blind", "stackSize": 77, "blinds": "1/2", "potSize": 23, "actionSoFar": "Button bet flop 10, you called with weak ace", "communityCards": "A 8 4 two-tone → A", "playersRemaining": 2, "effectiveStacks": 77}'::jsonb,
  'Button checks. What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 15"}, {"id": "C", "action": "Bet 23"}, {"id": "D", "action": "Bet 40"}]'::jsonb,
  'B',
  'You have trips! The button checked showing weakness. Bet about 2/3 pot (15 chips) for value. They likely had an ace and are now worried you have one. You have trips and should build the pot. Don''t give free showdowns.',
  ARRAY['trips', 'value betting', 'exploiting checks']
);

-- Continue with RIVER and SPECIAL questions in final section...
