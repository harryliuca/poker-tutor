-- Fix Row Level Security for daily_challenges table
-- Run this in Supabase SQL Editor

-- Allow authenticated users to insert daily challenges
CREATE POLICY "Authenticated users can create daily challenges" ON public.daily_challenges
  FOR INSERT
  WITH CHECK (auth.role() = 'authenticated');

-- Verify policies
SELECT schemaname, tablename, policyname, permissive, roles, cmd, qual, with_check
FROM pg_policies
WHERE tablename = 'daily_challenges';