-- One more su.edu.bd hot-link, predating the backfill migrations: the
-- Corporate Governance paper pointed at
-- su.edu.bd/web_assets/journal/journal_four/... Same treatment as the
-- rest -- the file now lives in our Cloudinary account and the hot-link
-- is cleared, so /research no longer depends on another site's paths.
--
-- Matched on the link rather than a hard-coded cuid: this row was created
-- by the seed, so its id differs between environments.

UPDATE "research_paper"
SET "pdfUrl"      = 'https://res.cloudinary.com/n3n2tgqk/raw/upload/v1787037669/bba-dept/research/papers/corporate-governance-pharmaceutical-chemical-ceramic.pdf',
    "pdfPublicId" = 'bba-dept/research/papers/corporate-governance-pharmaceutical-chemical-ceramic.pdf',
    "pdfFileName" = 'corporate-governance-pharmaceutical-chemical-ceramic.pdf',
    "link"        = NULL,
    "linkLabel"   = NULL,
    "updatedAt"   = NOW()
WHERE "link" = 'https://su.edu.bd/web_assets/journal/journal_four/06%20Md.%20Imranul%20Islam.pdf';
