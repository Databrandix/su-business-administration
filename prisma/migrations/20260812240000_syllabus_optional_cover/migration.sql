-- Re-introduce syllabus cover artwork, this time nullable.
--
-- 20260806080000_syllabus_drop_cover removed these columns because the
-- cover was REQUIRED, which blocked admins from saving a syllabus PDF
-- before artwork existed. Optional columns avoid that: the public card
-- renders a placeholder until a cover is uploaded.
ALTER TABLE "syllabus"
    ADD COLUMN "coverUrl"      TEXT,
    ADD COLUMN "coverPublicId" TEXT;
