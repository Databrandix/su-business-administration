-- Rename the 2-year apparel programme's degree code from "MBA-AM" to
-- "MAM", so the programme tab on /admission/tuition-fees reads "MAM" and
-- matches the "(MAM)" now shown in its name and in the nav dropdown.
--
-- degreeCode is @unique but is not referenced by literal value anywhere in
-- the application — no lookup, route, or conditional keys off "MBA-AM"
-- (only a code comment mentioned it, updated separately). Fee structures
-- join on programId, not on the code, so the tuition page keeps working.
--
-- "MAM" is free: the 1-year programme uses "MAMS", and the syllabus PDF's
-- own course codes use the MAM prefix (MAM 5002, MAM 1200), so this brings
-- the stored code in line with the document.
--
-- Side effect, intentional: with the code now contained in the programme's
-- name, the search index stops appending it to the description — that
-- suffix exists only for programmes whose name carries a different code.

UPDATE "program"
SET "degreeCode" = 'MAM'
WHERE "degreeCode" = 'MBA-AM';
