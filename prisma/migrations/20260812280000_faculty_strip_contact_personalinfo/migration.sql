-- Remove the phone numbers duplicated inside Faculty.personalInfo.
--
-- 20260812270000 dropped the `phone` column, but the same 10 numbers were
-- also stored as {"label":"Contact","value":"+8801…"} entries in the
-- personalInfo JSON list, which the public profile renders — so the
-- numbers were still on the site after the column went.
--
-- Filters out any personalInfo entry whose label looks like a phone field
-- (Contact / Phone / Mobile / Cell), leaving every other entry in place
-- and preserving their order.
--
-- DESTRUCTIVE: those entries are not recoverable from the database.
UPDATE "faculty" f
SET "personalInfo" = COALESCE(
      (
        SELECT jsonb_agg(entry ORDER BY idx)
        FROM jsonb_array_elements(f."personalInfo") WITH ORDINALITY AS t(entry, idx)
        WHERE COALESCE(entry->>'label', '') !~* '(contact|phone|mobile|cell)'
      ),
      '[]'::jsonb
    )
WHERE jsonb_typeof(f."personalInfo") = 'array'
  AND EXISTS (
      SELECT 1
      FROM jsonb_array_elements(f."personalInfo") AS e(entry)
      WHERE COALESCE(entry->>'label', '') ~* '(contact|phone|mobile|cell)'
  );
