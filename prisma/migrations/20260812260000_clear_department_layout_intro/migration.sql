-- Drop the intro line on /about/department-layout. It was seeded from the
-- Layout Plan document ("…follows this Service Charter."), but the charter
-- is now its own page under Student Society, so the sentence points away
-- from what this page is for. The office table needs no preamble.
UPDATE "about_department_layout"
SET "paragraphs" = '[]'::jsonb,
    "updatedAt"  = NOW()
WHERE "id" = 'singleton';
