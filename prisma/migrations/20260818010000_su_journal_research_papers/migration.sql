-- Backfill the 14 publications listed on su.edu.bd/research/bba_research
-- that were missing from research_paper.
--
-- The university page lists 16; two were already here and are skipped:
--   * "Service Quality Dimensions (SERVQUAL) ..."  (Sharmila Sikder)
--   * "Consideration of workers opinion ..."       (Md. Rasel Hawlader)
-- Both matched an existing title, so re-inserting them would have created
-- exactly the duplicates that /research now groups away.
--
-- One row per credited author, matching the existing convention -- the
-- public page groups rows sharing a title into a single card. Only
-- Md. Al-Amin Molla is current faculty, so he is the one author given a
-- facultySlug; every other name (former staff, plus co-authors from Dhaka
-- University, Heriot-Watt, HUST and UIBE) renders as plain text.
--
-- `area` holds the affiliation the source page prints under "Area of
-- Research", and `publisher` the journal where it is known. displayOrder
-- continues after the existing rows, keeping the department current
-- output at the top of /research.
--
-- Two titles are stored as the source prints them, truncated mid-phrase
-- in su.edu.bd own HTML (it cuts titles at ~100 characters) and not
-- recoverable from the linked PDFs, which are scanned page images:
--   * sup_04_* -- "... Companies Listed in"
--   * sup_11_* -- "... Micro Finance and Poor Access"
-- Left as-is rather than guessed at; complete them at
-- /admin/research-papers once the full wording is confirmed.
--
-- Links: the source page points two entries at "file:///C:/Users/User/..."
-- paths -- someone local Downloads folder, dead for every visitor. Those
-- are not stored. For the SERVQUAL paper the publisher URL was recoverable
-- and is applied to the existing row at the end of this migration; for
-- sup_01_a1 no public URL was found, so it has none.

INSERT INTO "research_paper"
  ("id", "title", "authors", "authorRole", "facultySlug", "area", "date",
   "publicationYear", "link", "publisher", "authorPosition",
   "displayOrder", "createdAt", "updatedAt")
VALUES
  ('sup_01_a1', 'Impact of Accounting Practices in Institutional Borrowing of SME Organizations: A Bangladesh Perspective', 'Md. Masud Rana', 'Assistant Professor, Department of Business Administration', NULL, 'Department of Business Administration, Sonargaon University (SU)', 'September 2021', 2021, NULL, NULL, 'Sole author', 40, NOW(), NOW()),
  ('sup_04_a1', 'Corporate Liquidity and Profitability Patterns of Selected Textile Manufacturing Companies Listed in', 'Md. Ahasan Uddin', NULL, NULL, 'Department of Accounting and Information System, Faculty of Business, University of Dhaka & Sonargaon University (SU)', '2016', 2016, 'https://su.edu.bd/web_assets/journal/journal1/9%20MA%20Uddin.pdf', 'Sonargaon University Journal', '1st', 41, NOW(), NOW()),
  ('sup_04_a2', 'Corporate Liquidity and Profitability Patterns of Selected Textile Manufacturing Companies Listed in', 'Mohammad Moniruzzaman, ACA', NULL, NULL, 'Department of Accounting and Information System, Faculty of Business, University of Dhaka & Sonargaon University (SU)', '2016', 2016, 'https://su.edu.bd/web_assets/journal/journal1/9%20MA%20Uddin.pdf', 'Sonargaon University Journal', '2nd', 42, NOW(), NOW()),
  ('sup_05_a1', 'Development and Potentials of Pharmaceutical Industry in Bangladesh: A Synopsis', 'Md. Fakhrul Alam', NULL, NULL, 'Healthcare Pharmaceutical Ltd., Gazipur, Bangladesh', '2016', 2016, 'https://su.edu.bd/web_assets/journal/journal1/7%20MF%20Alam.pdf', 'Sonargaon University Journal', 'Sole author', 43, NOW(), NOW()),
  ('sup_06_a1', 'Corporate Social Responsibility and its Impact on Corporate Profitability: Some Evidences from Selected Private Commercial Banks in Bangladesh', 'Abul Kalam', NULL, NULL, 'Department of Business Administration, Sonargaon University (SU)', '2016', 2016, 'https://su.edu.bd/web_assets/journal/journal1/4%20A%20Kalam.pdf', 'Sonargaon University Journal', 'Sole author', 44, NOW(), NOW()),
  ('sup_07_a1', 'Performance Evaluation of Cement Industry of Bangladesh: A Case Study on Some Selected Firms', 'Md. Al-Amin Molla', 'Professor & Dean', 'al-amin-mollah', 'Department of Business Administration, Sonargaon University (SU)', '2016', 2016, 'https://su.edu.bd/web_assets/journal/journal1/1%20MA%20Molla.pdf', 'Sonargaon University Journal', '1st', 45, NOW(), NOW()),
  ('sup_07_a2', 'Performance Evaluation of Cement Industry of Bangladesh: A Case Study on Some Selected Firms', 'Abdur Rahman Akram', NULL, NULL, 'Department of Business Administration, Sonargaon University (SU)', '2016', 2016, 'https://su.edu.bd/web_assets/journal/journal1/1%20MA%20Molla.pdf', 'Sonargaon University Journal', '2nd', 46, NOW(), NOW()),
  ('sup_07_a3', 'Performance Evaluation of Cement Industry of Bangladesh: A Case Study on Some Selected Firms', 'Tania Rahman', NULL, NULL, 'Department of Business Administration, Sonargaon University (SU)', '2016', 2016, 'https://su.edu.bd/web_assets/journal/journal1/1%20MA%20Molla.pdf', 'Sonargaon University Journal', '3rd', 47, NOW(), NOW()),
  ('sup_08_a1', 'Shaping Festival Financing and Expenditure: A Fair Assessment of Bangladeshi Earnings Capable Residents', 'Zulfiqer Hasan', NULL, NULL, 'Department of Business Administration, Bangladesh Islamic University', 'July 2020', 2020, 'https://su.edu.bd/web_assets/journal/journal00/2%20%20Zulfiqar%20Hasan.pdf', 'Sonargaon University Journal, Vol. 3, Issue I & II', 'Sole author', 48, NOW(), NOW()),
  ('sup_09_a1', 'Nation Branding: Branding Bangladesh Using Global Branding Strategy with the Help of Domestic Products', 'Mushfeka Binte Kamal', NULL, NULL, 'Department of Business Administration, Sonargaon University (SU); Heriot-Watt University, UK', 'December 2017', 2017, 'https://su.edu.bd/web_assets/journal/journal2volume2/10%20M%20Kamal.pdf', 'Sonargaon University Journal', '1st', 49, NOW(), NOW()),
  ('sup_09_a2', 'Nation Branding: Branding Bangladesh Using Global Branding Strategy with the Help of Domestic Products', 'Ruhul Amin', NULL, NULL, 'Department of Business Administration, Sonargaon University (SU); Heriot-Watt University, UK', 'December 2017', 2017, 'https://su.edu.bd/web_assets/journal/journal2volume2/10%20M%20Kamal.pdf', 'Sonargaon University Journal', '2nd', 50, NOW(), NOW()),
  ('sup_09_a3', 'Nation Branding: Branding Bangladesh Using Global Branding Strategy with the Help of Domestic Products', 'Cathy Bipasha Sarkar', NULL, NULL, 'Department of Business Administration, Sonargaon University (SU); Heriot-Watt University, UK', 'December 2017', 2017, 'https://su.edu.bd/web_assets/journal/journal2volume2/10%20M%20Kamal.pdf', 'Sonargaon University Journal', '3rd', 51, NOW(), NOW()),
  ('sup_10_a1', 'Social Networks: Perceived Impact on Students Academic and Personal Life', 'Ruhul Amin', NULL, NULL, 'Sonargaon University, Dhaka; BSMRSTU, Gopalganj', 'December 2017', 2017, 'https://su.edu.bd/web_assets/journal/journal2volume2/6%20R%20Amin.pdf', 'Sonargaon University Journal', '1st', 52, NOW(), NOW()),
  ('sup_10_a2', 'Social Networks: Perceived Impact on Students Academic and Personal Life', 'Al-Amin Khan', NULL, NULL, 'Sonargaon University, Dhaka; BSMRSTU, Gopalganj', 'December 2017', 2017, 'https://su.edu.bd/web_assets/journal/journal2volume2/6%20R%20Amin.pdf', 'Sonargaon University Journal', '2nd', 53, NOW(), NOW()),
  ('sup_10_a3', 'Social Networks: Perceived Impact on Students Academic and Personal Life', 'Tasnia Ahammad', NULL, NULL, 'Sonargaon University, Dhaka; BSMRSTU, Gopalganj', 'December 2017', 2017, 'https://su.edu.bd/web_assets/journal/journal2volume2/6%20R%20Amin.pdf', 'Sonargaon University Journal', '3rd', 54, NOW(), NOW()),
  ('sup_10_a4', 'Social Networks: Perceived Impact on Students Academic and Personal Life', 'Khadizatul Ferdous', NULL, NULL, 'Sonargaon University, Dhaka; BSMRSTU, Gopalganj', 'December 2017', 2017, 'https://su.edu.bd/web_assets/journal/journal2volume2/6%20R%20Amin.pdf', 'Sonargaon University Journal', '4th', 55, NOW(), NOW()),
  ('sup_10_a5', 'Social Networks: Perceived Impact on Students Academic and Personal Life', 'Md. Al-Amin Molla', 'Professor & Dean', 'al-amin-mollah', 'Sonargaon University, Dhaka; BSMRSTU, Gopalganj', 'December 2017', 2017, 'https://su.edu.bd/web_assets/journal/journal2volume2/6%20R%20Amin.pdf', 'Sonargaon University Journal', '5th', 56, NOW(), NOW()),
  ('sup_11_a1', 'An Empirical Study on Determining the Association Between Micro Finance and Poor''s Access', 'Md. Salamun Rashidin', NULL, NULL, 'China Institute for WTO Studies, University of International Business and Economics, China; Sonargaon University (SU)', 'December 2017', 2017, 'https://su.edu.bd/web_assets/journal/journal2volume2/2%20MS%20Rashidin.pdf', 'Sonargaon University Journal', '1st', 57, NOW(), NOW()),
  ('sup_11_a2', 'An Empirical Study on Determining the Association Between Micro Finance and Poor''s Access', 'Sara Javed', NULL, NULL, 'China Institute for WTO Studies, University of International Business and Economics, China; Sonargaon University (SU)', 'December 2017', 2017, 'https://su.edu.bd/web_assets/journal/journal2volume2/2%20MS%20Rashidin.pdf', 'Sonargaon University Journal', '2nd', 58, NOW(), NOW()),
  ('sup_11_a3', 'An Empirical Study on Determining the Association Between Micro Finance and Poor''s Access', 'Wand Jian', NULL, NULL, 'China Institute for WTO Studies, University of International Business and Economics, China; Sonargaon University (SU)', 'December 2017', 2017, 'https://su.edu.bd/web_assets/journal/journal2volume2/2%20MS%20Rashidin.pdf', 'Sonargaon University Journal', '3rd', 59, NOW(), NOW()),
  ('sup_12_a1', 'The Influence of Balance of Payments and Balance of Trade on Exchange Rate in Developing Countries of Asia: A Case Study of Bangladesh, Pakistan and India', 'Md. Salamun Rashidin', NULL, NULL, 'Graduate Student, MS in Disaster Management, University of Dhaka', '2016', 2016, 'https://su.edu.bd/web_assets/journal/journal1volume2/10%20MS%20Rashidin.pdf', 'Sonargaon University Journal', '1st', 60, NOW(), NOW()),
  ('sup_12_a2', 'The Influence of Balance of Payments and Balance of Trade on Exchange Rate in Developing Countries of Asia: A Case Study of Bangladesh, Pakistan and India', 'Irfan Ullah', NULL, NULL, 'Graduate Student, MS in Disaster Management, University of Dhaka', '2016', 2016, 'https://su.edu.bd/web_assets/journal/journal1volume2/10%20MS%20Rashidin.pdf', 'Sonargaon University Journal', '2nd', 61, NOW(), NOW()),
  ('sup_12_a3', 'The Influence of Balance of Payments and Balance of Trade on Exchange Rate in Developing Countries of Asia: A Case Study of Bangladesh, Pakistan and India', 'Mahad Jehangir', NULL, NULL, 'Graduate Student, MS in Disaster Management, University of Dhaka', '2016', 2016, 'https://su.edu.bd/web_assets/journal/journal1volume2/10%20MS%20Rashidin.pdf', 'Sonargaon University Journal', '3rd', 62, NOW(), NOW()),
  ('sup_13_a1', 'Is Microfinace Beneficial or Optimistic', 'S. M. Nurul Huda', NULL, NULL, 'Department of AIS, University of Dhaka; Sonargaon University (SU)', '2016', 2016, 'https://su.edu.bd/web_assets/journal/journal1volume2/8%20SMN%20Huda.pdf', 'Sonargaon University Journal', '1st', 63, NOW(), NOW()),
  ('sup_13_a2', 'Is Microfinace Beneficial or Optimistic', 'Shah Alam', NULL, NULL, 'Department of AIS, University of Dhaka; Sonargaon University (SU)', '2016', 2016, 'https://su.edu.bd/web_assets/journal/journal1volume2/8%20SMN%20Huda.pdf', 'Sonargaon University Journal', '2nd', 64, NOW(), NOW()),
  ('sup_13_a3', 'Is Microfinace Beneficial or Optimistic', 'Abdur Rahman Akram', NULL, NULL, 'Department of AIS, University of Dhaka; Sonargaon University (SU)', '2016', 2016, 'https://su.edu.bd/web_assets/journal/journal1volume2/8%20SMN%20Huda.pdf', 'Sonargaon University Journal', '3rd', 65, NOW(), NOW()),
  ('sup_13_a4', 'Is Microfinace Beneficial or Optimistic', 'Saif Md. Imran Khan', NULL, NULL, 'Department of AIS, University of Dhaka; Sonargaon University (SU)', '2016', 2016, 'https://su.edu.bd/web_assets/journal/journal1volume2/8%20SMN%20Huda.pdf', 'Sonargaon University Journal', '4th', 66, NOW(), NOW()),
  ('sup_14_a1', 'An Economic Analysis of Shipping Industry in Bangladesh: Implications for Sustainable Development', 'S. M. Nurul Huda', 'Treasurer, Sonargaon University (SU)', NULL, 'Sonargaon University (SU)', '2016', 2016, 'https://su.edu.bd/web_assets/journal/journal1volume2/7%20SMN%20Huda.pdf', 'Sonargaon University Journal', '1st', 67, NOW(), NOW()),
  ('sup_14_a2', 'An Economic Analysis of Shipping Industry in Bangladesh: Implications for Sustainable Development', 'Mohammad Mojahid Hossain Chowdhury', NULL, NULL, 'Sonargaon University (SU)', '2016', 2016, 'https://su.edu.bd/web_assets/journal/journal1volume2/7%20SMN%20Huda.pdf', 'Sonargaon University Journal', '2nd', 68, NOW(), NOW()),
  ('sup_14_a3', 'An Economic Analysis of Shipping Industry in Bangladesh: Implications for Sustainable Development', 'Md. Al-Amin Molla', 'Professor & Dean', 'al-amin-mollah', 'Sonargaon University (SU)', '2016', 2016, 'https://su.edu.bd/web_assets/journal/journal1volume2/7%20SMN%20Huda.pdf', 'Sonargaon University Journal', '3rd', 69, NOW(), NOW()),
  ('sup_15_a1', 'Effect of Macro Economic Variables on Stock Market Returns - Bangladesh Context', 'Abul Kalam', NULL, NULL, 'Department of Business Administration, Sonargaon University (SU)', '2016', 2016, 'https://su.edu.bd/web_assets/journal/journal1volume2/6%20A%20Kalam.pdf', 'Sonargaon University Journal', '1st', 70, NOW(), NOW()),
  ('sup_15_a2', 'Effect of Macro Economic Variables on Stock Market Returns - Bangladesh Context', 'Md. Al-Amin Molla', 'Professor & Dean', 'al-amin-mollah', 'Department of Business Administration, Sonargaon University (SU)', '2016', 2016, 'https://su.edu.bd/web_assets/journal/journal1volume2/6%20A%20Kalam.pdf', 'Sonargaon University Journal', '2nd', 71, NOW(), NOW()),
  ('sup_15_a3', 'Effect of Macro Economic Variables on Stock Market Returns - Bangladesh Context', 'Md. Mesbaul Hussain', NULL, NULL, 'Department of Business Administration, Sonargaon University (SU)', '2016', 2016, 'https://su.edu.bd/web_assets/journal/journal1volume2/6%20A%20Kalam.pdf', 'Sonargaon University Journal', '3rd', 72, NOW(), NOW()),
  ('sup_16_a1', 'Study and Analysis of Production Management using Renewable Energy for Sustainable Development', 'K. M. Safiqul Islam', NULL, NULL, 'College of Public Administration, Huazhong University of Science and Technology, Wuhan, Hubei, P.R. China', 'July 2020', 2020, 'https://su.edu.bd/web_assets/journal/journal00/4%20Shaiq_Final.pdf', 'Sonargaon University Journal, Vol. 3, Issue I & II', 'Sole author', 73, NOW(), NOW())
ON CONFLICT ("id") DO NOTHING;

-- The SERVQUAL paper was already present but linked nowhere: the source
-- page points it at a local "file:///" path. Fill in the publisher URL,
-- leaving the row other fields untouched.
UPDATE "research_paper"
SET "link" = 'https://goodwoodpub.com/index.php/amor/article/download/1184/344/6617',
    "updatedAt" = NOW()
WHERE "title" LIKE 'Service Quality Dimensions (SERVQUAL)%' AND "link" IS NULL;
