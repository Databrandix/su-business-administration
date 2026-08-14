-- Update the BBA STAR (Friday) shift fees to the Fall-2026 sheet.
--
-- Only the STAR entry of `shifts` is rewritten; the SUN (Morning) entry
-- is left byte-for-byte as it was, since the sheet's SUN column already
-- matches what is stored.
--
-- Waivers and per-credit fees changed on three of the four tiers:
--   5.00–8.99   42% / 1740 / 329840  ->  40% / 1800 / 338300
--   9.00–9.99   45% / 1650 / 317150  ->  43% / 1710 / 325610
--   10.00       47% / 1590 / 308690  ->  45% / 1650 / 317150
-- The 0% tier (3000 / 507500) was already correct.
--
-- Each total reconciles with the sheet's own inputs:
--   admission 12,500 + (perCredit x 141 credits) + semester 72,000.
UPDATE "program_fee_structure" fs
SET "shifts" = (
      SELECT jsonb_agg(
               CASE
                 WHEN shift->>'name' = 'STAR' THEN jsonb_set(
                   shift,
                   '{groups}',
                   '[
                      {
                        "background": "SSC + HSC",
                        "tiers": [
                          {"gpa": "Below 5.00", "waiver": "0%",  "credits": 141, "perCredit": 3000, "total": 507500},
                          {"gpa": "5.00–8.99",  "waiver": "40%", "credits": 141, "perCredit": 1800, "total": 338300},
                          {"gpa": "9.00–9.99",  "waiver": "43%", "credits": 141, "perCredit": 1710, "total": 325610},
                          {"gpa": "10.00",      "waiver": "45%", "credits": 141, "perCredit": 1650, "total": 317150}
                        ]
                      }
                    ]'::jsonb
                 )
                 ELSE shift
               END
               ORDER BY idx
             )
      FROM jsonb_array_elements(fs."shifts") WITH ORDINALITY AS t(shift, idx)
    ),
    "updatedAt" = NOW()
FROM "program" p
WHERE fs."programId" = p."id"
  AND p."slug" = 'bba'
  AND jsonb_typeof(fs."shifts") = 'array';
