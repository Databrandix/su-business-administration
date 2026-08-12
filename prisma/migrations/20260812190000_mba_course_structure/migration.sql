-- Course plan for the 1-Year MBA, seeded from the department's
-- MBA-OBE Course Plan document.
--
-- Transcription note: on the major-options page the PDF's table cells are
-- offset for options I–III, printing each title one row above its code.
-- Pairs were rebuilt from the code sequence (BA 52X1..52X4 per option),
-- which is regular across all seven options and extracts cleanly for
-- options IV–VII — those correct rows confirm the shift applied to I–III.
--
-- Credits reconcile with the document: 15.00 (1st semester) + 12.00 (one
-- major track, 4 × 3.00) + 12.00 (compulsory: BA 5205 3.00, BA 5001 3.00,
-- BA 5000 6.00) = 39.00, the stated program total.
UPDATE "program"
SET "courseStructureTotal" = 'Total 39 Credits',
    "majorOptionsNote" = 'Students will have to select all courses of any major option from I to VII below, in addition to BA 5000, BA 5001 and BA 5205.',
    "courseStructure" = '[
      {
        "title": "1st Semester",
        "courses": [
          {"code": "BA 5101", "title": "Advanced Financial Reporting",           "contact": "3.0", "credits": "3.00"},
          {"code": "BA 5102", "title": "Advanced Financial Management",          "contact": "3.0", "credits": "3.00"},
          {"code": "BA 5103", "title": "Strategic Marketing",                    "contact": "3.0", "credits": "3.00"},
          {"code": "BA 5104", "title": "Organization Strategy and Leadership",   "contact": "3.0", "credits": "3.00"},
          {"code": "BA 5105", "title": "Corporate Tax Planning",                 "contact": "3.0", "credits": "3.00"}
        ],
        "footer": "Contact hours: 15.0 hrs./week · Total credits: 15.00 · No. of theory courses: 5"
      },
      {
        "title": "2nd Semester",
        "note": "Major option courses are listed below. The following are compulsory for every option.",
        "courses": [
          {"code": "BA 5205", "title": "Advanced Research Methodology",     "contact": "3.0",  "credits": "3.00"},
          {"code": "BA 5001", "title": "Comprehensive Viva-Voce",           "contact": "----", "credits": "3.00"},
          {"code": "BA 5000", "title": "Thesis (Report & Defense)",         "contact": "12.0", "credits": "6.00"}
        ],
        "footer": "Contact hours: 27.0 hrs./week · Total credits: 24.00 · No. of theory courses: 5"
      }
    ]'::jsonb,
    "majorOptions" = '[
      {
        "roman": "I",
        "name": "Management",
        "courses": [
          {"code": "BA 5211", "title": "Small Business Management",                "contact": "3.0", "credits": "3.00"},
          {"code": "BA 5212", "title": "Total Quality Management",                 "contact": "3.0", "credits": "3.00"},
          {"code": "BA 5213", "title": "Organizational Development and Change",    "contact": "3.0", "credits": "3.00"},
          {"code": "BA 5214", "title": "Management Science Applications in Business", "contact": "3.0", "credits": "3.00"}
        ]
      },
      {
        "roman": "II",
        "name": "Human Resource Management",
        "courses": [
          {"code": "BA 5221", "title": "Human Resource Planning",                 "contact": "3.0", "credits": "3.00"},
          {"code": "BA 5222", "title": "Compensation Management",                 "contact": "3.0", "credits": "3.00"},
          {"code": "BA 5223", "title": "Industrial Law and Labor Relations",      "contact": "3.0", "credits": "3.00"},
          {"code": "BA 5224", "title": "Training and Development Management",     "contact": "3.0", "credits": "3.00"}
        ]
      },
      {
        "roman": "III",
        "name": "Accounting & Information Systems",
        "courses": [
          {"code": "BA 5231", "title": "Accounting Information Systems",          "contact": "3.0", "credits": "3.00"},
          {"code": "BA 5232", "title": "Advanced Auditing",                       "contact": "3.0", "credits": "3.00"},
          {"code": "BA 5233", "title": "Advanced Taxation",                       "contact": "3.0", "credits": "3.00"},
          {"code": "BA 5234", "title": "International Accounting Standards",      "contact": "3.0", "credits": "3.00"}
        ]
      },
      {
        "roman": "IV",
        "name": "Finance",
        "courses": [
          {"code": "BA 5241", "title": "Corporate Finance",                             "contact": "3.0", "credits": "3.00"},
          {"code": "BA 5242", "title": "Investment Analysis and Portfolio Management",  "contact": "3.0", "credits": "3.00"},
          {"code": "BA 5243", "title": "Bank Management",                               "contact": "3.0", "credits": "3.00"},
          {"code": "BA 5244", "title": "Financial Market and Institutions",             "contact": "3.0", "credits": "3.00"}
        ]
      },
      {
        "roman": "V",
        "name": "Marketing",
        "courses": [
          {"code": "BA 5251", "title": "Consumer Behavior",                   "contact": "3.0", "credits": "3.00"},
          {"code": "BA 5252", "title": "Brand Management and Strategy",       "contact": "3.0", "credits": "3.00"},
          {"code": "BA 5253", "title": "International Service Marketing",     "contact": "3.0", "credits": "3.00"},
          {"code": "BA 5254", "title": "Marketing Research",                  "contact": "3.0", "credits": "3.00"}
        ]
      },
      {
        "roman": "VI",
        "name": "Management Information Systems",
        "courses": [
          {"code": "BA 5261", "title": "Advanced Programming Concepts",       "contact": "3.0", "credits": "3.00"},
          {"code": "BA 5262", "title": "Networking and Operating System",     "contact": "3.0", "credits": "3.00"},
          {"code": "BA 5263", "title": "Database Systems",                    "contact": "3.0", "credits": "3.00"},
          {"code": "BA 5264", "title": "E-Commerce and Web Programming",      "contact": "3.0", "credits": "3.00"}
        ]
      },
      {
        "roman": "VII",
        "name": "Supply Chain Management",
        "courses": [
          {"code": "BA 5271", "title": "Sourcing and Operations in Procurement and Supply Chain Management", "contact": "3.0", "credits": "3.00"},
          {"code": "BA 5272", "title": "Inventory and Logistics Operations",                                 "contact": "3.0", "credits": "3.00"},
          {"code": "BA 5273", "title": "Strategic Supply Chain Management",                                  "contact": "3.0", "credits": "3.00"},
          {"code": "BA 5274", "title": "Managing Contracts and Relationships in Procurement and Supply Chain Management", "contact": "3.0", "credits": "3.00"}
        ]
      }
    ]'::jsonb,
    "coursePlanPdfUrl"      = '/assets/mba-course-structure.pdf',
    "coursePlanPdfFileName" = 'mba-course-structure.pdf',
    "updatedAt" = NOW()
WHERE "slug" = 'mba';
