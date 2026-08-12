-- href becomes nullable: an item that only heads its flyout has no
-- destination of its own.
ALTER TABLE "main_nav_item" ALTER COLUMN "href" DROP NOT NULL;

-- "Undergraduate" and "Graduate" in the Program menu head the lists of
-- degrees beneath them; they are not destinations. Both pointed at
-- /programs, so clicking a heading navigated away instead of letting the
-- user pick a degree from the flyout. Clearing href renders them as plain
-- headings (Navbar treats a childed item with no href as non-clickable).
UPDATE "main_nav_item"
SET "href" = NULL,
    "updatedAt" = NOW()
WHERE "name" IN ('Undergraduate', 'Graduate', 'Postgraduate')
  AND "parentId" IS NULL
  AND EXISTS (
      SELECT 1 FROM "main_nav_item" AS child
      WHERE child."parentId" = "main_nav_item"."id"
  );
