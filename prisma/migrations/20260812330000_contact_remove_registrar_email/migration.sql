-- Remove registrar@su.edu.bd from the Contact page.
--
-- It sat as the SECONDARY value on the "E-mail" quick-contact card;
-- admission.info@su.edu.bd is the primary and stays. Only the secondary
-- pair is cleared, so the card keeps its title, icon and primary address.
UPDATE "contact_page_content"
SET "quickContactCards" = (
      SELECT jsonb_agg(
               CASE
                 WHEN card->>'secondaryValue' ILIKE '%registrar@su.edu.bd%'
                   OR card->>'secondaryHref'  ILIKE '%registrar@su.edu.bd%'
                 THEN card
                        || jsonb_build_object('secondaryValue', 'null'::jsonb)
                        || jsonb_build_object('secondaryHref',  'null'::jsonb)
                 ELSE card
               END
               ORDER BY idx
             )
      FROM jsonb_array_elements("quickContactCards") WITH ORDINALITY AS t(card, idx)
    ),
    "updatedAt" = NOW()
WHERE "id" = 'singleton'
  AND jsonb_typeof("quickContactCards") = 'array';
