-- Rename the 2-year programme "MBA in Apparel Merchandising" to
-- "MBA in Apparel Merchandising (MAM)".
--
-- With the 1-year "(MAMS)" programme now listed directly beneath it, the
-- unsuffixed name read as the generic parent of the two rather than as a
-- distinct degree. Adding its own code makes the pair legible at a glance
-- in the nav dropdown, and matches how the other programmes are already
-- written ("Masters in Bank Management (MBM)").
--
-- The name is stored in three places, all updated together so the site
-- cannot show two different names for the same programme:
--   program.programName    — hero, cards, page title, search
--   main_nav_item.name     — Program › Graduate dropdown
--   syllabus.title/shortTitle — Syllabus section listing
--
-- Slug, degreeCode and every href are deliberately untouched: this is a
-- display-name change only, so existing links and bookmarks keep working.
--
-- Guarded on the exact old string so re-running cannot produce
-- "… (MAM) (MAM)", and so a later CMS edit is not silently reverted.

UPDATE "program"
SET "programName" = 'MBA in Apparel Merchandising (MAM)'
WHERE "degreeCode" = 'MBA-AM'
  AND "programName" = 'MBA in Apparel Merchandising';

UPDATE "main_nav_item"
SET "name" = 'MBA in Apparel Merchandising (MAM)'
WHERE "href" = '/programs/mba-apparel-merchandising'
  AND "name" = 'MBA in Apparel Merchandising';

UPDATE "syllabus"
SET "title"      = 'MBA in Apparel Merchandising (MAM)',
    "shortTitle" = 'MBA in Apparel Merchandising (MAM)'
WHERE "slug" = 'mba-apparel-merchandising'
  AND "title" = 'MBA in Apparel Merchandising';
