-- Course plans for the six remaining programs, seeded from the OBE
-- course plan PDFs held in the Syllabus section.
--
-- Credits reconcile with each document's stated total:
--   RMBA 57 core + 12 (one major)            = 69
--   EMBA 42 core + 12 (one major)            = 54
--   MBM  69 core (no majors)                 = 69
--   MSCM 69 core (no majors)                 = 69
--   MAM  60 core (no majors)                 = 60
--   MTFM 69 core (no majors)                 = 69
--
-- Transcription note: RMBA and EMBA share the same offset-table defect as
-- BBA/MBA — on the major-options page each title prints one row above its
-- code. Pairs were rebuilt from the regular BA x4X1..x4X4 code sequence,
-- and the option course lists are identical to MBA's, which extracts
-- cleanly and corroborates the reconstruction.
--
-- MAM and MTFM carry a Theory/Sessional split; sessional courses have no
-- theory contact hours, so their contact column records the sessional
-- hours and the credits column the sessional credits.

-- ── Regular MBA (69 credits) ────────────────────────────────────────────
UPDATE "program"
SET "courseStructureTotal" = 'Total 69 Credits',
    "majorOptionsNote" = 'Students will have to select all courses of any major option from I to VII below, in addition to BA 5000, BA 5001 and BA 5405.',
    "courseStructure" = '[
      {"title": "1st Semester", "courses": [
        {"code": "BA 5101", "title": "Introduction to Business",  "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5102", "title": "Principles of Accounting",  "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5103", "title": "Principles of Management",  "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5104", "title": "Principles of Marketing",   "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5105", "title": "Business Communication",    "contact": "3.0", "credits": "3.00"}
      ], "footer": "Contact hours: 15.0 hrs./week · Total credits: 15.00 · No. of theory courses: 5"},
      {"title": "2nd Semester", "courses": [
        {"code": "BA 5201",   "title": "Organizational Behavior",     "contact": "3.0", "credits": "3.00"},
        {"code": "Math 5202", "title": "Business Statistics",         "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5203",   "title": "Business Research Methods",   "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5204",   "title": "Principles of Finance",       "contact": "3.0", "credits": "3.00"},
        {"code": "Hum 5205",  "title": "Micro and Macroeconomics",    "contact": "3.0", "credits": "3.00"}
      ], "footer": "Contact hours: 15.0 hrs./week · Total credits: 15.00 · No. of theory courses: 5"},
      {"title": "3rd Semester", "courses": [
        {"code": "CSE 5301",  "title": "Computer Application in Business", "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5302",   "title": "Cost and Management Accounting",   "contact": "3.0", "credits": "3.00"},
        {"code": "Math 5303", "title": "Business Mathematics",             "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5304",   "title": "Strategic Management",             "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5305",   "title": "Legal Environment of Business",    "contact": "3.0", "credits": "3.00"}
      ], "footer": "Contact hours: 15.0 hrs./week · Total credits: 15.00 · No. of theory courses: 5"},
      {"title": "4th Semester", "note": "Major option courses are listed below. The following are compulsory for every option.", "courses": [
        {"code": "BA 5405", "title": "Auditing and Taxation",       "contact": "3.0",   "credits": "3.00"},
        {"code": "BA 5001", "title": "Comprehensive Viva-Voce",     "contact": "-----", "credits": "3.00"},
        {"code": "BA 5000", "title": "Thesis (Report & Defense)",   "contact": "12.0",  "credits": "6.00"}
      ], "footer": "Contact hours: 27.0 hrs./week · Total credits: 24.00 · No. of theory courses: 5"}
    ]'::jsonb,
    "majorOptions" = '[
      {"roman": "I", "name": "Management", "courses": [
        {"code": "BA 5411", "title": "Small Business Management",                   "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5412", "title": "Total Quality Management",                    "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5413", "title": "Organizational Development and Change",       "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5414", "title": "Management Science Applications in Business", "contact": "3.0", "credits": "3.00"}
      ]},
      {"roman": "II", "name": "Human Resource Management", "courses": [
        {"code": "BA 5421", "title": "Human Resource Planning",              "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5422", "title": "Compensation Management",              "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5423", "title": "Industrial Law and Labor Relations",   "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5424", "title": "Training and Development Management",  "contact": "3.0", "credits": "3.00"}
      ]},
      {"roman": "III", "name": "Accounting & Information Systems", "courses": [
        {"code": "BA 5431", "title": "Accounting Information Systems",       "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5432", "title": "Advanced Auditing",                    "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5433", "title": "Advanced Taxation",                    "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5434", "title": "International Accounting Standards",   "contact": "3.0", "credits": "3.00"}
      ]},
      {"roman": "IV", "name": "Finance", "courses": [
        {"code": "BA 5441", "title": "Corporate Finance",                            "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5442", "title": "Investment Analysis and Portfolio Management", "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5443", "title": "Bank Management",                              "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5444", "title": "Financial Market and Institutions",            "contact": "3.0", "credits": "3.00"}
      ]},
      {"roman": "V", "name": "Marketing", "courses": [
        {"code": "BA 5451", "title": "Consumer Behavior",                "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5452", "title": "Brand Management and Strategy",    "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5453", "title": "International Service Marketing",  "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5454", "title": "Marketing Research",               "contact": "3.0", "credits": "3.00"}
      ]},
      {"roman": "VI", "name": "Management Information Systems", "courses": [
        {"code": "BA 5461", "title": "Advanced Programming Concepts",     "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5462", "title": "Networking and Operating System",   "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5463", "title": "Database Systems",                  "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5464", "title": "E-Commerce and Web Programming",    "contact": "3.0", "credits": "3.00"}
      ]},
      {"roman": "VII", "name": "Supply Chain Management", "courses": [
        {"code": "BA 5471", "title": "Sourcing and Operations in Procurement and Supply Chain Management", "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5472", "title": "Inventory and Logistics Operations",                                 "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5473", "title": "Strategic Supply Chain Management",                                  "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5474", "title": "Managing Contracts and Relationships in Procurement and Supply Chain Management", "contact": "3.0", "credits": "3.00"}
      ]}
    ]'::jsonb,
    "coursePlanPdfUrl"      = '/assets/regular-mba-course-structure.pdf',
    "coursePlanPdfFileName" = 'regular-mba-course-structure.pdf',
    "updatedAt" = NOW()
WHERE "slug" = 'regular-mba';

-- ── EMBA (54 credits) ───────────────────────────────────────────────────
UPDATE "program"
SET "courseStructureTotal" = 'Total 54 Credits',
    "majorOptionsNote" = 'Students will have to select all courses of any major option from I to VII below, in addition to BA 5000, BA 5001 and BA 5305.',
    "courseStructure" = '[
      {"title": "1st Semester", "courses": [
        {"code": "BA 5101", "title": "Introduction to Business",  "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5102", "title": "Principles of Accounting",  "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5103", "title": "Principles of Management",  "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5104", "title": "Principles of Marketing",   "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5105", "title": "Business Communication",    "contact": "3.0", "credits": "3.00"}
      ], "footer": "Contact hours: 15.0 hrs./week · Total credits: 15.00 · No. of theory courses: 5"},
      {"title": "2nd Semester", "courses": [
        {"code": "BA 5201",  "title": "Organizational Behavior",    "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5202",  "title": "Business Research Methods",  "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5203",  "title": "Principles of Finance",      "contact": "3.0", "credits": "3.00"},
        {"code": "Hum 5204", "title": "Micro and Macroeconomics",   "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5205",  "title": "Strategic Management",       "contact": "3.0", "credits": "3.00"}
      ], "footer": "Contact hours: 15.0 hrs./week · Total credits: 15.00 · No. of theory courses: 5"},
      {"title": "3rd Semester", "note": "Major option courses are listed below. The following are compulsory for every option.", "courses": [
        {"code": "BA 5305", "title": "Legal Environment to Business",  "contact": "3.0",  "credits": "3.00"},
        {"code": "BA 5001", "title": "Comprehensive Viva-Voce",        "contact": "---",  "credits": "3.00"},
        {"code": "BA 5000", "title": "Thesis (Report & Defense)",      "contact": "12.0", "credits": "6.00"}
      ], "footer": "Contact hours: 27.0 hrs./week · Total credits: 24.00 · No. of theory courses: 5"}
    ]'::jsonb,
    "majorOptions" = '[
      {"roman": "I", "name": "Management", "courses": [
        {"code": "BA 5311", "title": "Small Business Management",                   "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5312", "title": "Total Quality Management",                    "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5313", "title": "Organizational Development and Change",       "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5314", "title": "Management Science Applications in Business", "contact": "3.0", "credits": "3.00"}
      ]},
      {"roman": "II", "name": "Human Resource Management", "courses": [
        {"code": "BA 5321", "title": "Human Resource Planning",              "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5322", "title": "Compensation Management",              "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5323", "title": "Industrial Law and Labor Relations",   "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5324", "title": "Training and Development Management",  "contact": "3.0", "credits": "3.00"}
      ]},
      {"roman": "III", "name": "Accounting & Information Systems", "courses": [
        {"code": "BA 5331", "title": "Accounting Information Systems",       "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5332", "title": "Advanced Auditing",                    "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5333", "title": "Advanced Taxation",                    "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5334", "title": "International Accounting Standards",   "contact": "3.0", "credits": "3.00"}
      ]},
      {"roman": "IV", "name": "Finance", "courses": [
        {"code": "BA 5341", "title": "Corporate Finance",                            "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5342", "title": "Investment Analysis and Portfolio Management", "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5343", "title": "Bank Management",                              "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5344", "title": "Financial Market and Institutions",            "contact": "3.0", "credits": "3.00"}
      ]},
      {"roman": "V", "name": "Marketing", "courses": [
        {"code": "BA 5351", "title": "Consumer Behavior",                "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5352", "title": "Brand Management and Strategy",    "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5353", "title": "International Service Marketing",  "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5354", "title": "Marketing Research",               "contact": "3.0", "credits": "3.00"}
      ]},
      {"roman": "VI", "name": "Management Information Systems", "courses": [
        {"code": "BA 5361", "title": "Advanced Programming Concepts",     "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5362", "title": "Networking and Operating System",   "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5363", "title": "Database Systems",                  "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5364", "title": "E-Commerce and Web Programming",    "contact": "3.0", "credits": "3.00"}
      ]},
      {"roman": "VII", "name": "Supply Chain Management", "courses": [
        {"code": "BA 5371", "title": "Sourcing and Operations in Procurement and Supply Chain Management", "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5372", "title": "Inventory and Logistics Operations",                                 "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5373", "title": "Strategic Supply Chain Management",                                  "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5374", "title": "Managing Contracts and Relationships in Procurement and Supply Chain Management", "contact": "3.0", "credits": "3.00"}
      ]}
    ]'::jsonb,
    "coursePlanPdfUrl"      = '/assets/emba-course-structure.pdf',
    "coursePlanPdfFileName" = 'emba-course-structure.pdf',
    "updatedAt" = NOW()
WHERE "slug" = 'emba';

-- ── MBM (69 credits, no major options) ──────────────────────────────────
UPDATE "program"
SET "courseStructureTotal" = 'Total 69 Credits',
    "majorOptions" = '[]'::jsonb,
    "majorOptionsNote" = NULL,
    "courseStructure" = '[
      {"title": "1st Semester", "courses": [
        {"code": "BA 5101",   "title": "Introduction to Business",              "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5102",   "title": "Business Communication",                "contact": "3.0", "credits": "3.00"},
        {"code": "Math 5103", "title": "Business Mathematics",                  "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5104",   "title": "Financial and Managerial Accounting",   "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5105",   "title": "Fundamentals of Management",            "contact": "3.0", "credits": "3.00"}
      ], "footer": "Contact hours: 15.0 hrs./week · Total credits: 15.00 · No. of theory courses: 5"},
      {"title": "2nd Semester", "courses": [
        {"code": "Math 5201", "title": "Business Statistics",                    "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5202",   "title": "Marketing Management",                   "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5203",   "title": "Financial Management",                   "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5204",   "title": "Principles and Practices of Banking",    "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5205",   "title": "Commercial Bank Management",             "contact": "3.0", "credits": "3.00"}
      ], "footer": "Contact hours: 15.0 hrs./week · Total credits: 15.00 · No. of theory courses: 5"},
      {"title": "3rd Semester", "courses": [
        {"code": "BA 5301", "title": "Investment and Merchant Banking",                  "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5302", "title": "International Trade Payment and Finance",          "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5303", "title": "Central Banking, Regulations and Supervision",     "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5304", "title": "Risk Management in Banking",                       "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5305", "title": "Strategic Management",                             "contact": "3.0", "credits": "3.00"}
      ], "footer": "Contact hours: 15.0 hrs./week · Total credits: 15.00 · No. of theory courses: 5"},
      {"title": "4th Semester", "courses": [
        {"code": "Hum 5401", "title": "Managerial Economics",                                 "contact": "3.0",  "credits": "3.00"},
        {"code": "BA 5402",  "title": "Project Appraisal and Management",                     "contact": "3.0",  "credits": "3.00"},
        {"code": "BA 5403",  "title": "E-Banking and Management Information Systems",         "contact": "3.0",  "credits": "3.00"},
        {"code": "BA 5404",  "title": "Islamic Banking and Finance",                          "contact": "3.0",  "credits": "3.00"},
        {"code": "BA 5405",  "title": "Micro Finance and Rural Banking",                      "contact": "3.0",  "credits": "3.00"},
        {"code": "BA 5001",  "title": "Comprehensive Viva-Voce",                              "contact": "----", "credits": "3.00"},
        {"code": "BA 5000",  "title": "Thesis (Report & Defense)",                            "contact": "12.0", "credits": "6.00"}
      ], "footer": "Contact hours: 27.0 hrs./week · Total credits: 24.00 · No. of theory courses: 5"}
    ]'::jsonb,
    "coursePlanPdfUrl"      = '/assets/mbm-course-structure.pdf',
    "coursePlanPdfFileName" = 'mbm-course-structure.pdf',
    "updatedAt" = NOW()
WHERE "slug" = 'mbm';

-- ── MBA in Supply Chain Management (69 credits, no major options) ───────
UPDATE "program"
SET "courseStructureTotal" = 'Total 69 Credits',
    "majorOptions" = '[]'::jsonb,
    "majorOptionsNote" = NULL,
    "courseStructure" = '[
      {"title": "1st Semester", "courses": [
        {"code": "BA 5101", "title": "Introduction to Business",  "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5102", "title": "Principles of Accounting",  "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5103", "title": "Principles of Management",  "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5104", "title": "Principles of Marketing",   "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5105", "title": "Business Communication",    "contact": "3.0", "credits": "3.00"}
      ], "footer": "Contact hours: 15.0 hrs./week · Total credits: 15.00 · No. of theory courses: 5"},
      {"title": "2nd Semester", "courses": [
        {"code": "CSE 5201", "title": "Computer Application in Business",                              "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5202",  "title": "Principles of Finance",                                         "contact": "3.0", "credits": "3.00"},
        {"code": "Hum 5203", "title": "Micro and Macroeconomics",                                      "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5204",  "title": "Legal Environment of Business",                                 "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5205",  "title": "Sourcing and Operations in Procurement and Supply Chain Management", "contact": "3.0", "credits": "3.00"}
      ], "footer": "Contact hours: 15.0 hrs./week · Total credits: 15.00 · No. of theory courses: 5"},
      {"title": "3rd Semester", "courses": [
        {"code": "BA 5301", "title": "Inventory and Logistics Operations",                                    "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5302", "title": "Managing Risks in Supply Chain Management",                             "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5303", "title": "Principles of Procurement and Supply Chain Management",                 "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5304", "title": "Strategic Supply Chain Management",                                     "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5305", "title": "Performance Measurement and Sustainability in Supply Chain Management", "contact": "3.0", "credits": "3.00"}
      ], "footer": "Contact hours: 15.0 hrs./week · Total credits: 15.00 · No. of theory courses: 5"},
      {"title": "4th Semester", "courses": [
        {"code": "BA 5401", "title": "Program and Project Management",                                          "contact": "3.0",  "credits": "3.00"},
        {"code": "BA 5402", "title": "Managing Contracts and Relationships in Procurement and Supply Chain Management", "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5403", "title": "Operations Management in Supply Chain Management",                        "contact": "3.0",  "credits": "3.00"},
        {"code": "BA 5404", "title": "Managing Service for Excellence Supply Chain Management",                 "contact": "3.0",  "credits": "3.00"},
        {"code": "BA 5405", "title": "Corporate and Business Strategy for Supply Chain Management",             "contact": "3.0",  "credits": "3.00"},
        {"code": "BA 5001", "title": "Comprehensive Viva-Voce",                                                 "contact": "----", "credits": "3.00"},
        {"code": "BA 5000", "title": "Thesis (Report & Defense)",                                               "contact": "12.0", "credits": "6.00"}
      ], "footer": "Contact hours: 27.0 hrs./week · Total credits: 24.00 · No. of theory courses: 5"}
    ]'::jsonb,
    "coursePlanPdfUrl"      = '/assets/mba-scm-course-structure.pdf',
    "coursePlanPdfFileName" = 'mba-scm-course-structure.pdf',
    "updatedAt" = NOW()
WHERE "slug" = 'mba-supply-chain-management';

-- ── MBA in Apparel Merchandising (60 credits, no major options) ─────────
UPDATE "program"
SET "courseStructureTotal" = 'Total 60 Credits',
    "majorOptions" = '[]'::jsonb,
    "majorOptionsNote" = NULL,
    "courseStructure" = '[
      {"title": "1st Semester", "courses": [
        {"code": "TE 5101",  "title": "Textile Science: Fiber-yarn-Fabric",              "contact": "3.0", "credits": "3.00"},
        {"code": "AMT 5101", "title": "Clothing Materials & Production Technology",      "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5101",  "title": "Electronic Commerce",                             "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5103",  "title": "Management Information System (MIS)",             "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5105",  "title": "Marketing Management",                            "contact": "3.0", "credits": "3.00"}
      ], "footer": "Contact hours: 15.0 (T) + 0.0 (S) = 15.0 hrs./week · Total credits: 15.00 · Theory: 5 · Sessional: 0"},
      {"title": "2nd Semester", "courses": [
        {"code": "AMT 5201", "title": "Apparel Merchandising Management",                "contact": "3.0", "credits": "3.00"},
        {"code": "AMT 5203", "title": "TQM & Compliances",                               "contact": "3.0", "credits": "3.00"},
        {"code": "AMT 5205", "title": "Entrepreneurship in RMG Business",                "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5201",  "title": "Human Resources Management and Factory Laws",     "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5203",  "title": "Financial Accounting",                            "contact": "3.0", "credits": "3.00"}
      ], "footer": "Contact hours: 15.0 (T) + 0.0 (S) = 15.0 hrs./week · Total credits: 15.00 · Theory: 5 · Sessional: 0"},
      {"title": "3rd Semester", "courses": [
        {"code": "AMT 5301", "title": "CAD Applications in Apparel Industry",            "contact": "3.0", "credits": "3.00"},
        {"code": "TE 5301",  "title": "Dying, Printing and Finishing",                   "contact": "3.0", "credits": "3.00"},
        {"code": "TE 5303",  "title": "Cut & Sew Knitwear Technology",                   "contact": "3.0", "credits": "3.00"},
        {"code": "AMT 5303", "title": "Garments Construction & Engineering",             "contact": "3.0", "credits": "3.00"}
      ], "footer": "Contact hours: 12.0 (T) + 0.0 (S) = 12.0 hrs./week · Total credits: 12.00 · Theory: 4 · Sessional: 0"},
      {"title": "4th Semester", "courses": [
        {"code": "AMT 5401", "title": "Production and Operation Management",             "contact": "3.0", "credits": "3.00"},
        {"code": "TE 5401",  "title": "Fully Fashioned Knitwear",                        "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5401",  "title": "International Trade in Export-Import Management", "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5403",  "title": "Fashion Marketing",                               "contact": "3.0", "credits": "3.00"},
        {"code": "MAM 5400", "title": "Project & Thesis (Sessional)",                    "contact": "6.0", "credits": "3.00"}
      ], "footer": "Contact hours: 12.0 (T) + 6.0 (S) = 18.0 hrs./week · Total credits: 15.00 · Theory: 4 · Sessional: 1"},
      {"title": "Industrial Attachment (8 weeks)", "courses": [
        {"code": "MAM 5002", "title": "Industrial Attachment (8 weeks)",                 "contact": "--", "credits": "3.00"}
      ]}
    ]'::jsonb,
    "coursePlanPdfUrl"      = '/assets/mba-am-course-structure.pdf',
    "coursePlanPdfFileName" = 'mba-am-course-structure.pdf',
    "updatedAt" = NOW()
WHERE "slug" = 'mba-apparel-merchandising';

-- ── MBA in Textile & Fashion Marketing (69 credits, no major options) ───
UPDATE "program"
SET "courseStructureTotal" = 'Total 69 Credits',
    "majorOptions" = '[]'::jsonb,
    "majorOptionsNote" = NULL,
    "courseStructure" = '[
      {"title": "1st Semester", "courses": [
        {"code": "TE 5101",  "title": "Textile Science: Fiber-yarn-Fabric",              "contact": "3.0", "credits": "3.00"},
        {"code": "AMT 5101", "title": "Clothing Materials & Production Technology",      "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5101",  "title": "Electronic Commerce",                             "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5103",  "title": "Management Information System (MIS)",             "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5105",  "title": "Marketing Management",                            "contact": "3.0", "credits": "3.00"}
      ], "footer": "Contact hours: 15.0 (T) + 0.0 (S) = 15.0 hrs./week · Total credits: 15.00 · Theory: 5 · Sessional: 0"},
      {"title": "2nd Semester", "courses": [
        {"code": "AMT 5201", "title": "Apparel Merchandising Management",                        "contact": "3.0", "credits": "3.00"},
        {"code": "AMT 5203", "title": "TQM & Compliances",                                       "contact": "3.0", "credits": "3.00"},
        {"code": "AMT 5205", "title": "Entrepreneurship in RMG Business",                        "contact": "3.0", "credits": "3.00"},
        {"code": "FDT 5200", "title": "Fashion Retailing & Visual Merchandising (Sessional)",    "contact": "6.0", "credits": "3.00"},
        {"code": "FDT 5202", "title": "Pattern Cutting for Women''s Wear (Sessional)",           "contact": "6.0", "credits": "3.00"}
      ], "footer": "Contact hours: 9.0 (T) + 12.0 (S) = 21.0 hrs./week · Total credits: 15.00 · Theory: 3 · Sessional: 2"},
      {"title": "3rd Semester", "courses": [
        {"code": "BA 5301",  "title": "Consumer Behavior",                                       "contact": "3.0", "credits": "3.00"},
        {"code": "TE 5301",  "title": "Dying, Printing and Finishing",                           "contact": "3.0", "credits": "3.00"},
        {"code": "AMT 5301", "title": "Sourcing & Negotiation Techniques",                       "contact": "3.0", "credits": "3.00"},
        {"code": "TE 5303",  "title": "Cut & Sew Knitwear Technology",                           "contact": "3.0", "credits": "3.00"},
        {"code": "FDT 5300", "title": "Market Research and Product Development (Sessional)",     "contact": "6.0", "credits": "3.00"},
        {"code": "FDT 5302", "title": "Fashion Forecasting & Trend Analysis (Sessional)",        "contact": "6.0", "credits": "3.00"}
      ], "footer": "Contact hours: 12.0 (T) + 12.0 (S) = 24.0 hrs./week · Total credits: 18.00 · Theory: 4 · Sessional: 2"},
      {"title": "4th Semester", "courses": [
        {"code": "AMT 5401", "title": "Production and Operation Management",                     "contact": "3.0", "credits": "3.00"},
        {"code": "TE 5401",  "title": "Fully Fashioned Knitwear",                                "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5401",  "title": "International Trade in Export-Import Management",         "contact": "3.0", "credits": "3.00"},
        {"code": "BA 5403",  "title": "Fashion Marketing",                                       "contact": "3.0", "credits": "3.00"},
        {"code": "FDT 5400", "title": "Pattern Cutting for Men''s Wear (Sessional)",             "contact": "6.0", "credits": "3.00"},
        {"code": "TFM 5400", "title": "Project & Thesis (Sessional)",                            "contact": "6.0", "credits": "3.00"}
      ], "footer": "Contact hours: 12.0 (T) + 12.0 (S) = 24.0 hrs./week · Total credits: 18.00 · Theory: 4 · Sessional: 2"},
      {"title": "Industrial Attachment (8 weeks)", "courses": [
        {"code": "TFM 5002", "title": "Industrial Attachment",                                   "contact": "--", "credits": "3.00"}
      ]}
    ]'::jsonb,
    "coursePlanPdfUrl"      = '/assets/mba-tfm-course-structure.pdf',
    "coursePlanPdfFileName" = 'mba-tfm-course-structure.pdf',
    "updatedAt" = NOW()
WHERE "slug" = 'mba-textile-fashion-marketing';
