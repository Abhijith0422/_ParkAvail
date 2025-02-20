-- Reset existing policies
DROP POLICY IF EXISTS "Allow individual user access" ON storage.objects;

-- Enable RLS
ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

-- Create policy for user folder access
CREATE POLICY "Allow individual user access" ON storage.objects
FOR ALL USING (
  -- Check if the path starts with 'profile_' followed by the user's ID
  bucket_id = 'userimages' AND 
  (storage.foldername(name))[1] = 'profile_' || auth.uid()
)
WITH CHECK (
  bucket_id = 'userimages' AND 
  (storage.foldername(name))[1] = 'profile_' || auth.uid()
);
