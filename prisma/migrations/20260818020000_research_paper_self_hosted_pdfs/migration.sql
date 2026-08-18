-- Self-host the research paper PDFs.
--
-- The previous migration stored su.edu.bd/web_assets/journal/... URLs in
-- `link`, so /research hot-linked another site: those paths move when the
-- university reorganises, and every download left our infrastructure. The
-- 13 files are now in our own Cloudinary account under
-- <root>/research/papers, uploaded with the same signed-upload flow the
-- CMS uses, and are editable at /admin/research-papers like any other
-- attachment.
--
-- Six of the originals exceeded the 10 MB raw-upload limit -- they are
-- scans, up to 47 MB -- so those were re-rendered at 150 DPI / JPEG q75
-- before upload. Page counts are unchanged and the text stays legible;
-- the smallest resulting file is 2.6 MB, the largest 6.1 MB.
--
-- `link` is cleared on the rows whose only link was the su.edu.bd file,
-- since the hosted PDF now supersedes it. Rows whose `link` is a DOI or
-- publisher page (the SERVQUAL and RMG papers) keep it: the card shows
-- the PDF button and the publisher link side by side.

ALTER TABLE "research_paper"
  ADD COLUMN IF NOT EXISTS "pdfUrl"      TEXT,
  ADD COLUMN IF NOT EXISTS "pdfPublicId" TEXT,
  ADD COLUMN IF NOT EXISTS "pdfFileName" TEXT;


UPDATE "research_paper"
SET "pdfUrl" = 'https://res.cloudinary.com/n3n2tgqk/raw/upload/v1787037390/bba-dept/research/papers/corporate-liquidity-profitability-textile.pdf', "pdfPublicId" = 'bba-dept/research/papers/corporate-liquidity-profitability-textile.pdf', "pdfFileName" = 'corporate-liquidity-profitability-textile.pdf', "updatedAt" = NOW()
WHERE "id" IN ('sup_04_a1', 'sup_04_a2');

UPDATE "research_paper"
SET "pdfUrl" = 'https://res.cloudinary.com/n3n2tgqk/raw/upload/v1787037392/bba-dept/research/papers/pharmaceutical-industry-bangladesh-synopsis.pdf', "pdfPublicId" = 'bba-dept/research/papers/pharmaceutical-industry-bangladesh-synopsis.pdf', "pdfFileName" = 'pharmaceutical-industry-bangladesh-synopsis.pdf', "updatedAt" = NOW()
WHERE "id" IN ('sup_05_a1');

UPDATE "research_paper"
SET "pdfUrl" = 'https://res.cloudinary.com/n3n2tgqk/raw/upload/v1787037394/bba-dept/research/papers/csr-impact-corporate-profitability-banks.pdf', "pdfPublicId" = 'bba-dept/research/papers/csr-impact-corporate-profitability-banks.pdf', "pdfFileName" = 'csr-impact-corporate-profitability-banks.pdf', "updatedAt" = NOW()
WHERE "id" IN ('sup_06_a1');

UPDATE "research_paper"
SET "pdfUrl" = 'https://res.cloudinary.com/n3n2tgqk/raw/upload/v1787037398/bba-dept/research/papers/performance-evaluation-cement-industry.pdf', "pdfPublicId" = 'bba-dept/research/papers/performance-evaluation-cement-industry.pdf', "pdfFileName" = 'performance-evaluation-cement-industry.pdf', "updatedAt" = NOW()
WHERE "id" IN ('sup_07_a1', 'sup_07_a2', 'sup_07_a3');

UPDATE "research_paper"
SET "pdfUrl" = 'https://res.cloudinary.com/n3n2tgqk/raw/upload/v1787037400/bba-dept/research/papers/shaping-festival-financing-expenditure.pdf', "pdfPublicId" = 'bba-dept/research/papers/shaping-festival-financing-expenditure.pdf', "pdfFileName" = 'shaping-festival-financing-expenditure.pdf', "updatedAt" = NOW()
WHERE "id" IN ('sup_08_a1');

UPDATE "research_paper"
SET "pdfUrl" = 'https://res.cloudinary.com/n3n2tgqk/raw/upload/v1787037228/bba-dept/research/papers/nation-branding-bangladesh-domestic-products.pdf', "pdfPublicId" = 'bba-dept/research/papers/nation-branding-bangladesh-domestic-products.pdf', "pdfFileName" = 'nation-branding-bangladesh-domestic-products.pdf', "updatedAt" = NOW()
WHERE "id" IN ('sup_09_a1', 'sup_09_a2', 'sup_09_a3');

UPDATE "research_paper"
SET "pdfUrl" = 'https://res.cloudinary.com/n3n2tgqk/raw/upload/v1787037236/bba-dept/research/papers/social-networks-students-academic-personal-life.pdf', "pdfPublicId" = 'bba-dept/research/papers/social-networks-students-academic-personal-life.pdf', "pdfFileName" = 'social-networks-students-academic-personal-life.pdf', "updatedAt" = NOW()
WHERE "id" IN ('sup_10_a1', 'sup_10_a2', 'sup_10_a3', 'sup_10_a4', 'sup_10_a5');

UPDATE "research_paper"
SET "pdfUrl" = 'https://res.cloudinary.com/n3n2tgqk/raw/upload/v1787037243/bba-dept/research/papers/microfinance-poor-access-empirical-study.pdf', "pdfPublicId" = 'bba-dept/research/papers/microfinance-poor-access-empirical-study.pdf', "pdfFileName" = 'microfinance-poor-access-empirical-study.pdf', "updatedAt" = NOW()
WHERE "id" IN ('sup_11_a1', 'sup_11_a2', 'sup_11_a3');

UPDATE "research_paper"
SET "pdfUrl" = 'https://res.cloudinary.com/n3n2tgqk/raw/upload/v1787037250/bba-dept/research/papers/balance-of-payments-trade-exchange-rate.pdf', "pdfPublicId" = 'bba-dept/research/papers/balance-of-payments-trade-exchange-rate.pdf', "pdfFileName" = 'balance-of-payments-trade-exchange-rate.pdf', "updatedAt" = NOW()
WHERE "id" IN ('sup_12_a1', 'sup_12_a2', 'sup_12_a3');

UPDATE "research_paper"
SET "pdfUrl" = 'https://res.cloudinary.com/n3n2tgqk/raw/upload/v1787037267/bba-dept/research/papers/is-microfinance-beneficial-or-optimistic.pdf', "pdfPublicId" = 'bba-dept/research/papers/is-microfinance-beneficial-or-optimistic.pdf', "pdfFileName" = 'is-microfinance-beneficial-or-optimistic.pdf', "updatedAt" = NOW()
WHERE "id" IN ('sup_13_a1', 'sup_13_a2', 'sup_13_a3', 'sup_13_a4');

UPDATE "research_paper"
SET "pdfUrl" = 'https://res.cloudinary.com/n3n2tgqk/raw/upload/v1787037070/bba-dept/research/papers/economic-analysis-shipping-industry-bangladesh.pdf', "pdfPublicId" = 'bba-dept/research/papers/economic-analysis-shipping-industry-bangladesh.pdf', "pdfFileName" = 'economic-analysis-shipping-industry-bangladesh.pdf', "updatedAt" = NOW()
WHERE "id" IN ('sup_14_a1', 'sup_14_a2', 'sup_14_a3');

UPDATE "research_paper"
SET "pdfUrl" = 'https://res.cloudinary.com/n3n2tgqk/raw/upload/v1787037403/bba-dept/research/papers/macro-economic-variables-stock-market-returns.pdf', "pdfPublicId" = 'bba-dept/research/papers/macro-economic-variables-stock-market-returns.pdf', "pdfFileName" = 'macro-economic-variables-stock-market-returns.pdf', "updatedAt" = NOW()
WHERE "id" IN ('sup_15_a1', 'sup_15_a2', 'sup_15_a3');

UPDATE "research_paper"
SET "pdfUrl" = 'https://res.cloudinary.com/n3n2tgqk/raw/upload/v1787037290/bba-dept/research/papers/production-management-renewable-energy.pdf', "pdfPublicId" = 'bba-dept/research/papers/production-management-renewable-energy.pdf', "pdfFileName" = 'production-management-renewable-energy.pdf', "updatedAt" = NOW()
WHERE "id" IN ('sup_16_a1');


-- Drop the hot-links now that the file is served from our own account.
-- Scoped to su.edu.bd/web_assets so DOIs and publisher pages survive.
UPDATE "research_paper"
SET "link" = NULL, "linkLabel" = NULL, "updatedAt" = NOW()
WHERE "pdfUrl" IS NOT NULL
  AND "link" LIKE 'https://su.edu.bd/web_assets/%';
