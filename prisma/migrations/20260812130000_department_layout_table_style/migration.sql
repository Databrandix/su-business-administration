-- Rework the directory to match the university's Department Layout
-- table: a bordered card with a centered University/Department/address
-- header, two columns (office, specific location), and the department's
-- own offices highlighted. Replaces the earlier Sl./Particulars/Room
-- shape, so `roomsTitle` is dropped and the row objects change from
-- { particulars, room } to { office, location, building, highlight }.
ALTER TABLE "about_department_layout"
    DROP COLUMN IF EXISTS "roomsTitle",
    ADD COLUMN "tableUniversity"     TEXT NOT NULL DEFAULT 'Sonargaon University',
    ADD COLUMN "tableDepartment"     TEXT NOT NULL DEFAULT 'Department of Business Administration',
    ADD COLUMN "tableAddress"        TEXT NOT NULL DEFAULT '147/I, Panthapath, Greenroad, Dhaka-1215',
    ADD COLUMN "columnOfficeLabel"   TEXT NOT NULL DEFAULT 'Name of the Office',
    ADD COLUMN "columnLocationLabel" TEXT NOT NULL DEFAULT 'Specific Location of the Office';

-- Re-seed from the department's Layout Plan document. The document gives
-- room numbers rather than levels, so the room is the primary location
-- line and the building address is the secondary line — the same two-line
-- cell the reference table uses.
UPDATE "about_department_layout"
SET "roomRows" = '[
    {"office": "Dean, Faculty of Business", "location": "Room 314, Sonargaon University", "building": "147/I, Panthapath, Greenroad, Dhaka", "highlight": false},
    {"office": "Head, Department of Business Administration", "location": "Room 401, Sonargaon University", "building": "147/I, Panthapath, Greenroad, Dhaka", "highlight": true},
    {"office": "Course Coordinators & Faculty Members, Department of Business Administration", "location": "Room 501, Sonargaon University", "building": "147/I, Panthapath, Greenroad, Dhaka", "highlight": true},
    {"office": "Exam & Internship Coordinators & Faculty Members, Department of Business Administration", "location": "Room 504, Sonargaon University", "building": "147/I, Panthapath, Greenroad, Dhaka", "highlight": true}
]'::jsonb,
    "updatedAt" = NOW()
WHERE "id" = 'singleton';
