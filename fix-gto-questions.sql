-- GTO Question Corrections
-- Run this in Supabase SQL Editor to fix the 3 critical poker strategy errors

-- ============================================
-- FIX #1: 33 Set Mining Math Error
-- ============================================
-- Problem: Incorrectly says to FOLD with 50BB, but implied odds are actually good enough
-- Correct Answer: CALL (not FOLD)

UPDATE public.questions
SET
  correct_answer = 'B',
  explanation = 'With 50BB effective stacks and position, pocket 33 has marginal but acceptable implied odds for set mining. You''re calling 6 to potentially win 44 more (50-6). You hit a set about 12% of the time and can stack opponents when you hit. The position helps you realize your equity. This is a profitable call.',
  key_concepts = ARRAY['set mining', 'implied odds', 'position']
WHERE
  scenario->>'yourHand' = '33'
  AND scenario->>'position' = 'Button'
  AND (scenario->>'stackSize')::int = 50
  AND category = 'pre-flop'
  AND difficulty = 'intermediate';

-- ============================================
-- FIX #2: K7s Big Blind 3-Bet Bluff Error
-- ============================================
-- Problem: Recommends 3-betting K7s from BB vs Button, but this is suboptimal
-- K7s has poor playability OOP and better as a call
-- Correct Answer: CALL (not 3-BET)

UPDATE public.questions
SET
  correct_answer = 'B',
  explanation = 'K7 suited gets good pot odds (4 to win 9) from the big blind against a button steal. Call to see a flop cheaply in position. While 3-bet bluffing is part of a balanced strategy, K7s has poor playability out of position when called. Better 3-bet bluff candidates are suited wheel aces (A2s-A5s) or suited connectors. Calling here is more profitable.',
  key_concepts = ARRAY['big blind defense', 'pot odds', 'playability']
WHERE
  scenario->>'yourHand' = 'K7s'
  AND scenario->>'position' = 'Big Blind'
  AND question_text LIKE '%Button raises to 6%'
  AND category = 'pre-flop';

-- ============================================
-- FIX #3: River Triple Barrel with Missed Draw
-- ============================================
-- Problem: Recommends bluffing river after missing flush draw and betting flop + turn
-- This is too aggressive - should give up
-- Correct Answer: CHECK (not BET)

UPDATE public.questions
SET
  correct_answer = 'A',
  explanation = 'You missed your flush draw after betting flop and turn. The BB called both streets showing strength. Give up the bluff and check - your ace-high might have showdown value. Triple barreling here with complete air is too aggressive. The BB''s calling range is too strong, and you represent no hands that improved on this brick river. Not every draw needs to be triple-barreled.',
  key_concepts = ARRAY['giving up bluffs', 'showdown value', 'river decisions']
WHERE
  scenario->>'yourHand' LIKE '%Q♠%'
  AND scenario->>'communityCards' LIKE '%K♠ 9♠ 3♥ 2♦ 6♣%'
  AND category = 'river'
  AND difficulty = 'advanced'
  AND question_text LIKE '%You bet the flop%turn%';

-- ============================================
-- Verification Queries
-- ============================================

-- Check Fix #1 (33 set mining)
SELECT
  scenario->>'yourHand' as hand,
  correct_answer,
  LEFT(explanation, 100) as explanation_preview
FROM questions
WHERE scenario->>'yourHand' = '33'
  AND scenario->>'position' = 'Button'
  AND category = 'pre-flop';

-- Check Fix #2 (K7s)
SELECT
  scenario->>'yourHand' as hand,
  correct_answer,
  LEFT(explanation, 100) as explanation_preview
FROM questions
WHERE scenario->>'yourHand' = 'K7s'
  AND scenario->>'position' = 'Big Blind'
  AND category = 'pre-flop';

-- Check Fix #3 (Missed flush)
SELECT
  scenario->>'yourHand' as hand,
  scenario->>'communityCards' as board,
  correct_answer,
  LEFT(explanation, 100) as explanation_preview
FROM questions
WHERE category = 'river'
  AND scenario->>'communityCards' LIKE '%K♠ 9♠%6♣%';

-- ============================================
-- Summary
-- ============================================
-- 3 questions fixed:
-- 1. 33 set mining: FOLD → CALL (correct implied odds math)
-- 2. K7s 3-bet: RAISE → CALL (better playability)
-- 3. River bluff: BET → CHECK (give up missed draw)
--
-- After running this, re-export questions if needed for documentation
