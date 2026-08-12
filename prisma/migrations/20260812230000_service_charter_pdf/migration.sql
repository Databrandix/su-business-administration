-- Attach the Service Charter PDF so the download card at the bottom of
-- /student-society/service-charter renders. Served from public/assets
-- because the file ships with the repo; uploading one from the admin
-- panel overwrites these columns with a Cloudinary URL instead.
UPDATE "service_charter_meta"
SET "pdfUrl"      = '/assets/service-charter.pdf',
    "pdfFileName" = 'service-charter.pdf',
    "updatedAt"   = NOW()
WHERE "id" = 'singleton';
