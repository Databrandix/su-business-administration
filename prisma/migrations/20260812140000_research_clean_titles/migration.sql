-- `title` held the full citation (authors, year, journal), which duplicated
-- the authors / date / publisher fields already rendered on the card, so the
-- heading repeated everything shown beneath it. Reduce each title to the
-- paper title alone. Done as explicit per-row updates rather than a regex
-- because the source citations use several incompatible formats — APA
-- ("Authors (Year). Title. Journal."), comma-separated with no year, and
-- quoted IEEE/conference styles — which no single pattern splits correctly.
--
-- Keyed on displayOrder: it is unique per row here and readable, unlike cuid
-- primary keys. Nothing else is touched; authors, date, publisher, indexing
-- and the rest still supply the metadata rows under the heading.

UPDATE "research_paper" SET "title" = 'The role of leadership styles in enhancing academic and administrative efficiency in Bangladeshi private universities.' WHERE "displayOrder" = 0;
UPDATE "research_paper" SET "title" = 'Evaluating the Quality of Higher Education in Private Universities of Bangladesh: Challenge, Developments, and the Path Forward.' WHERE "displayOrder" = 1;
UPDATE "research_paper" SET "title" = 'Effect of Green Investment, Renewable Energy Consumption, and Carbon Tax Policies on Ecological Sustainability: Evidence from ASEAN Countries' WHERE "displayOrder" = 2;
UPDATE "research_paper" SET "title" = 'Toward Achieving Sustainable Development Goal 13 in Developing Countries: Microcredit to Environmental Degradation' WHERE "displayOrder" = 3;
UPDATE "research_paper" SET "title" = 'A pathway towards sustainable development: Analysing the influential role of microfinancing on environmental quality in developing nations.' WHERE "displayOrder" = 4;
UPDATE "research_paper" SET "title" = 'Social Enterprise''s Initiatives for Socioeconomic Sustainability: Appraisal based on Morphogenetic/Morphostatic Approach and Opportunity Co-creation theory.' WHERE "displayOrder" = 5;
UPDATE "research_paper" SET "title" = 'Financial Factors Influencing Investment Willingness in Environment-Friendly Business: Empirical Study on an Emerging Economy' WHERE "displayOrder" = 6;
UPDATE "research_paper" SET "title" = 'Nongovernmental Organizations Transforming into Social Enterprises in the Process of Institutionalizing Solutions to Major Social Crises for Ensuring Sustainable Social Development.' WHERE "displayOrder" = 7;
UPDATE "research_paper" SET "title" = 'Institutional Capital, Ancestral Hall, and the Reshaping of Ancient Rule: an Empirical Analysis of the New Energy of Chinese Heritage Elements in Rural Revitalization' WHERE "displayOrder" = 8;
UPDATE "research_paper" SET "title" = 'Exploring the economic impact of institutional entrepreneurship, social Innovation, and poverty reduction on carbon footprint in BRICS countries: what is the role of social enterprise?' WHERE "displayOrder" = 9;
UPDATE "research_paper" SET "title" = 'Butterfly Change of Commercial Enterprise into Social Enterprise: Based on Mechanism and Case Study of Institutional Capital' WHERE "displayOrder" = 10;
UPDATE "research_paper" SET "title" = 'A STUDY ON THE EFFECTIVENESS OF SUSTAINABLE STRUCTURE OF EMERGING SOCIAL ENTERPRISES TO ERADICATE IMPOVERISHMENT: THE REHABILITATION PARADIGM IN BANGLADESH' WHERE "displayOrder" = 11;
UPDATE "research_paper" SET "title" = 'Service Quality Dimensions (SERVQUAL) and Customer Satisfaction towards Motor Ride-Sharing Services: Evidence from Bangladesh.' WHERE "displayOrder" = 12;
UPDATE "research_paper" SET "title" = 'Toward a Greener Horizon: Unraveling the Links Among Environmental Awareness, Consumption Values, and Packaging in Consumer Decision Making' WHERE "displayOrder" = 13;
UPDATE "research_paper" SET "title" = 'Consideration of workers’ opinion in the decision making process in the RMG Sector: Evidence from Bangladesh.' WHERE "displayOrder" = 14;
UPDATE "research_paper" SET "title" = 'Empowering workers’ involvement: Unveiling the dynamics of communication, recognition, productivity, and decision-making in the RMG sector.' WHERE "displayOrder" = 15;
UPDATE "research_paper" SET "title" = 'Corporate Governance Practices in Bangladesh: An Overview of Pharmaceutical, Chemical and Ceramic Industry.' WHERE "displayOrder" = 16;
UPDATE "research_paper" SET "title" = 'Sustainable Growth Strategies for Bangladesh’s Leather Industry: Policy Recommendations and Future Perspectives.' WHERE "displayOrder" = 17;
UPDATE "research_paper" SET "title" = 'Job Satisfaction of Bankers in Islami Shariah-based Private Commercial Banks of Bangladesh: Application of Job Characteristics Model.' WHERE "displayOrder" = 18;
UPDATE "research_paper" SET "title" = 'Unveiling the impact of green innovation on organizational performance: An empirical study on FMCG sector in Bangladesh.' WHERE "displayOrder" = 19;
UPDATE "research_paper" SET "title" = 'Green human resource management and green innovation as drivers of environmental performance in readymade garment firms.' WHERE "displayOrder" = 20;
UPDATE "research_paper" SET "title" = 'Determinants of Profitability in Banking Sector: Empirical Evidence from Bangladesh.' WHERE "displayOrder" = 21;
UPDATE "research_paper" SET "title" = 'Job Satisfaction of Bankers in Islami Shariah-based Private Commercial Banks of Bangladesh: Application of Job Characteristics Model.' WHERE "displayOrder" = 22;
UPDATE "research_paper" SET "title" = 'Profitability Analysis of Conventional and Islamic Banks in Bangladesh: A Comparative Study.' WHERE "displayOrder" = 23;
UPDATE "research_paper" SET "title" = 'To the Moon and Beyond: How Nano Entrepreneurs and Digital Currency Are Revolutionizing the Future of Business in Space!' WHERE "displayOrder" = 24;
UPDATE "research_paper" SET "title" = 'Unveiling the impact of green innovation on organizational performance: An empirical study on FMCG sector in Bangladesh.' WHERE "displayOrder" = 25;
UPDATE "research_paper" SET "title" = 'A Comparative Examination of Productivity in Islamic and Conventional Banking in Bangladesh.' WHERE "displayOrder" = 26;
UPDATE "research_paper" SET "title" = 'Green human resource management and green innovation as drivers of environmental performance in readymade garment firms.' WHERE "displayOrder" = 27;
UPDATE "research_paper" SET "title" = 'Sustainable Green Practices in Manufacturing Organizations: A hybrid methods from a Green Dynamic Capability Aspects.' WHERE "displayOrder" = 28;
UPDATE "research_paper" SET "title" = 'Academic Research in Universities of an Emerging Country: Trends and Future Directions for Higher Education.' WHERE "displayOrder" = 29;
UPDATE "research_paper" SET "title" = 'Exploring the mediating role of appraisal fairness between the relationship of ethical behaviour and employee performance: moderating role of organizational culture.' WHERE "displayOrder" = 30;
UPDATE "research_paper" SET "title" = 'Digital finance leads women entrepreneurship and poverty mitigation for sustainable development in Bangladesh.' WHERE "displayOrder" = 31;
UPDATE "research_paper" SET "title" = 'Annotated Bangla natural language processing (BNLP) using Python and machine learning.' WHERE "displayOrder" = 32;
UPDATE "research_paper" SET "title" = 'Integrative ML and DL Strategies for Renewable Energy Forecasting: Performance and Feature Attribution in Solar and Wind Datasets' WHERE "displayOrder" = 33;
UPDATE "research_paper" SET "title" = 'Sustainable green practices and knowledge in manufacturing organisations: Hybrid methods from a green dynamic capability approach.' WHERE "displayOrder" = 34;
UPDATE "research_paper" SET "title" = 'Design and implementation of a low-cost IoT-enabled dual-axis photovoltaic tracking system with experimental and simulation-based validation.' WHERE "displayOrder" = 35;
UPDATE "research_paper" SET "title" = 'Green Human Resource Management Practices and Organizational Citizenship Behaviour towards the Environment in the Banking Sector in Bangladesh.' WHERE "displayOrder" = 36;
UPDATE "research_paper" SET "title" = 'Technological Advancement as a Catalyst for Women Empowerment through Entrepreneurship: Post Covid-19 Scenario in Bangladesh.' WHERE "displayOrder" = 37;
UPDATE "research_paper" SET "title" = 'Exploring the mediating role of appraisal fairness between the relationship of ethical behaviour and employee performance: moderating role of organisational culture.' WHERE "displayOrder" = 38;
UPDATE "research_paper" SET "title" = 'Understanding the Drivers of Green Entrepreneurial Intentions: An Application of Shapero’s Entrepreneurial Event Model.' WHERE "displayOrder" = 39;
