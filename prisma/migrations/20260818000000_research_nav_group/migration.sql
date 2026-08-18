-- "Research" main-nav entry, between "Program" and "Faculty Member".
--
-- /research already exists (src/app/(public)/research/page.tsx, listing
-- research_paper rows); it simply had no way in from the nav bar.
--
-- A plain link, not a dropdown: hasDropdown=false with href set, matching
-- the "Faculty Member" and "Contact" entries. title/items stay empty —
-- the Navbar only reads those when hasDropdown is true.
--
-- Ordering: the group sits at displayOrder 2, so "Faculty Member" and
-- everything after it shift up by one. chrome-nav.ts's reorder action
-- rewrites this column as a dense 0..n-1 range, so the sequence is kept
-- contiguous here rather than leaving a gap for the new row.
--
--   0 About            (unchanged)
--   1 Program          (unchanged)
--   2 Research         (new)
--   3 Faculty Member   (was 2)
--   4 Admission        (was 3)
--   5 Student Society  (was 4)
--   6 Contact          (was 5)

-- Shift first, so the vacated slot 2 is free before the insert. Bare
-- ">= 2" would also catch a row added after this was written; matching on
-- the known names keeps the change to the six rows described above.
UPDATE "main_nav_group"
SET "displayOrder" = "displayOrder" + 1, "updatedAt" = NOW()
WHERE "name" IN ('Faculty Member', 'Admission', 'Student Society', 'Contact');

INSERT INTO "main_nav_group"
  ("id", "name", "href", "hasDropdown", "title", "displayOrder", "createdAt", "updatedAt")
VALUES
  ('nav_group_research', 'Research', '/research', false, NULL, 2, NOW(), NOW())
ON CONFLICT ("id") DO NOTHING;
