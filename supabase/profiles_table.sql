-- Drop existing table and policies
DROP TABLE IF EXISTS profiles CASCADE;

-- Create profiles table with TEXT id
CREATE TABLE profiles (
    id TEXT PRIMARY KEY,
    email TEXT,
    avatar_url TEXT,
    avatar_path TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW())
);

-- Enable RLS
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;

-- Create policy for profiles
CREATE POLICY "Users can view and update their own profile"
ON profiles
FOR ALL
USING (auth.uid()::text = id)
WITH CHECK (auth.uid()::text = id);
