-- Service Charter for /student-society/service-charter: the 15 services
-- students need from the department office, each with its ordered steps
-- and the person responsible.
CREATE TABLE "service_charter_item" (
    "id"           TEXT NOT NULL,
    "title"        TEXT NOT NULL,
    "steps"        JSONB NOT NULL DEFAULT '[]',
    "personName"   TEXT,
    "personPhone"  TEXT,
    "personEmail"  TEXT,
    "personRoom"   TEXT,
    "personNote"   TEXT,
    "displayOrder" INTEGER NOT NULL,
    "createdAt"    TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt"    TIMESTAMP(3) NOT NULL,

    CONSTRAINT "service_charter_item_pkey" PRIMARY KEY ("id")
);
CREATE INDEX "service_charter_item_displayOrder_idx" ON "service_charter_item"("displayOrder");

CREATE TABLE "service_charter_meta" (
    "id"          TEXT NOT NULL DEFAULT 'singleton',
    "intro"       TEXT NOT NULL,
    "pdfUrl"      TEXT,
    "pdfPublicId" TEXT,
    "pdfFileName" TEXT,
    "updatedAt"   TIMESTAMP(3) NOT NULL,

    CONSTRAINT "service_charter_meta_pkey" PRIMARY KEY ("id")
);

INSERT INTO "service_charter_meta" ("id", "intro", "updatedAt") VALUES (
  'singleton',
  'What to do, in what order, and who to ask — for the things students need from the department office through the semester.',
  NOW()
);

-- The three recurring contacts are repeated per row rather than
-- normalised into a table: the source document lists them per service,
-- and keeping them inline lets one service''s contact change without
-- touching the others.
INSERT INTO "service_charter_item"
  ("id", "title", "steps", "personName", "personPhone", "personEmail", "personRoom", "personNote", "displayOrder", "updatedAt")
VALUES
  ('svc_charter_01', 'Collect student ID Card, Email address and know about student portal. (For newly admitted students)',
   '["Contact to the Student Welfare Devision (Room no: 311)"]'::jsonb,
   'Rifat Islam (Assistant Director)', '+880 1955-544907', 'su.sad.bd@gmail.com', '311 (Green Road campus)', 'Student Welfare Division', 0, NOW()),

  ('svc_charter_02', 'Course Offering',
   '["Department Office will publish the Course Offering → Follow the Notice Board of the Department https://su.edu.bd/welcome/program_details/5 (as per semester schedule)"]'::jsonb,
   'Sheikh Abid Ibn Shahed (Lecturer & Coordinator)', '01951553673', 'sheikhabid201@gmail.com', '504 (Green Road campus)', NULL, 1, NOW()),

  ('svc_charter_03', 'Registration Process',
   '["Accounts Clearance (Room no: 313) (By paying the required fees to the SU accounts or pay through online)","Meet with Batch Advisor (along with online clearance)","Check the Student Portal (for confirmation of the registration)"]'::jsonb,
   'Sheikh Abid Ibn Shahed (Lecturer & Coordinator)', '01951553673', 'sheikhabid201@gmail.com', '504 (Green Road campus)', NULL, 2, NOW()),

  ('svc_charter_04', 'Subject or Course Add/Drop/Changes',
   '["Contact to the Course Co-ordinator (Room no: 504)"]'::jsonb,
   'Sheikh Abid Ibn Shahed (Lecturer & Coordinator)', '01951553673', 'sheikhabid201@gmail.com', '504 (Green Road campus)', NULL, 3, NOW()),

  ('svc_charter_05', 'Semester Drop Process',
   '["Write an application from student''s erp following the below process: Log in ERP> application process>Drop semester application.","Contact to the Student Welfare Devision (Room no: 311)"]'::jsonb,
   'Rifat Islam (Assistant Director)', '+880 1955-544907', 'su.sad.bd@gmail.com', '311 (Green Road campus)', 'Student Welfare Division', 4, NOW()),

  ('svc_charter_06', 'To register courses of previous syllabus',
   '["Write an application (for format of writing the application communicate with the Department Office)","Submit the application to the Department Office (Room no: 504) (for further process)"]'::jsonb,
   'Sheikh Abid Ibn Shahed (Lecturer & Coordinator)', '01951553673', 'sheikhabid201@gmail.com', '504 (Green Road campus)', NULL, 5, NOW()),

  ('svc_charter_07', 'Re-admission Process (Students will pay required Re-admission fee to the SU accounts section or online as per the university policy)',
   '["Write an application from student''s erp following the below process: Log in ERP> application process> e-application for Registrar office> subject> application body> mobile number> submit.","Contact to the Student Welfare Devision (Room no: 311)"]'::jsonb,
   'Rifat Islam (Assistant Director)', '+880 1955-544907', 'su.sad.bd@gmail.com', '311 (Green Road campus)', 'Student Welfare Division', 6, NOW()),

  ('svc_charter_08', 'Extension of the studentship',
   '["Write an application from student''s erp following the below process: Log in ERP> application process> e-application for Registrar office> subject> application body> mobile number> submit.","Contact to the Student Welfare Devision (Room no: 311)"]'::jsonb,
   'Rifat Islam (Assistant Director)', '+880 1955-544907', 'su.sad.bd@gmail.com', '311 (Green Road campus)', 'Student Welfare Division', 7, NOW()),

  ('svc_charter_09', 'Clearance for examinations - (Admit Card) (Midterm and Final)',
   '["Pay your required fees (by paying the required fees to the SU accounts or pay through online)","Contact to the Department Office (Room no: 504) (for further process)"]'::jsonb,
   'Sheikh Abid Ibn Shahed (Lecturer & Coordinator)', '01951553673', 'sheikhabid201@gmail.com', '504 (Green Road campus)', NULL, 8, NOW()),

  ('svc_charter_10', 'Semester Result',
   '["Students can see the semester result from the Student Portal (Need to complete the teaching evaluation from student portal then select your semester)"]'::jsonb,
   'Rifat Islam (Assistant Director)', '+880 1955-544907', 'su.sad.bd@gmail.com', '311 (Green Road campus)', 'Student Welfare Division', 9, NOW()),

  ('svc_charter_11', 'Email password problem, student portal problem and internship portal problem',
   '["Contact to the Student Welfare Devision (Room no: 311). For e-mail support please contact to this e-mail: su.sad.bd@gmail.com"]'::jsonb,
   'Rifat Islam (Assistant Director)', '+880 1955-544907', 'su.sad.bd@gmail.com', '311 (Green Road campus)', 'Student Welfare Division', 10, NOW()),

  ('svc_charter_12', 'Scholarship/Waiver support',
   '["Follow the website of the SU - https://su.edu.bd/Admission/waiver_policy for the update information"]'::jsonb,
   'Ekramunnesa Joya (Admission Officer)', '01955529725', 'suadm.data04@gmail.com', 'Admission room (Green Road campus)', NULL, 11, NOW()),

  ('svc_charter_13', 'Academic Transcripts / Certificates',
   '["Payment (Pay your required fees to the SU accounts section or pay through online)","Collect the Documents (from Exam section, room no: 211, as per delivery deadline)"]'::jsonb,
   'Md. Reazul Islam (Assistant Controller of Examinations)', '01955544951', 'md.reazulislam5130@gmail.com', '211 (Green Road campus)', NULL, 12, NOW()),

  ('svc_charter_14', 'Teachers / Officers Information',
   '["Follow the website of the SU → Follow the website of the Department: https://su.edu.bd/welcome/program_details/5"]'::jsonb,
   'Sheikh Abid Ibn Shahed (Lecturer & Coordinator)', '01951553673', 'sheikhabid201@gmail.com', '504 (Green Road campus)', NULL, 13, NOW()),

  ('svc_charter_15', 'SU Transportation',
   '["Admitted students can collect the information of the buses from reception, assigned for different routes for free transportation of the students."]'::jsonb,
   'Md. Jakir (Front Desk Officer)', '01992077157', NULL, NULL, NULL, 14, NOW());

-- Page hero. The Business Club image is reused, per the brief.
INSERT INTO "page_hero" ("id", "pageKey", "pageLabel", "publicPath", "heroTitle", "heroOverline", "heroImageUrl", "heroImageVerticalPercent", "updatedAt")
VALUES (
  'ph_service_charter',
  'student-society-service-charter',
  'Student Society — Service Charter',
  '/student-society/service-charter',
  'Service Charter',
  'Student Society',
  'https://res.cloudinary.com/n3n2tgqk/image/upload/f_auto,q_auto:good/v1785824537/bba-dept/about/dijl9bygnnexdfbkmikv.png',
  3,
  NOW()
)
ON CONFLICT ("pageKey") DO NOTHING;

-- Menu entry, appended to the Student Society dropdown.
INSERT INTO "main_nav_item" ("id", "groupId", "name", "href", "isExternal", "isDisabled", "displayOrder", "updatedAt")
SELECT 'nav_service_charter', g."id", 'Service Charter', '/student-society/service-charter', false, false,
       COALESCE((SELECT MAX(i."displayOrder") + 1 FROM "main_nav_item" i WHERE i."groupId" = g."id"), 0),
       NOW()
FROM "main_nav_group" g
WHERE g."name" = 'Student Society'
ON CONFLICT ("id") DO NOTHING;
