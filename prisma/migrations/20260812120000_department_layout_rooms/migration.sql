-- The page previously showed only intro copy plus the layout card, so a
-- visitor could not tell which room to go to without opening the PDF.
-- `roomRows` holds the office directory as { particulars, room }[] and is
-- rendered as a table above the card. Serial numbers derive from array
-- order rather than being stored, so reordering renumbers on its own.
ALTER TABLE "about_department_layout"
    ADD COLUMN "roomRows" JSONB NOT NULL DEFAULT '[]',
    ADD COLUMN "roomsTitle" TEXT NOT NULL DEFAULT 'Office & Room Directory';

-- Seed the directory from the department's Layout Plan document.
UPDATE "about_department_layout"
SET "roomRows" = '[
    {"particulars": "Dean (Faculty of Business)", "room": "314"},
    {"particulars": "Head (Department of Business Administration)", "room": "401"},
    {"particulars": "Course Coordinators & Faculty Members (Department of Business Administration)", "room": "501"},
    {"particulars": "Exam & Internship Coordinators & Faculty Members (Department of Business Administration)", "room": "504"}
]'::jsonb,
    "paragraphs" = '["In an academic setting the Department of Business Administration at Sonargaon University follows this Service Charter."]'::jsonb,
    "updatedAt" = NOW()
WHERE "id" = 'singleton';
