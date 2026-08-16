-- Order programmes to match the Program dropdown.
--
-- The preceding migration ranked program_fee_structure.displayOrder, but
-- /admission/tuition-fees builds its tabs by mapping over the programme
-- list and only looking up the matching fee structure for each panel — so
-- the tab order comes from program.displayOrder, not from the fee table.
-- That earlier ranking is still worth keeping (the rows were all 0, giving
-- the fee query an arbitrary order), but it is this column that drives the
-- visible sequence.
--
-- Target order, mirroring the dropdown — Undergraduate first, then the
-- Graduate programmes in nav sequence:
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
-- program.displayOrder also drives the homepage programme cards, which
-- pick up the same nav-consistent sequence.

UPDATE "program" p
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
WHERE p."degreeCode" = v."code";
