-- Continuation of 150 Questions - Part 2
-- POST-FLOP, TURN, RIVER, and SPECIAL SITUATIONS

INSERT INTO public.questions (category, difficulty, scenario, question_text, choices, correct_answer, explanation, key_concepts)
VALUES

-- ============================================================================
-- POST-FLOP QUESTIONS (30 total: 10 beginner, 10 intermediate, 10 advanced)
-- ============================================================================

-- POST-FLOP BEGINNER (10 questions)
(
  'post-flop',
  'beginner',
  '{"yourHand": "AK", "position": "Button", "stackSize": 94, "blinds": "1/2", "potSize": 15, "actionSoFar": "You raised pre-flop, BB called", "communityCards": "K 7 2 rainbow", "playersRemaining": 2, "effectiveStacks": 85}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 8"}, {"id": "C", "action": "Bet 15"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'B',
  'You have top pair top kicker on a dry board. Continuation bet about half pot (8 chips) for value and protection. This board hits your raising range hard and you want to build the pot with your strong hand while charging draws.',
  ARRAY['continuation betting', 'top pair', 'value betting']
),

(
  'post-flop',
  'beginner',
  '{"yourHand": "QQ", "position": "Cutoff", "stackSize": 94, "blinds": "1/2", "potSize": 15, "actionSoFar": "You raised pre-flop, BB called", "communityCards": "A 8 4 rainbow", "playersRemaining": 2, "effectiveStacks": 85}'::jsonb,
  'BB checks. What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 8"}, {"id": "C", "action": "Bet 15"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'B',
  'Despite the ace on board, you should still continuation bet. You have an overpair and the ace could easily have missed the big blind. A half-pot bet (8 chips) allows you to fold if raised but wins the pot often enough to be profitable.',
  ARRAY['c-betting scary boards', 'overpair', 'range advantage']
),

(
  'post-flop',
  'beginner',
  '{"yourHand": "A♠ Q♠", "position": "Button", "stackSize": 94, "blinds": "1/2", "potSize": 15, "actionSoFar": "You raised pre-flop, BB called", "communityCards": "K♠ 9♠ 3♥", "playersRemaining": 2, "effectiveStacks": 85}'::jsonb,
  'BB checks. What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 8"}, {"id": "C", "action": "Bet 15"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'B',
  'You have the nut flush draw (9 outs) and two overcards (possibly 6 more outs). This is a strong semi-bluffing hand. Bet 8 chips for value and fold equity. You have plenty of equity even if called.',
  ARRAY['semi-bluffing', 'flush draw', 'equity']
),

(
  'post-flop',
  'beginner',
  '{"yourHand": "99", "position": "Button", "stackSize": 94, "blinds": "1/2", "potSize": 15, "actionSoFar": "You raised pre-flop, BB called", "communityCards": "9 6 2 rainbow", "playersRemaining": 2, "effectiveStacks": 85}'::jsonb,
  'BB checks. What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 5"}, {"id": "C", "action": "Bet 10"}, {"id": "D", "action": "Bet 20"}]'::jsonb,
  'C',
  'You flopped a set - a very strong hand! Bet about 2/3 pot (10 chips) for value. Don''t slow-play on this dry board. Build the pot while protecting against draws. The BB called pre-flop so likely has something.',
  ARRAY['flopped set', 'value betting', 'pot building']
),

(
  'post-flop',
  'beginner',
  '{"yourHand": "JT", "position": "Button", "stackSize": 94, "blinds": "1/2", "potSize": 15, "actionSoFar": "You raised pre-flop, BB called", "communityCards": "8 7 3 two-tone", "playersRemaining": 2, "effectiveStacks": 85}'::jsonb,
  'BB checks. What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 8"}, {"id": "C", "action": "Bet 15"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'B',
  'You have an open-ended straight draw (8 outs). This is a good semi-bluff spot. Bet 8 chips to win now or improve on later streets. You have position and fold equity plus decent equity when called.',
  ARRAY['semi-bluffing', 'straight draw', 'c-betting']
),

(
  'post-flop',
  'beginner',
  '{"yourHand": "AK", "position": "Cutoff", "stackSize": 85, "blinds": "1/2", "potSize": 15, "actionSoFar": "You raised pre-flop, BB called", "communityCards": "Q J 5 rainbow", "playersRemaining": 2, "effectiveStacks": 85}'::jsonb,
  'BB checks. What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 8"}, {"id": "C", "action": "Bet 15"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'B',
  'You completely missed but have a gutshot to the nut straight and two overcards. Continuation bet 8 chips as a bluff. You have the betting lead and range advantage. The BB will fold often enough to make this profitable.',
  ARRAY['bluff c-betting', 'range advantage', 'fold equity']
),

(
  'post-flop',
  'beginner',
  '{"yourHand": "66", "position": "Button", "stackSize": 94, "blinds": "1/2", "potSize": 15, "actionSoFar": "You raised pre-flop, BB called", "communityCards": "K Q 9 two-tone", "playersRemaining": 2, "effectiveStacks": 85}'::jsonb,
  'BB checks. What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 8"}, {"id": "C", "action": "Bet 15"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'A',
  'This board is terrible for your hand with three high cards and flush draws. Check behind and give up. You have showdown value and might win at showdown. Betting just gets called or raised by better hands. Cut your losses.',
  ARRAY['showdown value', 'board texture', 'pot control']
),

(
  'post-flop',
  'beginner',
  '{"yourHand": "AJ", "position": "Big Blind", "stackSize": 94, "blinds": "1/2", "potSize": 15, "actionSoFar": "Button raised, you called", "communityCards": "A 8 3 rainbow", "playersRemaining": 2, "effectiveStacks": 85}'::jsonb,
  'You check, Button bets 10. What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 10"}, {"id": "C", "action": "Raise to 30"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'B',
  'You have top pair decent kicker on a dry board. Call the continuation bet. Raising would bloat the pot out of position with a marginal hand. Calling keeps the pot small and allows you to see the turn cheaply.',
  ARRAY['top pair', 'calling in position', 'pot control']
),

(
  'post-flop',
  'beginner',
  '{"yourHand": "T9", "position": "Button", "stackSize": 94, "blinds": "1/2", "potSize": 15, "actionSoFar": "You raised pre-flop, BB called", "communityCards": "K Q 2 rainbow", "playersRemaining": 2, "effectiveStacks": 85}'::jsonb,
  'BB checks. What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 8"}, {"id": "C", "action": "Bet 15"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'B',
  'You have no pair but a gutshot straight draw. This is a good bluff spot with some equity. Bet 8 chips as a continuation bet. The board could easily have missed the BB, and you have backdoor straight potential.',
  ARRAY['bluff c-betting', 'gutshot', 'fold equity']
),

(
  'post-flop',
  'beginner',
  '{"yourHand": "KK", "position": "Middle", "stackSize": 94, "blinds": "1/2", "potSize": 15, "actionSoFar": "You raised pre-flop, Cutoff called", "communityCards": "7 4 2 rainbow", "playersRemaining": 2, "effectiveStacks": 85}'::jsonb,
  'You bet 10, Cutoff calls. What is your plan?',
  '[{"id": "A", "action": "Check most turns"}, {"id": "B", "action": "Bet again on most turns"}, {"id": "C", "action": "Only bet if a K comes"}, {"id": "D", "action": "Check-fold to any bet"}]'::jsonb,
  'B',
  'You have an overpair on a dry board. Continue betting on most turn cards for value. Your hand is strong and the CO likely has a weaker pair or draw. Keep building the pot and protect your hand.',
  ARRAY['multi-street value', 'overpair', 'protection']
),

-- POST-FLOP INTERMEDIATE (10 questions)
(
  'post-flop',
  'intermediate',
  '{"yourHand": "QQ", "position": "Button", "stackSize": 85, "blinds": "1/2", "potSize": 20, "actionSoFar": "You c-bet 10, BB raises to 30", "communityCards": "J 9 5 two-tone", "playersRemaining": 2, "effectiveStacks": 75}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 20"}, {"id": "C", "action": "Raise to 70"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'B',
  'You have an overpair facing a check-raise on a connected board with flush draws. Calling keeps the pot manageable and lets you see the turn. You have position to control the hand. Folding is too weak, raising commits too many chips.',
  ARRAY['facing check-raise', 'pot control', 'position']
),

(
  'post-flop',
  'intermediate',
  '{"yourHand": "AK", "position": "Cutoff", "stackSize": 76, "blinds": "1/2", "potSize": 24, "actionSoFar": "You 3-bet pre-flop, BB called", "communityCards": "A 8 3 rainbow", "playersRemaining": 2, "effectiveStacks": 76}'::jsonb,
  'BB checks. What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 12"}, {"id": "C", "action": "Bet 24"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'B',
  'You have top pair top kicker in a 3-bet pot. Bet about half pot (12 chips) for value. This board hits your 3-betting range hard. A smaller bet gets value from worse aces and allows you to pot-control if raised.',
  ARRAY['3-bet pots', 'top pair', 'value betting']
),

(
  'post-flop',
  'intermediate',
  '{"yourHand": "JJ", "position": "Button", "stackSize": 82, "blinds": "1/2", "potSize": 20, "actionSoFar": "You 3-bet pre-flop, BB called", "communityCards": "T 7 3 rainbow", "playersRemaining": 2, "effectiveStacks": 82}'::jsonb,
  'BB checks. What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 10"}, {"id": "C", "action": "Bet 20"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'B',
  'You have an overpair on a dry board in a 3-bet pot. Bet about half pot (10 chips) for value and protection. This board favors your range and you want to build the pot while denying equity to hands like overcards.',
  ARRAY['3-bet pots', 'overpair', 'c-betting']
),

(
  'post-flop',
  'intermediate',
  '{"yourHand": "A♥ K♥", "position": "Button", "stackSize": 94, "blinds": "1/2", "potSize": 15, "actionSoFar": "You raised pre-flop, BB called", "communityCards": "Q♥ J♥ 4♠", "playersRemaining": 2, "effectiveStacks": 85}'::jsonb,
  'BB checks. What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 8"}, {"id": "C", "action": "Bet 15"}, {"id": "D", "action": "Bet 30"}]'::jsonb,
  'B',
  'You have the nut flush draw, gutshot to the nuts, and two overcards (approximately 17 outs twice!). This is a premium semi-bluff. Bet 8 chips with massive equity. You''re actually favored against many made hands.',
  ARRAY['monster draw', 'semi-bluffing', 'equity']
),

(
  'post-flop',
  'intermediate',
  '{"yourHand": "99", "position": "Cutoff", "stackSize": 85, "blinds": "1/2", "potSize": 15, "actionSoFar": "You raised pre-flop, Button called", "communityCards": "K Q 7 two-tone", "playersRemaining": 2, "effectiveStacks": 85}'::jsonb,
  'You check, Button bets 10. What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 10"}, {"id": "C", "action": "Raise to 30"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'A',
  'Two overcards and a flush draw on board make your pocket 9s vulnerable. The Button likely has a better hand (pair, draw, or overcards). Folding preserves your stack. You''re beat too often to profitably continue.',
  ARRAY['folding to aggression', 'board texture', 'range reading']
),

(
  'post-flop',
  'intermediate',
  '{"yourHand": "AT", "position": "Big Blind", "stackSize": 94, "blinds": "1/2", "potSize": 15, "actionSoFar": "Button raised, you called", "communityCards": "T 6 2 rainbow", "playersRemaining": 2, "effectiveStacks": 85}'::jsonb,
  'You check, Button bets 10. What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 10"}, {"id": "C", "action": "Raise to 30"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'C',
  'You have top pair on a dry board. Check-raising is a strong play here to build the pot and define your opponent''s hand. Many button raises are wide, and you have a good hand. Raise to 30 to take control.',
  ARRAY['check-raising', 'top pair', 'aggression']
),

(
  'post-flop',
  'intermediate',
  '{"yourHand": "AQ", "position": "Button", "stackSize": 94, "blinds": "1/2", "potSize": 15, "actionSoFar": "You raised pre-flop, BB called", "communityCards": "A K 5 rainbow", "playersRemaining": 2, "effectiveStacks": 85}'::jsonb,
  'BB checks. What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 8"}, {"id": "C", "action": "Bet 15"}, {"id": "D", "action": "Bet 30"}]'::jsonb,
  'B',
  'You have second pair but the K is concerning. Bet small (8 chips) for thin value and information. If raised, you can fold. Many hands the BB called with don''t have a king. Control the pot size with a vulnerable hand.',
  ARRAY['thin value betting', 'board texture', 'pot control']
),

(
  'post-flop',
  'intermediate',
  '{"yourHand": "77", "position": "Button", "stackSize": 94, "blinds": "1/2", "potSize": 15, "actionSoFar": "You raised pre-flop, BB called", "communityCards": "7 6 5 two-tone", "playersRemaining": 2, "effectiveStacks": 85}'::jsonb,
  'BB checks. What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 8"}, {"id": "C", "action": "Bet 15"}, {"id": "D", "action": "Bet 30"}]'::jsonb,
  'B',
  'You have a set but the board is very coordinated with straight draws. Bet about half pot (8 chips) to charge draws. Don''t slow-play on wet boards. Build the pot but keep it manageable in case villain has a straight already.',
  ARRAY['set on wet board', 'protection betting', 'draw heavy boards']
),

(
  'post-flop',
  'intermediate',
  '{"yourHand": "KQ", "position": "Cutoff", "stackSize": 94, "blinds": "1/2", "potSize": 15, "actionSoFar": "You raised pre-flop, BB called", "communityCards": "K 9 8 two-tone", "playersRemaining": 2, "effectiveStacks": 85}'::jsonb,
  'BB checks, you bet 10, BB calls. What is your plan for the turn?',
  '[{"id": "A", "action": "Check most turns"}, {"id": "B", "action": "Bet again on most turns"}, {"id": "C", "action": "Only bet if you improve"}, {"id": "D", "action": "Check-fold to any bet"}]'::jsonb,
  'B',
  'You have top pair good kicker. Continue betting most turns for value. Your hand is strong on this board and the BB likely has a weaker pair or draw. Keep building the pot and protect your hand from drawing hands.',
  ARRAY['multi-street value', 'top pair', 'barrel']
),

(
  'post-flop',
  'intermediate',
  '{"yourHand": "A8", "position": "Big Blind", "stackSize": 94, "blinds": "1/2", "potSize": 15, "actionSoFar": "Button raised, you called", "communityCards": "A J 7 two-tone", "playersRemaining": 2, "effectiveStacks": 85}'::jsonb,
  'You check, Button bets 10. What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 10"}, {"id": "C", "action": "Raise to 30"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'B',
  'You have top pair weak kicker. Call the continuation bet. Your hand has showdown value but raising would bloat the pot with a vulnerable hand. Call and reassess on the turn based on the action and board texture.',
  ARRAY['weak kicker', 'showdown value', 'pot control']
),

-- POST-FLOP ADVANCED (10 questions)
(
  'post-flop',
  'advanced',
  '{"yourHand": "AK", "position": "Button", "stackSize": 82, "blinds": "1/2", "potSize": 24, "actionSoFar": "You 3-bet pre-flop, BB called", "communityCards": "8 6 3 rainbow", "playersRemaining": 2, "effectiveStacks": 82}'::jsonb,
  'BB checks. What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 12"}, {"id": "C", "action": "Bet 24"}, {"id": "D", "action": "Bet 50"}]'::jsonb,
  'B',
  'As the 3-bettor on a dry low board, continuation bet about half pot (12). This board favors your range (overpairs, AK). A smaller bet is efficient - it accomplishes your goals without risking too much. You have good fold equity.',
  ARRAY['range betting', '3-bet pots', 'c-betting air']
),

(
  'post-flop',
  'advanced',
  '{"yourHand": "T9s", "position": "Cutoff", "stackSize": 78, "blinds": "1/2", "potSize": 26, "actionSoFar": "You 3-bet pre-flop as bluff, MP called", "communityCards": "A K 4 rainbow", "playersRemaining": 2, "effectiveStacks": 78}'::jsonb,
  'MP checks. What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 13"}, {"id": "C", "action": "Bet 26"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'B',
  'You have nothing but bluffed pre-flop. This board hits your 3-betting range perfectly. Continuation bet half pot (13) to represent AK, AQ, or big pairs. The MP will have difficulty continuing without a strong hand.',
  ARRAY['triple barrel bluff', 'range representation', 'polarization']
),

(
  'post-flop',
  'advanced',
  '{"yourHand": "JJ", "position": "Button", "stackSize": 82, "blinds": "1/2", "potSize": 20, "actionSoFar": "You 3-bet pre-flop, BB called", "communityCards": "Q T 5 two-tone", "playersRemaining": 2, "effectiveStacks": 82}'::jsonb,
  'BB checks. What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 10"}, {"id": "C", "action": "Bet 20"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'B',
  'This is a mixed strategy spot. With an underpair to the queen, bet small (10) for protection and value. The Q-high board isn''t terrible for your range. If check-raised, you can fold. Small bet balances your range.',
  ARRAY['range balancing', 'protection', 'mixed strategies']
),

(
  'post-flop',
  'advanced',
  '{"yourHand": "A5s", "position": "Button", "stackSize": 73, "blinds": "1/2", "potSize": 30, "actionSoFar": "You 3-bet pre-flop as bluff, CO called, you c-bet 15, CO called", "communityCards": "K 8 2 rainbow", "playersRemaining": 2, "effectiveStacks": 58}'::jsonb,
  'Turn is 3. CO checks. What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 20"}, {"id": "C", "action": "Bet 30"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'A',
  'Your bluff was called on the flop. The CO likely has a pair. Give up on the turn. You don''t have enough equity to barrel again. Preserve your stack and pick better spots. Not every bluff needs to continue.',
  ARRAY['giving up', 'bluff frequency', 'equity']
),

(
  'post-flop',
  'advanced',
  '{"yourHand": "99", "position": "Cutoff", "stackSize": 85, "blinds": "1/2", "potSize": 20, "actionSoFar": "You raised pre-flop, Button 3-bet, you called", "communityCards": "7 4 2 rainbow", "playersRemaining": 2, "effectiveStacks": 65}'::jsonb,
  'Button bets 12. What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 12"}, {"id": "C", "action": "Raise to 35"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'C',
  'You have an overpair on a dry board. The button could be c-betting any two cards. Raise to 35 to take control and build the pot with your strong hand. This is a value raise - you''re ahead of the button''s c-betting range.',
  ARRAY['raising c-bets', 'value raising', 'aggression']
),

(
  'post-flop',
  'advanced',
  '{"yourHand": "AQ", "position": "Big Blind", "stackSize": 94, "blinds": "1/2", "potSize": 15, "actionSoFar": "Button raised, you called", "communityCards": "Q 9 3 two-tone", "playersRemaining": 2, "effectiveStacks": 85}'::jsonb,
  'You check, Button bets 10. What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 10"}, {"id": "C", "action": "Raise to 30"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'C',
  'You have top pair good kicker on a relatively dry board. Check-raise to 30 to build the pot with your strong hand and deny equity to draws. The button is c-betting wide from the button. Take control of the hand.',
  ARRAY['check-raising value', 'top pair', 'pot building']
),

(
  'post-flop',
  'advanced',
  '{"yourHand": "K♠ Q♠", "position": "Button", "stackSize": 94, "blinds": "1/2", "potSize": 15, "actionSoFar": "You raised pre-flop, BB called", "communityCards": "A♠ J♠ 6♥", "playersRemaining": 2, "effectiveStacks": 85}'::jsonb,
  'BB checks. What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 8"}, {"id": "C", "action": "Bet 15"}, {"id": "D", "action": "Bet 30"}]'::jsonb,
  'B',
  'You have the nut flush draw, gutshot to the nuts, and backdoor straight draws. This is a massive semi-bluff. Bet 8 chips with tremendous equity. You can win now or improve to the nuts on many turn cards.',
  ARRAY['monster draw', 'semi-bluffing', 'equity realization']
),

(
  'post-flop',
  'advanced',
  '{"yourHand": "TT", "position": "Button", "stackSize": 85, "blinds": "1/2", "potSize": 20, "actionSoFar": "You called a 3-bet pre-flop", "communityCards": "K K 5 rainbow", "playersRemaining": 2, "effectiveStacks": 65}'::jsonb,
  'Opponent bets 12. What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 12"}, {"id": "C", "action": "Raise to 35"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'B',
  'On a paired king board as the pre-flop caller, you should float this bet. The 3-bettor is c-betting their entire range. You can bluff-catch or bluff later streets. Raising is too aggressive without a king. Call and reassess.',
  ARRAY['float calling', 'bluff catching', 'paired boards']
),

(
  'post-flop',
  'advanced',
  '{"yourHand": "AK", "position": "Cutoff", "stackSize": 55, "blinds": "1/2", "potSize": 45, "actionSoFar": "You 3-bet, UTG 4-bet, you called", "communityCards": "J T 4 rainbow", "playersRemaining": 2, "effectiveStacks": 55}'::jsonb,
  'UTG bets 30. What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 30"}, {"id": "C", "action": "Raise to 55 (all-in)"}, {"id": "D", "action": "Raise to 75"}]'::jsonb,
  'C',
  'You have a gutshot and two overcards (14 outs) in a massive pot (75 chips). You only have 55 left. Go all-in for fold equity plus equity when called. Against KK-AA, you have approximately 50% equity. Commit your remaining chips.',
  ARRAY['semi-bluff shove', 'pot odds', 'equity']
),

(
  'post-flop',
  'advanced',
  '{"yourHand": "88", "position": "Button", "stackSize": 94, "blinds": "1/2", "potSize": 15, "actionSoFar": "You raised pre-flop, BB called", "communityCards": "8 7 6 two-tone", "playersRemaining": 2, "effectiveStacks": 85}'::jsonb,
  'BB checks. What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 8"}, {"id": "C", "action": "Bet 12"}, {"id": "D", "action": "Bet 25"}]'::jsonb,
  'B',
  'You have top set on an extremely wet board with multiple straight draws. Bet smaller (8 chips) to keep draws in and extract value. If you bet too big, you only get action from straights. Balance extracting value and protecting.',
  ARRAY['set on wet board', 'value betting', 'board texture']
);

-- Continue with TURN questions in next section...
