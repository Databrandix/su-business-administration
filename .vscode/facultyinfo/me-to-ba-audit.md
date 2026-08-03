# Mechanical Engineering → Business Administration — Hardcoded References Audit

**Target hierarchy:**
```
Sonargaon University
└── Faculty of Business
    └── Department of Business Administration
```
**Replacement rules:**
- `Department of Mechanical Engineering` → `Department of Business Administration`
- `Mechanical Engineering` (standalone) → `Business Administration`
- `ME` → `BA`
- `mechanical-engineering` (slug/path) → `business-administration`
- `mecha-club` / `Mecha Club` → business club equivalent or remove
- `sonargaon-me` (Cloudinary/env) → `sonargaon-ba`
- `BSc-ME` / `B.Sc. in Mechanical Engineering` → BA program codes
- `Faculty of Science & Engineering` or similar → `Faculty of Business`

**Approximately 350-400 hardcoded references across ~80+ files.**

---

## A — Critical (must change for site to function correctly)

### Root Meta / SEO

| File | Line | Current | Replace with |
|------|------|---------|-------------|
| `src/app/layout.tsx` | 27 | `https://mechanical-engineering-olive.vercel.app` | Actual production URL |
| `src/app/layout.tsx` | 28 | `Sonargaon University — ME Department` | `Sonargaon University | Faculty of Business — BA` |
| `src/app/layout.tsx` | 30 | `Department of Mechanical Engineering at Sonargaon University — programs, faculty, research areas, labs, admissions, and campus services.` | `Department of Business Administration, Faculty of Business, Sonargaon University — programs, faculty, research, admissions, and campus services.` |
| `src/app/layout.tsx` | 37 | `template: '%s — Sonargaon University ME'` | `%s — Sonargaon University BA` |
| `src/app/layout.tsx` | 55 | `alt: 'Sonargaon University — Department of Mechanical Engineering'` | `Sonargaon University — Department of Business Administration` |
| `src/app/sitemap.ts` | 4 | `https://mechanical-engineering-olive.vercel.app` | Actual production URL |
| `src/app/sitemap.ts` | 14 | `/about/mecha-club` | Business club route or remove |
| `src/app/robots.ts` | 3 | `https://mechanical-engineering-olive.vercel.app` | Actual production URL |
| `src/app/not-found.tsx` | 8 | `Department of Mechanical Engineering website` | `Department of Business Administration website` |
| `src/app/admin/layout.tsx` | 5 | `%s — ME Admin` | `%s — BA Admin` |
| `src/app/admin/login/page.tsx` | 22 | `Mechanical Engineering · Admin Panel` | `Business Administration · Admin Panel` |
| `src/components/admin/Sidebar.tsx` | 286 | `Mechanical Engineering` | `Business Administration` |
| `.env.example` | 24 | `sonargaon-me` | `sonargaon-ba` |

### Database Seed (`scripts/seed.ts`) — 50+ references

| Line(s) | Current | Replace with |
|---------|---------|-------------|
| 35 | `name: 'Department of Mechanical Engineering'` | `'Department of Business Administration'` |
| 41 | `breadcrumbLabel: 'ME'` | `'BA'` |
| 99, 103 | `degreeCode: 'BSc-ME'` | BA program codes |
| 102 | `'Undergraduate — B.Sc in Mechanical Engineering'` | `'Undergraduate — BBA in Business Administration'` |
| 106 | `'core mechanical engineering...'` | Business-focused description |
| 125 | `'Fluid Mechanics & CFD'` | Business research area (e.g., `'Finance & Banking'`) |
| 205-210 | Overview paragraphs referencing mechanical engineering | BA overview |
| 250 | `messageTitleLine2: 'Department of Mechanical Engineering'` | `'Department of Business Administration'` |
| 306-308 | Image alt texts with "Mechanical Engineering" | `Sonargaon University — Department of Business Administration` |
| 345 | `'This research cell operates at the intersection of mechanical design...'` | BA-focused |
| 441 | `{ name: 'Mecha Club', href: '/about/mecha-club' }` | BA club or remove |
| 566-569 | About overview paragraphs (mechanical engineering) | BA about text |
| 591 | `'cutting-edge mechanical engineering solutions...'` | BA mission |
| 596 | `'Department of Mechanical Engineering will be acknowledged as a leader...'` | `'Department of Business Administration will be acknowledged as a leader...'` |
| 602-702 | `seedAboutMechaClub()` entire function | Replace with BA club or remove |
| 1210-1214 | `syllabus-me-cover.webp`, `syllabus-me.pdf` | BA syllabus assets |
| 1468 | `'B.Sc. in Mechanical Engineering (ME)'` | `'BBA in Business Administration'` |
| 1489-1498 | `bsc-mechanical-engineering`, prospectus `me` assets | BA equivalents |

### Components

| File | Line | Current | Replace with |
|------|------|---------|-------------|
| `src/components/sections/HeroSection.tsx` | 12 | `'Sonargaon University Mechanical Engineering Department'` | `'Sonargaon University — Department of Business Administration'` |
| `src/components/sections/HeroSection.tsx` | 13 | `'Sonargaon University Mechanical Engineering students and faculty'` | `'Sonargaon University — Faculty of Business'` |
| `src/components/sections/HeroSection.tsx` | 14 | `'Sonargaon University Mechanical Engineering campus'` | `'Sonargaon University campus'` |
| `src/components/sections/HeroSection.tsx` | 44 | `` `Sonargaon University Mechanical Engineering — slide ${i + 1}` `` | `` `Sonargaon University — Department of Business Administration, slide ${i + 1}` `` |
| `src/components/sections/NoticesSection.tsx` | 43 | `'Department of Mechanical Engineering — registration, holidays, and student services.'` | `'Department of Business Administration — registration, holidays, and student services.'` |
| `src/components/sections/EventsSection.tsx` | 42 | `'...—never miss what's shaping tomorrow's innovations at ME.'` | `'...at the Department of Business Administration.'` |
| `src/components/admin/Sidebar.tsx` | 84 | `label: 'Mecha Club', href: '/admin/about-mecha-club'` | BA club or remove |
| `src/components/admin/Sidebar.tsx` | 509-516 | `Mecha Club Applications`, `/admin/mecha-club-applications` | BA equivalent or remove |

### Admin CMS Defaults

| File | Line | Current | Replace with |
|------|------|---------|-------------|
| `src/app/admin/(authed)/alumni/AlumniForm.tsx` | 37 | `defaultValue: 'Mechanical Engineering'` | `'Business Administration'` |
| `src/app/admin/(authed)/syllabus/SyllabusForm.tsx` | 41 | `placeholder="bsc-mechanical-engineering"` | `bba-business-administration` |
| `src/app/admin/(authed)/syllabus/SyllabusForm.tsx` | 48 | `defaultValue: 'Mechanical Engineering'` | `'Business Administration'` |
| `src/app/admin/(authed)/prospectus-entries/ProspectusForm.tsx` | 41 | `placeholder="bsc-mechanical-engineering"` | `bba-business-administration` |
| `src/app/admin/(authed)/prospectus-entries/ProspectusForm.tsx` | 48 | `defaultValue: 'Mechanical Engineering'` | `'Business Administration'` |
| `src/app/admin/(authed)/program-fee-structures/[programId]/ProgramFeeStructureForm.tsx` | 62 | `placeholder="B.Sc. in Mechanical Engineering (ME)"` | `'BBA in Business Administration'` |
| `src/app/admin/(authed)/faculty/DesignationSelector.tsx` | 46 | Comment: `"Head, Department of Mechanical Engineering"` | `"Head, Department of Business Administration"` |

### Route-Based (`mecha-club` paths)

| File / Path | Notes |
|-------------|-------|
| `src/app/sitemap.ts:14` | `/about/mecha-club` entry |
| `src/app/admin/(authed)/page.tsx:247-249` | Dashboard link `href="/admin/about-mecha-club"` |
| `src/components/admin/Sidebar.tsx` | `Mecha Club` sidebar items |
| `src/app/admin/(authed)/about-mecha-club/` | Full directory — rename to BA equivalent |
| `src/app/admin/(authed)/mecha-club-applications/` | Full directory — rename |
| `src/app/(public)/about/mecha-club/` | Full directory — rename |
| `src/lib/admin-actions/about-mecha-club.ts` | Rename + update paths |
| `src/lib/admin-actions/mecha-club-applications.ts` | Rename + update paths |
| `src/lib/validation.ts` (L457, 1036, 1071-1092) | `aboutMechaClubUpdateSchema`, `mechaClubApplicationCreateSchema`, etc. |
| `src/lib/identity.ts` (L196-197) | `getAboutMechaClub` function |
| `src/lib/search-index.ts` (L43) | `{ title: 'Mecha Club', href: '/about/mecha-club' }` |

### Legacy Static Data Files

| File | References | Key Lines |
|------|-----------|-----------|
| `src/lib/faculty-data.ts` | ~60 | L47 `DEPARTMENT` constant = `'Department of Mechanical Engineering'` → `'Department of Business Administration'`; 27x `'Mechanical Engineering'` department labels; `ME 2101` etc. course codes |
| `src/lib/events-data.ts` | ~18 | L41, 48, 64, 66, 74, 90, 99, 130-153 — event titles/descriptions |
| `src/lib/news-data.ts` | ~18 | L31, 42, 44, 45, 66, 68, 81, 89, 103-112, 128-132 — news titles/descriptions |
| `src/lib/research-data.ts` | ~12 | L22, 30, 47, 55, 63, 71, 79, 87, 95, 103, 110, 133 — research paper affiliations |
| `src/lib/alumni-data.ts` | ~8 | L16, 25, 34, 35, 43, 52, 59, 61 — department: `'Mechanical Engineering'` |
| `src/lib/clubs-data.ts` | ~3 | L108-111 — club name, description |
| `src/lib/notices-data.ts` | 2 | L39, 87 — `ME` as department abbreviation |
| `src/lib/data.ts` | 2 | L14 (`B.Sc in Mechanical Engineering`), L45 (`Fluid Mechanics & CFD`) |

### Email

| File | Line | Current | Replace with |
|------|------|---------|-------------|
| `src/lib/email.ts` | 28 | `// (e.g. noreply@me.su.edu.bd)` | `// (e.g. noreply@ba.su.edu.bd)` |
| `src/lib/email.ts` | 32 | `'Sonargaon ME Contact <onboarding@resend.dev>'` | `'Sonargaon BA Contact <onboarding@resend.dev>'` |
| `src/lib/email.ts` | 102 | `Sonargaon ME` | `Sonargaon BA` |

---

## B — Page Metadata (~28 pages, ~40 titles/descriptions)

All in `src/app/(public)/**/page.tsx`. Every page has `title` and `description` referencing `Department of Mechanical Engineering` or `ME`. Replace all with `Department of Business Administration` / `BA`.

| Page | File | Current Title Pattern |
|------|------|----------------------|
| Mission & Vision | `about/mission-vision/page.tsx` | `Mission & Vision — Department of Mechanical Engineering` |
| Overview | `about/overview/page.tsx` | `Overview — Department of Mechanical Engineering` |
| Lab Facilities | `about/lab-facility/page.tsx` | `Lab Facilities — Department of Mechanical Engineering` |
| Laboratory Facility | `about/laboratory-facility/page.tsx` | `Laboratory Facility — Department of Mechanical Engineering` |
| Message from Head | `about/message-from-head/page.tsx` | `Message from Head — Department of Mechanical Engineering` |
| Mecha Club | `about/mecha-club/page.tsx` | `Mecha Club — Department of Mechanical Engineering` |
| Faculty Members | `faculty-member/page.tsx` | `Faculty Members — Department of Mechanical Engineering` |
| Admission Notice | `admission/notice/page.tsx` | `Admission Notice — Department of Mechanical Engineering` |
| Admission Requirements | `admission/requirements/page.tsx` | `Admission Requirements — Department of Mechanical Engineering` |
| Prospectus | `admission/prospectus/page.tsx` | `Prospectus — Department of Mechanical Engineering` |
| Transfer Credits | `admission/transfer-credits/page.tsx` | `Transfer Credits — Department of Mechanical Engineering` |
| Tuition Fees | `admission/tuition-fees/page.tsx` | `Tuition Fees — Department of Mechanical Engineering` |
| Waiver & Scholarship | `admission/waiver-scholarship/page.tsx` | `Waiver & Scholarship — Department of Mechanical Engineering` |
| News | `news/page.tsx` | `News — Department of Mechanical Engineering` |
| News Detail | `news/[slug]/page.tsx` | `` `${title} — Department of Mechanical Engineering` `` |
| Newsletter | `newsletter/page.tsx` | `Newsletter — Department of Mechanical Engineering` |
| Gallery | `gallery/page.tsx` | `Gallery — Department of Mechanical Engineering` |
| Research | `research/page.tsx` | `Research — Department of Mechanical Engineering` |
| Events | `student-society/events/page.tsx` | `Events — Department of Mechanical Engineering` |
| Event Detail | `student-society/events/[slug]/page.tsx` | `` `${title} — Department of Mechanical Engineering` `` |
| Visitors | `student-society/visitor/page.tsx` | `Visitors — Department of Mechanical Engineering` |
| Syllabus | `student-society/syllabus/page.tsx` | `Syllabus — Department of Mechanical Engineering` |
| Notice Board | `student-society/notice-board/page.tsx` | `Notice Board — Department of Mechanical Engineering` |
| FAQ | `student-society/faq/page.tsx` | `FAQ — Department of Mechanical Engineering` |
| Alumni | `student-society/alumni/page.tsx` | `Alumni — Department of Mechanical Engineering` |
| Privacy Policy | `privacy-policy/page.tsx` | Description: `Privacy Policy for the Department of Mechanical Engineering...` |
| Terms & Conditions | `terms-and-conditions/page.tsx` | Description: `Terms & Conditions for the Department of Mechanical Engineering...` |

**Global replace pattern across page metadata:**
- Title suffix: ` — Department of Mechanical Engineering` → ` | Faculty of Business — BA`
- Description text: `Department of Mechanical Engineering` → `Department of Business Administration, Faculty of Business`

---

## C — Prisma Schema + Migrations

| File | Line | Current | Notes |
|------|------|---------|-------|
| `prisma/schema.prisma` | 485 | `model AboutMechaClub` | Rename model to BA club equivalent |
| `prisma/schema.prisma` | 523 | `@@map("about_mecha_club")` | Remove or rename table |
| `prisma/schema.prisma` | 590 | `// Same Json shape pattern as Phase 4 AboutMechaClub.activities;` | Comment — update |
| `prisma/schema.prisma` | 1032 | `// e.g., "B.Sc. in Mechanical Engineering (ME)"` | `// e.g., "BBA in Business Administration"` |
| `prisma/schema.prisma` | 1381 | `// own a singleton with hero fields (AboutOverview, AboutMechaClub,` | Comment — update |
| `prisma/schema.prisma` | 1405-1408 | `model MechaClubApplication` | Remove or rename model |
| `prisma/schema.prisma` | 1428 | `@@map("mecha_club_application")` | Remove or rename table |

### Migration SQL files (DO NOT EDIT — historical DB state)

| Migration | References |
|-----------|-----------|
| `20260523060000_news_landing_singleton/migration.sql` | Line 29: `'Department of Mechanical Engineering'` |
| `20260524100000_newsletter_page_and_subscribers/migration.sql` | Line 56: `'Department of Mechanical Engineering'` |
| `20260524120000_move_mecha_club_to_student_society/migration.sql` | `"Mecha Club"`, `WHERE "name" = 'Mecha Club'` |
| `20260516103221_add_about_pages/migration.sql` | `"about_mecha_club"` table creation |
| `20260519125447_standardize_hero_image_positions/migration.sql` | 3x `"about_mecha_club"` references |
| `20260524130000_mecha_club_application/migration.sql` | 4x `"mecha_club_application"` references |
| `20260801061500_drop_unused_shortcode_facultyname/migration.sql` | Comment: `"ME" / "Faculty of Science &` |

---

## D — Non-Critical / Documentation Only

| File / Directory | Notes |
|------------------|-------|
| `README.md` | Line 1: `# Sonargaon University — ME Department`, L3: `Mechanical Engineering department` |
| `docs/phase-0-api.md` | ~20 references: `sonargaon-me`, `BSc-ME`, `MSc-ME`, `/api/admin/me` |
| `docs/superpowers/plans/` | Historical documentation |
| `docs/superpowers/specs/` | Historical documentation |
| `.github/PR_PHASE_*.md` (16 files) | Historical PR documentation |
| `src/lib/search-index.ts` | L43: `Mecha Club` static entry, L326: comment with `ME` |
| `src/app/api/admin/me/route.ts` | Route path `/api/admin/me` — "me" may stand for "my account" (auth), not "Mechanical Engineering" — review |

---

## E — Route / Directory Renames Required

| Current | Proposed |
|---------|----------|
| `/about/mecha-club` | `/about/business-club` or remove |
| `/admin/about-mecha-club` | `/admin/about-business-club` or remove |
| `/admin/mecha-club-applications` | `/admin/business-club-applications` or remove |
| `assets/mecha-hero.webp` | Remove or replace |
| `assets/mecha-club-*.webp` (6 files) | Remove or replace |
| `assets/syllabus-me-cover.webp` | `assets/syllabus-ba-cover.webp` |
| `assets/syllabus-me.pdf` | `assets/syllabus-ba.pdf` |
| `assets/prospectus-me-cover.webp` | `assets/prospectus-ba-cover.webp` |
| `assets/prospectus-me.pdf` | `assets/prospectus-ba.pdf` |

---

## Summary by Category

| Category | Approx. Count | Priority |
|----------|---------------|----------|
| Page metadata (title/description) | ~40 across 28 files | High |
| DB seed data (`scripts/seed.ts`) | ~50 | High |
| Legacy static data (`*-data.ts`) | ~100+ | Medium (DB-backed now) |
| Component hardcoded text | ~15 | High |
| Admin CMS form defaults | ~8 | High |
| Root config (layout, sitemap, robots, 404) | 8 | High |
| Environment config (`.env.example`) | 1 | High |
| Email (from address, templates) | 3 | High |
| Prisma schema (models, comments, table names) | ~10 | High |
| Migration SQL files (historical) | ~10 | Do not modify |
| Cloudinary folder / asset renames | ~10 | Medium |
| Route/directory renames | ~5 | High |
| README + API docs | ~25 | Low |
| PR documentation (`.github/`) | ~60+ | Skip (historical) |
| **Total** | **~350-400 across ~80+ files** | |
