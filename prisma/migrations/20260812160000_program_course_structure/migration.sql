-- Course plan for /programs/<slug>. Stored per-Program rather than as a
-- shared singleton because each degree has its own curriculum.
ALTER TABLE "program"
    ADD COLUMN "courseStructure"      JSONB NOT NULL DEFAULT '[]',
    ADD COLUMN "majorOptions"         JSONB NOT NULL DEFAULT '[]',
    ADD COLUMN "majorOptionsNote"     TEXT,
    ADD COLUMN "courseStructureTotal" TEXT;

-- Seeded from the department's BBA-OBE Course Plan document.
--
-- Two transcription notes:
--   * 1st Year 2nd Semester course 5 (Hum 1205) is a Bengali title that
--     the source PDF encodes in a legacy non-Unicode font; it extracts as
--     mojibake. The English name is used until the Bengali is supplied.
--   * On the 4th-year major-options page the PDF's table cells are offset,
--     printing each title one row above its code. Pairs were rebuilt from
--     the code sequence (BA 42X1..42X6 per option), which is regular
--     across all seven options.
UPDATE "program"
SET "courseStructureTotal" = 'Total 141 Credits',
    "majorOptionsNote" = 'Students will have to select all the courses of any one major option from I to VII below, in addition to BA 4201.',
    "courseStructure" = '[
      {
        "title": "1st Year 1st Semester",
        "courses": [
          {"code": "BA 1101",   "title": "Introduction to Business",              "contact": "3.0", "credits": "3.00"},
          {"code": "Hum 1102",  "title": "English-I",                             "contact": "3.0", "credits": "3.00"},
          {"code": "BA 1103",   "title": "Principles of Accounting",              "contact": "3.0", "credits": "3.00"},
          {"code": "Math 1104", "title": "Business Mathematics",                  "contact": "3.0", "credits": "3.00"},
          {"code": "CSE 1105",  "title": "Computer Applications in Business",     "contact": "3.0", "credits": "3.00"}
        ],
        "footer": "Contact hours: 15.0 hrs./week · Total credits: 15.00 · No. of theory courses: 5"
      },
      {
        "title": "1st Year 2nd Semester",
        "courses": [
          {"code": "Hum 1201", "title": "Bangladesh Studies",                 "contact": "3.0",  "credits": "3.00"},
          {"code": "BA 1202",  "title": "Business Statistics",                "contact": "3.0",  "credits": "3.00"},
          {"code": "Hum 1203", "title": "English-II",                         "contact": "3.0",  "credits": "3.00"},
          {"code": "BA 1204",  "title": "Legal Environment of Business",      "contact": "3.0",  "credits": "3.00"},
          {"code": "Hum 1205", "title": "History of the Emergence of Bangladesh", "contact": "3.0", "credits": "3.00"},
          {"code": "BA 4201",  "title": "Viva-Voce on 1st Year Courses",      "contact": "----", "credits": "0.75"}
        ],
        "footer": "Contact hours: 15.0 hrs./week · Total credits: 15.75 · No. of theory courses: 5"
      },
      {
        "title": "2nd Year 1st Semester",
        "courses": [
          {"code": "Hum 2101", "title": "Microeconomics",         "contact": "3.0", "credits": "3.00"},
          {"code": "Ban 2102", "title": "Bangla",                 "contact": "3.0", "credits": "3.00"},
          {"code": "BA 2103",  "title": "Business Communication", "contact": "3.0", "credits": "3.00"},
          {"code": "BA 2104",  "title": "Principles of Finance",  "contact": "3.0", "credits": "3.00"},
          {"code": "BA 2105",  "title": "Brand Management",       "contact": "3.0", "credits": "3.00"}
        ],
        "footer": "Contact hours: 15.0 hrs./week · Total credits: 15.00 · No. of theory courses: 5"
      },
      {
        "title": "2nd Year 2nd Semester",
        "courses": [
          {"code": "Hum 2201", "title": "Macroeconomics",              "contact": "3.0",  "credits": "3.00"},
          {"code": "BA 2202",  "title": "Principles of Management",    "contact": "3.0",  "credits": "3.00"},
          {"code": "BA 2203",  "title": "Auditing and Taxation",       "contact": "3.0",  "credits": "3.00"},
          {"code": "BA 2204",  "title": "Intermediate Accounting",     "contact": "3.0",  "credits": "3.00"},
          {"code": "BA 2205",  "title": "Financial Management",        "contact": "3.0",  "credits": "3.00"},
          {"code": "BA 2206",  "title": "Entrepreneurship Development","contact": "3.0",  "credits": "3.00"},
          {"code": "BA 4201",  "title": "Viva-Voce on 2nd Year Courses","contact": "----","credits": "0.75"}
        ],
        "footer": "Contact hours: 18.0 hrs./week · Total credits: 18.75 · No. of theory courses: 6"
      },
      {
        "title": "3rd Year 1st Semester",
        "courses": [
          {"code": "BA 3101", "title": "Principles of Marketing",              "contact": "3.0", "credits": "3.00"},
          {"code": "BA 3102", "title": "Organizational Behavior",              "contact": "3.0", "credits": "3.00"},
          {"code": "BA 3103", "title": "International Business Management",    "contact": "3.0", "credits": "3.00"},
          {"code": "BA 3104", "title": "Labor Law",                            "contact": "3.0", "credits": "3.00"},
          {"code": "BA 3105", "title": "SME Management",                       "contact": "3.0", "credits": "3.00"},
          {"code": "BA 3106", "title": "Human Resource Management",            "contact": "3.0", "credits": "3.00"}
        ],
        "footer": "Contact hours: 18.0 hrs./week · Total credits: 18.00 · No. of theory courses: 6"
      },
      {
        "title": "3rd Year 2nd Semester",
        "courses": [
          {"code": "BA 3201", "title": "Marketing Management",                          "contact": "3.0",  "credits": "3.00"},
          {"code": "BA 3202", "title": "Business Research Methods",                     "contact": "3.0",  "credits": "3.00"},
          {"code": "BA 3203", "title": "Production and Operations Management",          "contact": "3.0",  "credits": "3.00"},
          {"code": "BA 3204", "title": "Fundamentals of MIS",                           "contact": "3.0",  "credits": "3.00"},
          {"code": "BA 3205", "title": "Digital Marketing",                             "contact": "3.0",  "credits": "3.00"},
          {"code": "BA 3206", "title": "Developing Individuals, Teams and Organizations","contact": "3.0", "credits": "3.00"},
          {"code": "BA 4201", "title": "Viva-Voce on 3rd Year Courses",                 "contact": "----", "credits": "0.75"}
        ],
        "footer": "Contact hours: 18.0 hrs./week · Total credits: 18.75 · No. of theory courses: 6"
      },
      {
        "title": "4th Year 1st Semester",
        "courses": [
          {"code": "BA 4101", "title": "Project Management",                          "contact": "3.0", "credits": "3.00"},
          {"code": "BA 4102", "title": "Principles of Banking",                        "contact": "3.0", "credits": "3.00"},
          {"code": "BA 4103", "title": "Cost and Management Accounting",               "contact": "3.0", "credits": "3.00"},
          {"code": "BA 4104", "title": "Principles & Practices of Insurance",          "contact": "3.0", "credits": "3.00"},
          {"code": "BA 4105", "title": "Strategic Management",                         "contact": "3.0", "credits": "3.00"},
          {"code": "BA 4106", "title": "Tapping into New and International Market",    "contact": "3.0", "credits": "3.00"}
        ],
        "footer": "Contact hours: 18.0 hrs./week · Total credits: 18.00 · No. of theory courses: 6"
      },
      {
        "title": "4th Year 2nd Semester",
        "note": "Major option courses are listed below. BA 4201 is compulsory for every option.",
        "courses": [
          {"code": "BA 4201", "title": "Viva-Voce on 4th Year Courses (Compulsory)", "contact": "----", "credits": "0.75"}
        ],
        "footer": "Contact hours: 18.0 hrs./week · Total credits: 18.75 · No. of theory courses: 6"
      },
      {
        "title": "Internship (12 Weeks)",
        "courses": [
          {"code": "BA 4000", "title": "Internship", "contact": "6.0", "credits": "3.00"}
        ]
      }
    ]'::jsonb,
    "majorOptions" = '[
      {
        "roman": "I",
        "name": "Management",
        "courses": [
          {"code": "BA 4211", "title": "Management Consultancy",                      "contact": "3.0", "credits": "3.00"},
          {"code": "BA 4212", "title": "Small Business Management",                   "contact": "3.0", "credits": "3.00"},
          {"code": "BA 4213", "title": "Total Quality Management",                    "contact": "3.0", "credits": "3.00"},
          {"code": "BA 4214", "title": "Organizational Development and Change",       "contact": "3.0", "credits": "3.00"},
          {"code": "BA 4215", "title": "Comparative Management",                      "contact": "3.0", "credits": "3.00"},
          {"code": "BA 4216", "title": "Management Science Applications in Business", "contact": "3.0", "credits": "3.00"}
        ]
      },
      {
        "roman": "II",
        "name": "Human Resource Management",
        "courses": [
          {"code": "BA 4221", "title": "Human Resource Planning",              "contact": "3.0", "credits": "3.00"},
          {"code": "BA 4222", "title": "Compensation Management",              "contact": "3.0", "credits": "3.00"},
          {"code": "BA 4223", "title": "Industrial Law and Labor Relations",   "contact": "3.0", "credits": "3.00"},
          {"code": "BA 4224", "title": "Training and Development Management",  "contact": "3.0", "credits": "3.00"},
          {"code": "BA 4225", "title": "Strategic Human Resource Management",  "contact": "3.0", "credits": "3.00"},
          {"code": "BA 4226", "title": "Small Business Management",            "contact": "3.0", "credits": "3.00"}
        ]
      },
      {
        "roman": "III",
        "name": "Accounting & Information Systems",
        "courses": [
          {"code": "BA 4231", "title": "Advanced Financial Accounting",        "contact": "3.0", "credits": "3.00"},
          {"code": "BA 4232", "title": "Accounting Information Systems",       "contact": "3.0", "credits": "3.00"},
          {"code": "BA 4233", "title": "Advanced Auditing",                    "contact": "3.0", "credits": "3.00"},
          {"code": "BA 4234", "title": "Advanced Taxation",                    "contact": "3.0", "credits": "3.00"},
          {"code": "BA 4235", "title": "Advanced Cost Accounting",             "contact": "3.0", "credits": "3.00"},
          {"code": "BA 4236", "title": "International Accounting Standards",   "contact": "3.0", "credits": "3.00"}
        ]
      },
      {
        "roman": "IV",
        "name": "Finance",
        "courses": [
          {"code": "BA 4241", "title": "Corporate Finance",                              "contact": "3.0", "credits": "3.00"},
          {"code": "BA 4242", "title": "Investment Analysis and Portfolio Management",   "contact": "3.0", "credits": "3.00"},
          {"code": "BA 4243", "title": "International Financial Management",             "contact": "3.0", "credits": "3.00"},
          {"code": "BA 4244", "title": "Financial Derivatives",                          "contact": "3.0", "credits": "3.00"},
          {"code": "BA 4245", "title": "Financial Market and Institutions",              "contact": "3.0", "credits": "3.00"},
          {"code": "BA 4246", "title": "Bank Management",                                "contact": "3.0", "credits": "3.00"}
        ]
      },
      {
        "roman": "V",
        "name": "Marketing",
        "courses": [
          {"code": "BA 4251", "title": "Consumer Behavior",                       "contact": "3.0", "credits": "3.00"},
          {"code": "BA 4252", "title": "Sales Management",                        "contact": "3.0", "credits": "3.00"},
          {"code": "BA 4253", "title": "Promotional Management and Strategy",     "contact": "3.0", "credits": "3.00"},
          {"code": "BA 4254", "title": "International Marketing",                 "contact": "3.0", "credits": "3.00"},
          {"code": "BA 4255", "title": "Service Marketing",                       "contact": "3.0", "credits": "3.00"},
          {"code": "BA 4256", "title": "Retail Management",                       "contact": "3.0", "credits": "3.00"}
        ]
      },
      {
        "roman": "VI",
        "name": "Management Information Systems",
        "courses": [
          {"code": "BA 4261", "title": "Advanced Programming Concepts",          "contact": "3.0", "credits": "3.00"},
          {"code": "BA 4262", "title": "Information System",                     "contact": "3.0", "credits": "3.00"},
          {"code": "BA 4263", "title": "Networking and Operating System",        "contact": "3.0", "credits": "3.00"},
          {"code": "BA 4264", "title": "Relation Database Management System",    "contact": "3.0", "credits": "3.00"},
          {"code": "BA 4265", "title": "Database Systems",                       "contact": "3.0", "credits": "3.00"},
          {"code": "BA 4266", "title": "E-Commerce and Web Programming",         "contact": "3.0", "credits": "3.00"}
        ]
      },
      {
        "roman": "VII",
        "name": "Supply Chain Management",
        "courses": [
          {"code": "BA 4271", "title": "Sourcing and Operations in Procurement and Supply Chain Management",   "contact": "3.0", "credits": "3.00"},
          {"code": "BA 4272", "title": "Managing Risks in Supply Chain Management",                            "contact": "3.0", "credits": "3.00"},
          {"code": "BA 4273", "title": "Inventory and Logistics Operations",                                   "contact": "3.0", "credits": "3.00"},
          {"code": "BA 4274", "title": "Strategic Supply Chain Management",                                    "contact": "3.0", "credits": "3.00"},
          {"code": "BA 4275", "title": "Managing Contracts and Relationships in Procurement and Supply Chain Management", "contact": "3.0", "credits": "3.00"},
          {"code": "BA 4276", "title": "Managing Service for Excellence in Supply Chain Management",           "contact": "3.0", "credits": "3.00"}
        ]
      }
    ]'::jsonb,
    "updatedAt" = NOW()
WHERE "slug" = 'bba';
