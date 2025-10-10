-- Complete 150 Question Set for Poker Tutor
-- Categories: Pre-Flop (50), Post-Flop (30), Turn (30), River (30), Special (10)
-- Difficulty: Beginner, Intermediate, Advanced

-- Clear existing sample questions (optional - comment out if you want to keep them)
-- DELETE FROM public.questions;

INSERT INTO public.questions (category, difficulty, scenario, question_text, choices, correct_answer, explanation, key_concepts)
VALUES

-- ============================================================================
-- PRE-FLOP QUESTIONS (50 total: 10 beginner, 20 intermediate, 20 advanced)
-- ============================================================================

-- PRE-FLOP BEGINNER (10 questions)
(
  'pre-flop',
  'beginner',
  '{"yourHand": "AA", "position": "Button", "stackSize": 100, "blinds": "1/2", "potSize": 3, "actionSoFar": "Folds to you", "playersRemaining": 3, "effectiveStacks": 100}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 2"}, {"id": "C", "action": "Raise to 6"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'C',
  'Pocket Aces is the strongest starting hand in poker. From the button with a strong hand, you should raise to build the pot and take control. A standard 3BB raise is optimal to get value while keeping worse hands in the pot.',
  ARRAY['premium hands', 'position', 'value raising']
),

(
  'pre-flop',
  'beginner',
  '{"yourHand": "72o", "position": "Early", "stackSize": 100, "blinds": "1/2", "potSize": 3, "actionSoFar": "Action is on you", "playersRemaining": 9, "effectiveStacks": 100}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 2"}, {"id": "C", "action": "Raise to 6"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'A',
  '72 offsuit is the worst starting hand in poker with no potential. From early position with many players behind, fold immediately. Only play premium hands from early position to avoid difficult post-flop situations.',
  ARRAY['hand selection', 'position awareness', 'discipline']
),

(
  'pre-flop',
  'beginner',
  '{"yourHand": "KK", "position": "Middle", "stackSize": 100, "blinds": "1/2", "potSize": 3, "actionSoFar": "Action is on you", "playersRemaining": 7, "effectiveStacks": 100}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 2"}, {"id": "C", "action": "Raise to 6"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'C',
  'Pocket Kings is the second-best starting hand. Raise to 3BB to build the pot and narrow the field. Limping (calling) would allow too many opponents to see a cheap flop, which reduces your equity.',
  ARRAY['premium pairs', 'value raising', 'isolation']
),

(
  'pre-flop',
  'beginner',
  '{"yourHand": "AKo", "position": "Big Blind", "stackSize": 100, "blinds": "1/2", "potSize": 10, "actionSoFar": "Button raises to 6, SB folds", "playersRemaining": 2, "effectiveStacks": 94}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 4"}, {"id": "C", "action": "Raise to 18"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'C',
  'AK offsuit is a premium hand that plays well in raised pots. 3-betting to 18 chips puts pressure on the button raiser and builds a pot with your strong hand. You have good equity against most raising ranges.',
  ARRAY['big blind defense', '3-betting', 'premium hands']
),

(
  'pre-flop',
  'beginner',
  '{"yourHand": "QQ", "position": "Cutoff", "stackSize": 100, "blinds": "1/2", "potSize": 3, "actionSoFar": "UTG raises to 8", "playersRemaining": 6, "effectiveStacks": 92}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 8"}, {"id": "C", "action": "Raise to 24"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'C',
  'QQ is a strong premium pair. Even against an early position raise, you should 3-bet for value. This builds the pot with your strong hand and may isolate the original raiser, giving you position post-flop.',
  ARRAY['premium pairs', '3-betting value', 'position']
),

(
  'pre-flop',
  'beginner',
  '{"yourHand": "T9s", "position": "Small Blind", "stackSize": 100, "blinds": "1/2", "potSize": 3, "actionSoFar": "Everyone folds", "playersRemaining": 2, "effectiveStacks": 100}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 1"}, {"id": "C", "action": "Raise to 6"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'C',
  'In a heads-up situation from the small blind, T9 suited has good playability. Raising pressures the big blind and allows you to win the pot immediately or play in position if called. Don''t limp - be aggressive.',
  ARRAY['small blind play', 'heads-up', 'aggression']
),

(
  'pre-flop',
  'beginner',
  '{"yourHand": "JJ", "position": "Early", "stackSize": 100, "blinds": "1/2", "potSize": 3, "actionSoFar": "Action is on you", "playersRemaining": 9, "effectiveStacks": 100}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 2"}, {"id": "C", "action": "Raise to 6"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'C',
  'Pocket Jacks is a strong hand even from early position. Raise to 3BB to build the pot and define your opponents'' ranges. This hand plays well in raised pots and you want to narrow the field.',
  ARRAY['premium pairs', 'early position', 'value raising']
),

(
  'pre-flop',
  'beginner',
  '{"yourHand": "A3o", "position": "Button", "stackSize": 100, "blinds": "1/2", "potSize": 3, "actionSoFar": "UTG raises to 8, MP calls", "playersRemaining": 5, "effectiveStacks": 92}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 8"}, {"id": "C", "action": "Raise to 30"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'A',
  'A3 offsuit is too weak to continue facing a raise and a call, even from the button. Multi-way pots require stronger hands. The weak kicker makes this hand vulnerable even if you hit an ace. Fold and wait for better spots.',
  ARRAY['hand selection', 'multi-way pots', 'weak kicker']
),

(
  'pre-flop',
  'beginner',
  '{"yourHand": "88", "position": "Middle", "stackSize": 100, "blinds": "1/2", "potSize": 8, "actionSoFar": "UTG raises to 6", "playersRemaining": 7, "effectiveStacks": 94}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 6"}, {"id": "C", "action": "Raise to 20"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'B',
  'Pocket 88 has good implied odds to set-mine against an early position raise. Calling keeps the pot small and allows you to try to flop a set. You can fold if overcards come and no set, or win a big pot when you hit.',
  ARRAY['pocket pairs', 'set mining', 'implied odds']
),

(
  'pre-flop',
  'beginner',
  '{"yourHand": "AQo", "position": "Cutoff", "stackSize": 100, "blinds": "1/2", "potSize": 3, "actionSoFar": "Folds to you", "playersRemaining": 4, "effectiveStacks": 100}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 2"}, {"id": "C", "action": "Raise to 6"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'C',
  'AQ offsuit is a strong hand from the cutoff. Raise to 3BB to build the pot with your strong hand. You have position on the blinds and can play the pot effectively post-flop whether you hit or miss.',
  ARRAY['broadway cards', 'position', 'value raising']
),

-- PRE-FLOP INTERMEDIATE (20 questions)
(
  'pre-flop',
  'intermediate',
  '{"yourHand": "AJs", "position": "Cutoff", "stackSize": 100, "blinds": "1/2", "potSize": 8, "actionSoFar": "MP raises to 6", "playersRemaining": 6, "effectiveStacks": 94}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 6"}, {"id": "C", "action": "Raise to 18"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'C',
  'AJ suited is strong enough to 3-bet from the cutoff against a middle position open. You have position, a strong hand, and can balance your 3-betting range. This puts pressure on the raiser and can win the pot immediately.',
  ARRAY['3-betting', 'suited broadway', 'position advantage']
),

(
  'pre-flop',
  'intermediate',
  '{"yourHand": "KQo", "position": "Big Blind", "stackSize": 100, "blinds": "1/2", "potSize": 9, "actionSoFar": "Button raises to 6, SB folds", "playersRemaining": 2, "effectiveStacks": 94}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 4"}, {"id": "C", "action": "Raise to 18"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'B',
  'KQ offsuit plays reasonably well against a button steal attempt, but 3-betting would be too aggressive from out of position. Calling allows you to see a flop cheaply with decent pot odds. You can reevaluate based on the flop texture.',
  ARRAY['big blind defense', 'pot odds', 'out of position']
),

(
  'pre-flop',
  'intermediate',
  '{"yourHand": "A5s", "position": "Button", "stackSize": 100, "blinds": "1/2", "potSize": 3, "actionSoFar": "Folds to you", "playersRemaining": 3, "effectiveStacks": 100}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 2"}, {"id": "C", "action": "Raise to 6"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'C',
  'A5 suited from the button is a strong stealing hand with both high card and wheel potential. Raise to put pressure on the blinds. This hand has good playability post-flop with flush draws, straight potential, and can make nut hands.',
  ARRAY['button stealing', 'suited ace', 'speculative hands']
),

(
  'pre-flop',
  'intermediate',
  '{"yourHand": "TT", "position": "Middle", "stackSize": 100, "blinds": "1/2", "potSize": 11, "actionSoFar": "UTG raises to 6, you call, CO 3-bets to 22", "playersRemaining": 5, "effectiveStacks": 78}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 16"}, {"id": "C", "action": "Raise to 60"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'A',
  'Facing a 3-bet after calling a raise, TT is in a tough spot. The CO''s 3-bet represents a strong range, and you''re sandwiched with the original raiser still to act. Folding avoids a difficult situation. Set-mining isn''t profitable with reduced stack depth.',
  ARRAY['squeeze play', 'medium pairs', 'ICM pressure']
),

(
  'pre-flop',
  'intermediate',
  '{"yourHand": "AKs", "position": "Small Blind", "stackSize": 100, "blinds": "1/2", "potSize": 9, "actionSoFar": "Button raises to 6", "playersRemaining": 3, "effectiveStacks": 94}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 5"}, {"id": "C", "action": "Raise to 20"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'C',
  'AK suited is a premium hand that should be 3-bet for value from the small blind. A raise to 20 chips builds the pot and isolates the button raiser. This hand has excellent equity against button stealing ranges.',
  ARRAY['3-betting value', 'premium suited', 'blind vs blind']
),

(
  'pre-flop',
  'intermediate',
  '{"yourHand": "99", "position": "Button", "stackSize": 30, "blinds": "1/2", "potSize": 3, "actionSoFar": "MP raises to 6", "playersRemaining": 5, "effectiveStacks": 24}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 6"}, {"id": "C", "action": "Raise to 15"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'D',
  'With 30BB, pocket 99 is strong enough to go all-in facing a raise. The short stack makes set-mining less profitable. Shoving has fold equity and realizes your equity now rather than playing difficult post-flop decisions with a short stack.',
  ARRAY['short stack', 'push/fold', 'stack-to-pot ratio']
),

(
  'pre-flop',
  'intermediate',
  '{"yourHand": "76s", "position": "Button", "stackSize": 150, "blinds": "1/2", "potSize": 8, "actionSoFar": "MP raises to 6, CO calls", "playersRemaining": 5, "effectiveStacks": 144}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 6"}, {"id": "C", "action": "Raise to 24"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'B',
  '76 suited has excellent implied odds with deep stacks and multiple opponents. Call to see if you flop a strong draw or made hand. The deep stacks mean you can win a huge pot when you make straights or flushes. Position is perfect.',
  ARRAY['suited connectors', 'implied odds', 'deep stack']
),

(
  'pre-flop',
  'intermediate',
  '{"yourHand": "AQo", "position": "Cutoff", "stackSize": 100, "blinds": "1/2", "potSize": 14, "actionSoFar": "UTG raises to 6, MP calls, HJ calls", "playersRemaining": 6, "effectiveStacks": 94}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 6"}, {"id": "C", "action": "Raise to 30"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'A',
  'In a 4-way pot, AQ offsuit doesn''t play well. Multiple opponents reduce your fold equity and increase the chance someone has you dominated or will outdraw you. Multi-way pots favor hands that make strong draws and made hands, not top pair hands.',
  ARRAY['multi-way dynamics', 'hand selection', 'positional awareness']
),

(
  'pre-flop',
  'intermediate',
  '{"yourHand": "QJs", "position": "Big Blind", "stackSize": 100, "blinds": "1/2", "potSize": 14, "actionSoFar": "Cutoff raises to 6, Button calls, SB folds", "playersRemaining": 3, "effectiveStacks": 94}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 4"}, {"id": "C", "action": "Raise to 24"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'B',
  'QJ suited getting great pot odds (4 to win 14) from the big blind is an easy call. You''re closing the action and the hand has good playability. You can make straights, flushes, and good pairs. No need to 3-bet out of position in a 3-way pot.',
  ARRAY['pot odds', 'closing the action', 'playability']
),

(
  'pre-flop',
  'intermediate',
  '{"yourHand": "ATo", "position": "Middle", "stackSize": 100, "blinds": "1/2", "potSize": 3, "actionSoFar": "Action on you", "playersRemaining": 7, "effectiveStacks": 100}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 2"}, {"id": "C", "action": "Raise to 6"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'C',
  'AT offsuit from middle position is on the borderline but strong enough to open-raise. Raising defines your range and gives you the initiative. This hand plays better heads-up than in multi-way pots. Don''t limp.',
  ARRAY['opening range', 'initiative', 'broadway cards']
),

(
  'pre-flop',
  'intermediate',
  '{"yourHand": "55", "position": "Button", "stackSize": 100, "blinds": "1/2", "potSize": 14, "actionSoFar": "UTG raises to 6, MP calls, CO calls", "playersRemaining": 6, "effectiveStacks": 94}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 6"}, {"id": "C", "action": "Raise to 28"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'B',
  'Small pocket pairs play well in multi-way pots with position. You have great implied odds to hit a set (happens 1 in 8 times). Call, and if you hit your set you can win a big pot. If you miss, you can fold easily to aggression.',
  ARRAY['set mining', 'multi-way pots', 'implied odds']
),

(
  'pre-flop',
  'intermediate',
  '{"yourHand": "K9s", "position": "Cutoff", "stackSize": 100, "blinds": "1/2", "potSize": 3, "actionSoFar": "Folds to you", "playersRemaining": 4, "effectiveStacks": 100}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 2"}, {"id": "C", "action": "Raise to 6"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'C',
  'K9 suited from the cutoff is a profitable steal. You have position and a playable hand. Raising gives you fold equity and the initiative. This hand can make flushes, straights, and sometimes top pair is good.',
  ARRAY['steal attempts', 'suited cards', 'position']
),

(
  'pre-flop',
  'intermediate',
  '{"yourHand": "JTs", "position": "Early", "stackSize": 100, "blinds": "1/2", "potSize": 3, "actionSoFar": "Action on you", "playersRemaining": 9, "effectiveStacks": 100}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 2"}, {"id": "C", "action": "Raise to 6"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'A',
  'JT suited from early position is too weak to open. With many players behind, you''ll face resistance from stronger hands. Save this hand for late position where you have more information and better stealing opportunities.',
  ARRAY['early position', 'hand selection', 'discipline']
),

(
  'pre-flop',
  'intermediate',
  '{"yourHand": "A8s", "position": "Small Blind", "stackSize": 100, "blinds": "1/2", "potSize": 11, "actionSoFar": "Cutoff raises to 6, Button calls", "playersRemaining": 4, "effectiveStacks": 94}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 5"}, {"id": "C", "action": "Raise to 24"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'A',
  'A8 suited is too weak to continue in a 3-way pot out of position, even with decent pot odds. You''ll often be dominated by better aces, and playing out of position in multi-way pots is difficult. Fold and wait for a better spot.',
  ARRAY['dominated hands', 'out of position', 'multi-way']
),

(
  'pre-flop',
  'intermediate',
  '{"yourHand": "AKo", "position": "Cutoff", "stackSize": 100, "blinds": "1/2", "potSize": 20, "actionSoFar": "UTG raises to 6, you 3-bet to 18, UTG calls", "playersRemaining": 3, "effectiveStacks": 82}'::jsonb,
  'Flop comes Q-7-2 rainbow. UTG checks. What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 12"}, {"id": "C", "action": "Bet 20"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'B',
  'As the pre-flop aggressor, you should continuation bet this dry board. A bet of about 60% pot (12 chips) continues your story and can win the pot immediately. Your hand has outs to improve and you have fold equity.',
  ARRAY['continuation betting', 'pre-flop aggressor', 'missed flop']
),

(
  'pre-flop',
  'intermediate',
  '{"yourHand": "33", "position": "Button", "stackSize": 50, "blinds": "1/2", "potSize": 8, "actionSoFar": "MP raises to 6", "playersRemaining": 5, "effectiveStacks": 44}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 6"}, {"id": "C", "action": "Raise to 18"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'A',
  'With only 50BB effective stacks, pocket 33 doesn''t have good implied odds for set mining. You need deeper stacks (100BB+) to profitably call looking to hit a set. The risk/reward isn''t favorable at these stack depths.',
  ARRAY['stack depth', 'implied odds', 'small pairs']
),

(
  'pre-flop',
  'intermediate',
  '{"yourHand": "AJo", "position": "Big Blind", "stackSize": 100, "blinds": "1/2", "potSize": 20, "actionSoFar": "Button raises to 6, SB 3-bets to 18", "playersRemaining": 3, "effectiveStacks": 82}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 16"}, {"id": "C", "action": "Raise to 50"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'A',
  'AJ offsuit facing a 3-bet and the original raiser still to act is a clear fold. You''re likely dominated by better aces or facing big pairs. Even if you call, you''ll be out of position in a bloated pot. Fold and find a better spot.',
  ARRAY['squeeze defense', 'dominated hands', 'ICM']
),

(
  'pre-flop',
  'intermediate',
  '{"yourHand": "KTs", "position": "Button", "stackSize": 100, "blinds": "1/2", "potSize": 3, "actionSoFar": "Folds to you", "playersRemaining": 3, "effectiveStacks": 100}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 2"}, {"id": "C", "action": "Raise to 6"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'C',
  'KT suited is a strong button stealing hand with good playability. Raise to put pressure on the blinds and build a pot with your positional advantage. This hand can make strong draws and high pairs.',
  ARRAY['button stealing', 'suited cards', 'position']
),

(
  'pre-flop',
  'intermediate',
  '{"yourHand": "A9o", "position": "Cutoff", "stackSize": 100, "blinds": "1/2", "potSize": 11, "actionSoFar": "MP raises to 6, HJ calls", "playersRemaining": 6, "effectiveStacks": 94}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 6"}, {"id": "C", "action": "Raise to 22"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'A',
  'A9 offsuit in a multi-way pot is a trap hand. You can easily be dominated by better aces, and weak kickers play poorly against multiple opponents. Even from the cutoff with position, this is a fold. Wait for stronger hands or better spots.',
  ARRAY['weak kicker', 'multi-way', 'discipline']
),

(
  'pre-flop',
  'intermediate',
  '{"yourHand": "QQ", "position": "Button", "stackSize": 100, "blinds": "1/2", "potSize": 20, "actionSoFar": "UTG raises to 6, you 3-bet to 18, UTG 4-bets to 45", "playersRemaining": 3, "effectiveStacks": 55}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 27"}, {"id": "C", "action": "Raise to 100"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'D',
  'QQ facing a 4-bet from early position is strong enough to go all-in. While you might be behind KK+ or AK, you have good equity and need to realize it now. At these stack depths (55BB effective), calling creates an awkward SPR. Commit.',
  ARRAY['4-bet pots', 'stack commitment', 'premium pairs']
),

-- PRE-FLOP ADVANCED (20 questions)
(
  'pre-flop',
  'advanced',
  '{"yourHand": "A5s", "position": "Button", "stackSize": 100, "blinds": "1/2", "potSize": 20, "actionSoFar": "CO raises to 6, you 3-bet to 18, CO 4-bets to 45", "playersRemaining": 3, "effectiveStacks": 55}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 27"}, {"id": "C", "action": "Raise to 100"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'A',
  'A5 suited was a good 3-bet bluff with fold equity, but facing a 4-bet it''s time to fold. The CO''s 4-bet range is very strong (QQ+, AK typically). Your hand doesn''t have enough equity to continue, even with the suited wheel draw potential.',
  ARRAY['polarized 3-betting', '4-bet defense', 'range reading']
),

(
  'pre-flop',
  'advanced',
  '{"yourHand": "KK", "position": "Small Blind", "stackSize": 100, "blinds": "1/2", "potSize": 24, "actionSoFar": "Button raises to 6, you 3-bet to 20, Button 4-bets to 50", "playersRemaining": 3, "effectiveStacks": 50}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 30"}, {"id": "C", "action": "Raise to 100"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'D',
  'KK is strong enough to go all-in facing a 4-bet. While AA beats you, you have good equity against AK and are ahead of QQ-JJ. The button could be 4-betting lighter as a bluff. At 100BB stacks, getting it in with KK is standard.',
  ARRAY['4-bet pots', 'premium pairs', 'range advantage']
),

(
  'pre-flop',
  'advanced',
  '{"yourHand": "T9s", "position": "Cutoff", "stackSize": 100, "blinds": "1/2", "potSize": 9, "actionSoFar": "MP raises to 6, HJ calls", "playersRemaining": 6, "effectiveStacks": 94}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 6"}, {"id": "C", "action": "Raise to 22"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'C',
  'T9 suited is a premium squeezing hand. You can represent a strong range with a polarized 3-bet, and the hand has good playability when called. The raise isolates and puts maximum pressure on both opponents. This balances your value 3-bets.',
  ARRAY['squeeze play', 'polarized range', 'suited connectors']
),

(
  'pre-flop',
  'advanced',
  '{"yourHand": "JJ", "position": "Middle", "stackSize": 20, "blinds": "1/2", "potSize": 3, "actionSoFar": "UTG raises to 6", "playersRemaining": 7, "effectiveStacks": 14}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 6"}, {"id": "C", "action": "Raise to 12"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'D',
  'With only 20BB and a premium pair, go all-in. You can''t afford to call and play post-flop with such a shallow stack. Shoving has fold equity and realizes your equity immediately. JJ is strong enough to get in pre-flop at this stack depth.',
  ARRAY['short stack', 'push/fold', 'stack-to-pot ratio']
),

(
  'pre-flop',
  'advanced',
  '{"yourHand": "AQs", "position": "Big Blind", "stackSize": 100, "blinds": "1/2", "potSize": 26, "actionSoFar": "UTG raises to 6, MP calls, CO 3-bets to 22, SB folds", "playersRemaining": 4, "effectiveStacks": 78}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 20"}, {"id": "C", "action": "Raise to 65"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'A',
  'AQ suited looks strong but is in terrible shape here. The CO''s 3-bet over a raise and call represents extreme strength (QQ+, AK). You''re out of position facing a very strong range with two players still to act. Clear fold.',
  ARRAY['multi-way dynamics', 'range reading', 'position']
),

(
  'pre-flop',
  'advanced',
  '{"yourHand": "77", "position": "Button", "stackSize": 200, "blinds": "1/2", "potSize": 8, "actionSoFar": "MP raises to 6, HJ calls", "playersRemaining": 5, "effectiveStacks": 194}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 6"}, {"id": "C", "action": "Raise to 24"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'B',
  'With deep stacks (200BB) and position, pocket 77 has excellent implied odds to set mine. The deep stacks mean you can win a massive pot when you hit. Call and look to flop a set or fold to aggression on high boards.',
  ARRAY['deep stack', 'set mining', 'implied odds']
),

(
  'pre-flop',
  'advanced',
  '{"yourHand": "AKo", "position": "Cutoff", "stackSize": 100, "blinds": "1/2", "potSize": 20, "actionSoFar": "UTG raises to 6, MP calls, you 3-bet to 24, UTG folds, MP calls", "playersRemaining": 3, "effectiveStacks": 76}'::jsonb,
  'Flop comes 8-6-3 rainbow. MP checks. What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 15"}, {"id": "C", "action": "Bet 30"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'B',
  'As the pre-flop 3-bettor, continuation bet this dry board. A smaller bet (about 60% pot) is efficient - it achieves your goals without risking too much. The MP flatted your 3-bet indicating a capped range. Apply pressure with your range advantage.',
  ARRAY['c-betting', 'range advantage', '3-bet pots']
),

(
  'pre-flop',
  'advanced',
  '{"yourHand": "Q9s", "position": "Small Blind", "stackSize": 100, "blinds": "1/2", "potSize": 8, "actionSoFar": "Button raises to 6", "playersRemaining": 3, "effectiveStacks": 94}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 5"}, {"id": "C", "action": "Raise to 20"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'C',
  'Q9 suited can be a profitable 3-bet bluff from the small blind against a button steal. This polarizes your range and puts pressure on a wide button opening range. The hand has playability when called. Mix this into your 3-betting range for balance.',
  ARRAY['3-bet bluffing', 'blind vs button', 'polarization']
),

(
  'pre-flop',
  'advanced',
  '{"yourHand": "AKs", "position": "Button", "stackSize": 100, "blinds": "1/2", "potSize": 28, "actionSoFar": "UTG raises to 6, you 3-bet to 18, UTG 4-bets to 45, you call", "playersRemaining": 3, "effectiveStacks": 55}'::jsonb,
  'Flop comes J-T-4 rainbow. UTG bets 30. What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 30"}, {"id": "C", "action": "Raise to 55 (all-in)"}, {"id": "D", "action": "Raise to 75"}]'::jsonb,
  'C',
  'You have a gutshot to the nuts and two overcards (14 outs twice). Against the UTG 4-bettor''s range, you have significant equity. The pot is huge (75 chips) and you only have 55 left. Go all-in for fold equity plus equity when called.',
  ARRAY['semi-bluff shove', 'pot commitment', 'equity realization']
),

(
  'pre-flop',
  'advanced',
  '{"yourHand": "K7s", "position": "Big Blind", "stackSize": 100, "blinds": "1/2", "potSize": 9, "actionSoFar": "Button raises to 6, SB folds", "playersRemaining": 2, "effectiveStacks": 94}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 4"}, {"id": "C", "action": "Raise to 18"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'C',
  'K7 suited can be a profitable 3-bet bluff against a button steal. The button is raising wide, and you can represent a strong range. This prevents you from being exploited in your big blind. Mix in some bluff 3-bets for balance.',
  ARRAY['3-bet bluffing', 'big blind defense', 'exploitative play']
),

(
  'pre-flop',
  'advanced',
  '{"yourHand": "TT", "position": "Cutoff", "stackSize": 100, "blinds": "1/2", "potSize": 8, "actionSoFar": "MP raises to 6, HJ calls", "playersRemaining": 6, "effectiveStacks": 94}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 6"}, {"id": "C", "action": "Raise to 24"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'C',
  'TT is strong enough to 3-bet in this spot. You can get value from weaker pairs and broadway cards, while also applying pressure. This play is more profitable than flatting in a 3-way pot. Balance your range with both value and bluffs.',
  ARRAY['iso-raising', 'value 3-betting', 'medium pairs']
),

(
  'pre-flop',
  'advanced',
  '{"yourHand": "A2s", "position": "Button", "stackSize": 100, "blinds": "1/2", "potSize": 3, "actionSoFar": "Folds to you", "playersRemaining": 3, "effectiveStacks": 100}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 2"}, {"id": "C", "action": "Raise to 6"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'C',
  'A2 suited from the button is a profitable steal with wheel potential and the nut flush draw. Raise to put pressure on the blinds. This hand plays well post-flop with both high card and low straight potential. Never limp from the button.',
  ARRAY['button stealing', 'wheel cards', 'aggression']
),

(
  'pre-flop',
  'advanced',
  '{"yourHand": "99", "position": "Big Blind", "stackSize": 100, "blinds": "1/2", "potSize": 26, "actionSoFar": "CO raises to 6, Button 3-bets to 18, SB folds", "playersRemaining": 3, "effectiveStacks": 82}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 16"}, {"id": "C", "action": "Raise to 55"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'A',
  'Pocket 99 facing a 3-bet with the original raiser still to act is in rough shape. You''re likely behind the 3-bettor''s range and could face a 4-bet. Even if you call, you''ll be out of position in a bloated pot. Fold and preserve your stack.',
  ARRAY['squeeze defense', 'pocket pairs', 'ICM pressure']
),

(
  'pre-flop',
  'advanced',
  '{"yourHand": "AJs", "position": "Middle", "stackSize": 100, "blinds": "1/2", "potSize": 20, "actionSoFar": "UTG raises to 6, you 3-bet to 18, UTG calls", "playersRemaining": 3, "effectiveStacks": 82}'::jsonb,
  'Flop comes A-9-3 rainbow. UTG checks. What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 12"}, {"id": "C", "action": "Bet 24"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'B',
  'You have top pair good kicker on a dry ace-high board. Bet about 60% pot for value and protection. This board hits your 3-betting range hard. A smaller bet allows you to get value from worse aces and apply pressure to unpaired hands.',
  ARRAY['c-betting paired boards', 'range advantage', 'value betting']
),

(
  'pre-flop',
  'advanced',
  '{"yourHand": "87s", "position": "Button", "stackSize": 100, "blinds": "1/2", "potSize": 11, "actionSoFar": "MP raises to 6, CO calls", "playersRemaining": 5, "effectiveStacks": 94}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 6"}, {"id": "C", "action": "Raise to 24"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'B',
  '87 suited with position in a multi-way pot has good implied odds. Call and look to make strong draws or two pair+ hands. The hand is too weak to 3-bet but has enough playability and implied odds to call with position.',
  ARRAY['suited connectors', 'implied odds', 'multi-way']
),

(
  'pre-flop',
  'advanced',
  '{"yourHand": "AQo", "position": "Small Blind", "stackSize": 15, "blinds": "1/2", "potSize": 8, "actionSoFar": "Button raises to 6", "playersRemaining": 3, "effectiveStacks": 9}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 5"}, {"id": "C", "action": "Raise to 12"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'D',
  'With 15BB and AQ facing a button steal, go all-in. You have a strong hand and can''t afford to call and play post-flop with such a shallow stack. Shoving has fold equity and realizes your equity. This is a clear shove in push/fold territory.',
  ARRAY['short stack', 'push/fold', 'blind defense']
),

(
  'pre-flop',
  'advanced',
  '{"yourHand": "K5s", "position": "Cutoff", "stackSize": 100, "blinds": "1/2", "potSize": 9, "actionSoFar": "MP raises to 6, HJ calls", "playersRemaining": 6, "effectiveStacks": 94}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 6"}, {"id": "C", "action": "Raise to 22"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'A',
  'K5 suited is too weak to continue in a 3-way pot, even with position. You need stronger hands to profitably play multi-way. The weak kicker and lack of connectivity make this a fold. Save your chips for better spots with stronger hands.',
  ARRAY['hand selection', 'weak kickers', 'multi-way']
),

(
  'pre-flop',
  'advanced',
  '{"yourHand": "JJ", "position": "Button", "stackSize": 100, "blinds": "1/2", "potSize": 20, "actionSoFar": "UTG raises to 6, you 3-bet to 18, UTG calls", "playersRemaining": 3, "effectiveStacks": 82}'::jsonb,
  'Flop comes K-Q-5 rainbow. UTG checks. What is the best action?',
  '[{"id": "A", "action": "Check"}, {"id": "B", "action": "Bet 12"}, {"id": "C", "action": "Bet 24"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'A',
  'Two overcards on this board significantly weakens your hand. Checking back allows you to control the pot size and see the turn. UTG could easily have a king or queen. Check and reassess on the turn - you can still call moderate bets with JJ.',
  ARRAY['pot control', 'way ahead/way behind', 'board texture']
),

(
  'pre-flop',
  'advanced',
  '{"yourHand": "ATs", "position": "Big Blind", "stackSize": 100, "blinds": "1/2", "potSize": 14, "actionSoFar": "Cutoff raises to 6, Button calls, SB folds", "playersRemaining": 3, "effectiveStacks": 94}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 4"}, {"id": "C", "action": "Raise to 22"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'B',
  'AT suited getting excellent pot odds (4 to win 14) from the big blind is an easy call. You''re closing the action and the hand has good playability with flush potential, straight potential, and can make top pair. Don''t 3-bet in a 3-way pot OOP.',
  ARRAY['pot odds', 'big blind defense', 'playability']
),

(
  'pre-flop',
  'advanced',
  '{"yourHand": "66", "position": "Middle", "stackSize": 100, "blinds": "1/2", "potSize": 20, "actionSoFar": "UTG raises to 6, you call, CO 3-bets to 22, UTG folds", "playersRemaining": 4, "effectiveStacks": 78}'::jsonb,
  'What is the best action?',
  '[{"id": "A", "action": "Fold"}, {"id": "B", "action": "Call 16"}, {"id": "C", "action": "Raise to 60"}, {"id": "D", "action": "All-in"}]'::jsonb,
  'A',
  'Facing a squeeze 3-bet with pocket sixes, fold. The stack-to-pot ratio isn''t favorable for set mining (you''re not deep enough), and you''re out of position against a strong range. You already invested 6 chips, but don''t throw good money after bad.',
  ARRAY['squeeze defense', 'small pairs', 'sunk cost']
);

-- Continue in next message due to length...
