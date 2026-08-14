-- Temporarily take the Syllabus page out of service.
--
-- isDisabled is the existing mechanism for this (Virtual Tour and Archive
-- in the top bar already use it): the Navbar renders a disabled item as
-- greyed, non-clickable text with aria-disabled, and href is cleared so
-- nothing links to the route.
--
-- To turn it back on: /admin/chrome-nav, untick "Disabled" on the
-- Syllabus item and restore href to /student-society/syllabus. No code
-- change or migration needed.
UPDATE "main_nav_item"
SET "isDisabled" = true,
    "href"       = NULL,
    "updatedAt"  = NOW()
WHERE "name" = 'Syllabus'
  AND "groupId" IN (SELECT "id" FROM "main_nav_group" WHERE "name" = 'Student Society');
