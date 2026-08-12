-- Restore the office directory rows.
--
-- They were emptied by a save from a stale admin tab: that older form had
-- no rows editor, so it posted roomRows=[] and overwrote the four offices.
-- Re-seeded from the department's Layout Plan document. Only applied when
-- the column is currently empty, so a later legitimate edit is not undone
-- if this migration is ever replayed.
UPDATE "about_department_layout"
SET "roomRows" = '[
    {"office": "Dean, Faculty of Business", "location": "Room 314, Sonargaon University", "building": "147/I, Panthapath, Greenroad, Dhaka", "highlight": false},
    {"office": "Head, Department of Business Administration", "location": "Room 401, Sonargaon University", "building": "147/I, Panthapath, Greenroad, Dhaka", "highlight": true},
    {"office": "Course Coordinators & Faculty Members, Department of Business Administration", "location": "Room 501, Sonargaon University", "building": "147/I, Panthapath, Greenroad, Dhaka", "highlight": true},
    {"office": "Exam & Internship Coordinators & Faculty Members, Department of Business Administration", "location": "Room 504, Sonargaon University", "building": "147/I, Panthapath, Greenroad, Dhaka", "highlight": true}
]'::jsonb,
    "updatedAt" = NOW()
WHERE "id" = 'singleton'
  AND jsonb_array_length(COALESCE("roomRows", '[]'::jsonb)) = 0;
