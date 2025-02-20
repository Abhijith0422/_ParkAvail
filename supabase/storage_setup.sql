-- Create bucket if not exists
INSERT INTO storage.buckets (id, name, public)
VALUES ('userimages', 'userimages', false)
ON CONFLICT (id) DO NOTHING;

-- Reset and create storage policies
DROP POLICY IF EXISTS "Give users access to own folder" ON storage.objects;

CREATE POLICY "Give users access to own folder"
ON storage.objects
FOR ALL USING (
    bucket_id = 'userimages' 
    AND auth.role() = 'authenticated'
    AND (storage.foldername(name))[1] = auth.uid()::text
);
