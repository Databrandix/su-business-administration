-- Drop the second overview paragraph on MAMS, leaving only the opening
-- one. The removed text was written for the seed rather than taken from
-- the source syllabus, and it asserted an "eight-week industrial
-- attachment" — a duration carried over from the 2-year MBA-AM. The MAMS
-- document lists MAM 1202 Industrial Attachment with no duration stated,
-- so the claim was unsupported.
--
-- Written as a slice rather than a literal so it is idempotent and cannot
-- clobber a paragraph an admin has since edited through the CMS.

UPDATE "program"
SET "overviewParagraphs" = jsonb_build_array("overviewParagraphs" -> 0)
WHERE "degreeCode" = 'MAMS'
  AND jsonb_array_length("overviewParagraphs") > 1;
