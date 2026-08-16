-- Syllabus entry for MAMS (1-year MBA in Apparel Merchandising), so the
-- Syllabus section lists it alongside the 2-year programme. Added now
-- rather than later because the Syllabus nav item is only temporarily
-- disabled — without this the page would come back missing MAMS.
--
-- Ordered immediately after the 2-year MBA in Apparel Merchandising
-- (displayOrder 4) so the two apparel syllabi sit together; later rows
-- shift down by one.
--
-- pdfUrl points at the local /assets copy already shipped for the
-- programme page's Download button, rather than a Cloudinary upload. The
-- card renders it as a plain href, so a local path behaves identically.
-- pdfPublicId stays NULL: there is no Cloudinary asset to reference.
--
-- coverUrl is left NULL deliberately — the card falls back to its
-- placeholder, which is the documented behaviour for a syllabus without
-- artwork. An admin can upload a cover later without a migration.

UPDATE "syllabus"
SET "displayOrder" = "displayOrder" + 1
WHERE "displayOrder" > 4;

INSERT INTO "syllabus" (
  "id", "slug", "title", "shortTitle", "department", "level",
  "pdfUrl", "pdfPublicId", "pdfFileName",
  "summary", "coverUrl", "coverPublicId",
  "displayOrder", "createdAt", "updatedAt"
)
VALUES (
  'cmamssyllabus00000000001',
  'mba-apparel-merchandising-mams',
  'MBA in Apparel Merchandising (MAMS)',
  'MBA in Apparel Merchandising (MAMS)',
  'Business Administration',
  'Postgraduate',
  '/assets/mams-course-structure.pdf',
  NULL,
  'mams-course-structure.pdf',
  'Course-by-course syllabus for the 1-year MBA in Apparel Merchandising (MAMS) programme (1 Year · 2 Semesters), for FDT, AMT, KMT and TE graduates.',
  NULL,
  NULL,
  5,
  NOW(), NOW()
)
ON CONFLICT ("slug") DO NOTHING;
