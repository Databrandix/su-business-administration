-- New graduate program: MBA in Apparel Merchandising (MAMS) — the 1-year
-- variant of the existing 2-year MBA-AM. Seeded from "MAMS (1 yr MBA)
-- List of Courses" (Syllabus Review Committee, 09/05/2021).
--
-- Deliberately consistent with MBA-AM, per request: same programs hero
-- (all /programs/<slug> pages share getPageHero('programs')), same card
-- image, same CTA, and the shared CareerProspects singleton — so nothing
-- below needs to duplicate those. Only the at-a-glance fields and the
-- specializations differ.
--
-- Credits reconcile with the document's stated total:
--   1st Semester   5 theory x 3.00                        = 15.00
--   2nd Semester   5 theory x 3.00 + Project 3 + Attach 3 = 21.00
--                                                    Total  36.00
-- Category breakdown corroborates: TE 3 + AMT 12 + BA 15 + Project and
-- Industrial Attachment 6 = 36.
--
-- Transcription note: the source's 2nd-semester footer reads "15.0 (T) +
-- 6.0 (S) = 21.0 hrs./week", but that table's theory column totals 18.0
-- because it folds MAM 1200's 6.0 sessional hours into the theory sum.
-- The footer is right (5 theory courses x 3.0 = 15.0), so the footer's
-- figures are recorded here.
--
-- Course codes use the 1xxx series (1101/1201), not MBA-AM's 5xxx — the
-- two programs are separate degrees, so codes are kept exactly as printed
-- rather than aligned to the 2-year plan.

INSERT INTO "program" (
  "id", "overline", "programName", "degreeCode", "slug", "duration",
  "description", "overviewParagraphs", "displayOrder",
  "imageUrl", "imagePublicId", "specializations", "cta", "ctaHref",
  "courseStructure", "majorOptions", "majorOptionsNote",
  "courseStructureTotal",
  "coursePlanPdfUrl", "coursePlanPdfFileName",
  "createdAt", "updatedAt"
)
SELECT
  'cmams1yrmbaapparelmerch01',
  'Graduate',
  'MBA in Apparel Merchandising (MAMS)',
  'MAMS',
  'mba-apparel-merchandising-mams',
  '1 Year · 2 Semesters',
  'A one-year graduate route into apparel merchandising for FDT, AMT, KMT and TE graduates. Building on an existing textile or apparel background, it concentrates on merchandising management, compliance, costing and buyer communication, closing with project work and an industrial attachment.',
  '[
    "The Department of Business Administration offers a one-year graduate program titled MBA in Apparel Merchandising (MAMS). Designed for graduates of Fashion Design & Technology, Apparel Manufacturing & Technology, Knitwear Manufacturing & Technology and Textile Engineering, it converts an existing technical foundation into the commercial and managerial competence the readymade garment sector depends on.",
    "Because entrants already hold a relevant technical degree, the curriculum moves directly to merchandising management, total quality management and compliance, entrepreneurship in RMG business, and the accounting and quantitative methods behind costing and order decisions. The program closes with supervised project work and an eight-week industrial attachment, so graduates leave with documented factory-floor experience alongside the coursework."
  ]'::jsonb,
  8,
  p."imageUrl",
  p."imagePublicId",
  ARRAY[
    'Merchandising Management',
    'TQM & Compliance',
    'RMG Entrepreneurship',
    'Project Work & Industrial Attachment'
  ]::text[],
  p."cta",
  p."ctaHref",
  '[
    {"title": "1st Semester", "courses": [
      {"code": "TE 1101",  "title": "Textile Science: Fiber-yarn-Fabric",          "contact": "3.0", "credits": "3.00"},
      {"code": "AMT 1101", "title": "Clothing Materials & Production Technology",  "contact": "3.0", "credits": "3.00"},
      {"code": "BA 1101",  "title": "Electronic Commerce",                         "contact": "3.0", "credits": "3.00"},
      {"code": "BA 1103",  "title": "Management Information System (MIS)",         "contact": "3.0", "credits": "3.00"},
      {"code": "BA 1105",  "title": "Marketing Management",                        "contact": "3.0", "credits": "3.00"}
    ], "footer": "Contact hours: 15.0 (T) + 0.0 (S) = 15.0 hrs./week · Total credits: 15.00 · Theory: 5 · Sessional: 0"},
    {"title": "2nd Semester", "courses": [
      {"code": "AMT 1201", "title": "Apparel Merchandising Management",   "contact": "3.0", "credits": "3.00"},
      {"code": "AMT 1203", "title": "TQM & Compliances",                  "contact": "3.0", "credits": "3.00"},
      {"code": "AMT 1205", "title": "Entrepreneurship in RMG Business",   "contact": "3.0", "credits": "3.00"},
      {"code": "BA 1201",  "title": "Quantitative Business Analysis",     "contact": "3.0", "credits": "3.00"},
      {"code": "BA 1203",  "title": "Financial Accounting",               "contact": "3.0", "credits": "3.00"},
      {"code": "MAM 1200", "title": "Project Work (Sessional)",           "contact": "6.0", "credits": "3.00"},
      {"code": "MAM 1202", "title": "Industrial Attachment (Sessional)",  "contact": "--",  "credits": "3.00"}
    ], "footer": "Contact hours: 15.0 (T) + 6.0 (S) = 21.0 hrs./week · Total credits: 21.00 · Theory: 5 · Sessional: 2"}
  ]'::jsonb,
  '[]'::jsonb,
  NULL,
  'Total 36 Credits',
  '/assets/mams-course-structure.pdf',
  'mams-course-structure.pdf',
  NOW(), NOW()
FROM "program" p
WHERE p."degreeCode" = 'MBA-AM'
ON CONFLICT ("degreeCode") DO NOTHING;

-- Nav: add under the existing "Graduate" heading in the Program dropdown,
-- immediately after the 2-year MBA in Apparel Merchandising so the pair
-- reads together. Later graduate siblings shift down by one.
UPDATE "main_nav_item"
SET "displayOrder" = "displayOrder" + 1
WHERE "parentId" = (
  SELECT "id" FROM "main_nav_item"
  WHERE "name" = 'Graduate' AND "parentId" IS NULL
)
AND "displayOrder" >= 2;

INSERT INTO "main_nav_item" (
  "id", "groupId", "name", "href", "isExternal", "isDisabled",
  "displayOrder", "parentId", "createdAt", "updatedAt"
)
SELECT
  'cmamsnavitem1yrmba000001',
  g."id",
  'MBA in Apparel Merchandising (MAMS)',
  '/programs/mba-apparel-merchandising-mams',
  FALSE, FALSE,
  2,
  parent."id",
  NOW(), NOW()
FROM "main_nav_group" g
JOIN "main_nav_item" parent
  ON parent."groupId" = g."id"
 AND parent."name" = 'Graduate'
 AND parent."parentId" IS NULL
WHERE g."name" = 'Program'
ON CONFLICT ("id") DO NOTHING;
