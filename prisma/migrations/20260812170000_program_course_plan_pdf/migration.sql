-- Downloadable course plan PDF offered under the Credit Distribution
-- table on /programs/<slug>. Nullable so the download card stays hidden
-- until a file is uploaded from the admin panel.
ALTER TABLE "program"
    ADD COLUMN "coursePlanPdfUrl"      TEXT,
    ADD COLUMN "coursePlanPdfPublicId" TEXT,
    ADD COLUMN "coursePlanPdfFileName" TEXT;
