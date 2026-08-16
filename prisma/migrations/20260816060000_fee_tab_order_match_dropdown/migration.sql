-- Order the programme tabs on /admission/tuition-fees to match the
-- Program dropdown: Undergraduate first, then the Graduate programmes in
-- the same sequence the nav shows them.
--
-- The page sorts by program_fee_structure.displayOrder, but eight of the
-- nine rows were all left at 0, so their order was whatever Postgres
-- happened to return — stable-looking in practice, never guaranteed, and
-- not matching the dropdown. Each row now gets an explicit rank.
--
-- Target order (BBA heads the row as the sole undergraduate programme,
-- mirroring "Undergraduate" sitting above "Graduate" in the dropdown):
--   0 BBA       Bachelor of Business Administration
--   1 EMBA      Executive Master of Business Administration
--   2 MAM       MBA in Apparel Merchandising
--   3 MAMS      MBA in Apparel Merchandising (1 year)
--   4 MBA-SCM   MBA in Supply Chain Management
--   5 MBA-TFM   MBA in Textile & Fashion Marketing
--   6 MBM       Masters in Bank Management
--   7 MBA       Master of Business Administration
--   8 MBA-REG   Regular Master of Business Administration
--
-- Keyed off degreeCode via a join rather than hardcoded row ids, so the
-- statement stays readable and survives differing ids across environments.

UPDATE "program_fee_structure" fs
SET "displayOrder" = v."rank"
FROM (VALUES
  ('BBA',     0),
  ('EMBA',    1),
  ('MAM',     2),
  ('MAMS',    3),
  ('MBA-SCM', 4),
  ('MBA-TFM', 5),
  ('MBM',     6),
  ('MBA',     7),
  ('MBA-REG', 8)
) AS v("code", "rank")
JOIN "program" p ON p."degreeCode" = v."code"
WHERE fs."programId" = p."id";
