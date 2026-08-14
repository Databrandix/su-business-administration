-- Second occurrence of registrar@su.edu.bd on the Contact page.
--
-- 20260812330000 cleared it from the "E-mail" quick-contact card, but the
-- Green Road Campus location card carries its own email column and was
-- still publishing the same address further down the page.
--
-- Replaced rather than nulled: campus_location.email is NOT NULL and the
-- contact page renders the line unconditionally, so the column needs a
-- real address. info@su.edu.bd is what the other two campuses already
-- use, which keeps the three cards consistent.
UPDATE "campus_location"
SET "email"     = 'info@su.edu.bd',
    "updatedAt" = NOW()
WHERE "email" ILIKE '%registrar@su.edu.bd%';
