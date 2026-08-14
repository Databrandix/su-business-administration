-- Replace homepage Hero #2 with a photograph of graduating students from
-- the 2nd Convocation (2025).
--
-- The previous slide was /assets/hero-1.webp, a convocation stage banner
-- whose own overlaid text competed with the hero's headline. The new
-- image is a candid of graduates, so the slide carries no baked-in copy.
--
-- Served from public/assets: the source (6720x4480, 14.9 MB) was resized
-- to 2400x1600 WebP (473 KB) before being committed.
UPDATE "department_identity"
SET "heroImage2Url"       = '/assets/hero-convocation-2025.webp',
    "heroImage2PublicId"  = NULL,
    "heroImage2Alt"       = 'Sonargaon University Business Administration graduates at the 2nd Convocation 2025',
    "updatedAt"           = NOW()
WHERE "id" = 'singleton';
