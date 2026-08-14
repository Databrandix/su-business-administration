-- Drop the sub-line under each shift heading on /admission/tuition-fees
-- ("Admission fee BDT 12,500 · Semester fee BDT 96,000. Open to both…").
--
-- It restated the admission and semester fees already shown in the At a
-- Glance cards above, and the eligibility half is carried by the per-group
-- "SSC + HSC" / "Diploma" table headings beneath it.
--
-- The description key is emptied rather than removed: the public page
-- already renders it conditionally, so "" hides the line, and the field
-- stays in the admin editor for any shift that later needs a genuine note.
UPDATE "program_fee_structure"
SET "shifts" = (
      SELECT jsonb_agg(
               jsonb_set(shift, '{description}', '""'::jsonb)
               ORDER BY idx
             )
      FROM jsonb_array_elements("shifts") WITH ORDINALITY AS t(shift, idx)
    ),
    "updatedAt" = NOW()
WHERE jsonb_typeof("shifts") = 'array'
  AND jsonb_array_length("shifts") > 0;
