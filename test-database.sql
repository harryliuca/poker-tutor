-- Quick test to verify tables were created successfully
-- Run this in Supabase SQL Editor

-- Check if all tables exist
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY table_name;

-- Check sample question
SELECT * FROM public.questions LIMIT 1;