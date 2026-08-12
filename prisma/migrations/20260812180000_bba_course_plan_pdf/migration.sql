-- Attach the BBA course plan so the download card under Credit
-- Distribution actually renders. Served from public/assets rather than
-- Cloudinary because the file ships with the repo; the admin uploader
-- overwrites these columns with a Cloudinary URL when a file is
-- uploaded there instead.
UPDATE "program"
SET "coursePlanPdfUrl"      = '/assets/bba-course-structure.pdf',
    "coursePlanPdfFileName" = 'bba-course-structure.pdf',
    "updatedAt"             = NOW()
WHERE "slug" = 'bba';
