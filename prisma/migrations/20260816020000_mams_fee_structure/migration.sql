-- Fee structure for MAMS (1-year MBA in Apparel Merchandising), from the
-- Postgraduate (Master's Programs) Bi-Semester rate sheet effective
-- 24 April 2026, row 3.
--
-- Source figures: 36 credits · 1 Year · BDT 2,000 per credit · 41% waiver
-- · BDT 1,180 after-waiver per credit · BDT 12,000 semester fee ·
-- BDT 12,500 admission fee · BDT 66,980 total · BDT 56,980 for SU
-- graduates (BDT 6,000 semester fee, admission fee 9,500 + 1,000 tuition).
--
-- Arithmetic reconciles against the sheet, and the same checks pass on the
-- MTFM/MAM/LLM rows, which corroborates the column reading:
--   after-waiver per credit  2000 x (1 - 0.41)       = 1,180  ✓
--   tuition                  1180 x 36               = 42,480
--   total                    42,480 + 12,000 + 12,500 = 66,980 ✓
--   SU graduates             42,480 + 6,000 + 10,500  = 58,980
--                            less the BDT 2,000 SU concession = 56,980 ✓
-- The 2,000 concession holds on all four rows of the sheet and matches the
-- concession already described in the sibling programs' policy text.
--
-- Creating this row also turns on the "At a Glance" block on
-- /programs/mba-apparel-merchandising-mams: that section renders from
-- feeStructure.overviewStats and stays hidden while no fee row exists.
--
-- Shift/intro/policy copy is kept identical in shape to MBA-AM so the two
-- apparel programs read consistently on /admission/tuition-fees; only the
-- figures and the credit count differ. displayOrder 8 matches the
-- program's own displayOrder, placing MAMS last.

INSERT INTO "program_fee_structure" (
  "id", "programId",
  "introOverline", "introHeading", "introBody",
  "overviewStats", "shifts", "policies",
  "displayOrder", "createdAt", "updatedAt"
)
SELECT
  'cmamsfeestructure00000001',
  p."id",
  '',
  'Tuition Fee Structure',
  'The total program cost combines tuition, the admission fee, and the semester fee. Graduates of Sonargaon University pay a reduced rate.',
  '[
    {"label": "Total Credits",   "value": "36",          "iconName": "GraduationCap"},
    {"label": "Semester System", "value": "Bi-Semester", "iconName": "Calendar"},
    {"label": "Admission Fee",   "value": "BDT 12,500",  "iconName": "CreditCard"},
    {"label": "Semester Fee",    "value": "BDT 12,000",  "iconName": "Wallet"}
  ]'::jsonb,
  '[
    {
      "name": "Bi-Semester",
      "shiftLabel": "Six Months Semester",
      "iconName": "Calendar",
      "description": "",
      "groups": [
        {
          "background": "Fee Structure",
          "tiers": [
            {"gpa": "Regular rate",  "credits": 36, "perCredit": 2000, "waiver": "—",   "total": 0},
            {"gpa": "After waiver",  "credits": 36, "perCredit": 1180, "waiver": "41%", "total": 66980},
            {"gpa": "SU graduates",  "credits": 36, "perCredit": 1180, "waiver": "41%", "total": 56980}
          ]
        }
      ]
    }
  ]'::jsonb,
  '[
    {"title": "Advance Payment Waiver",       "iconName": "Percent",       "text": "A 10% waiver on tuition fees applies when the full first-semester fee is paid at admission, and 15% when the full program fee is paid at admission."},
    {"title": "Concession for SU Graduates",  "iconName": "GraduationCap", "text": "Graduates of Sonargaon University pay a reduced admission fee (BDT 9,500 plus BDT 1,000 tuition), a lower semester fee, and receive a further BDT 2,000 concession on the total program cost."},
    {"title": "Provisional Certificate Fee",  "iconName": "FileText",      "text": "An additional BDT 7,500 is charged for the Provisional Certificate (PVC) in the final semester."}
  ]'::jsonb,
  8,
  NOW(), NOW()
FROM "program" p
WHERE p."degreeCode" = 'MAMS'
ON CONFLICT ("programId") DO NOTHING;
