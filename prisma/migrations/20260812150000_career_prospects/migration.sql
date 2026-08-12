-- Career Prospects section for /programs/<slug>. Held as a singleton
-- because the department publishes one careers statement covering all
-- eight degrees; a per-Program column would mean eight edits to correct
-- a single typo.
CREATE TABLE "career_prospects" (
    "id"           TEXT NOT NULL DEFAULT 'singleton',
    "heading"      TEXT NOT NULL DEFAULT 'Career Prospects',
    "intro"        JSONB NOT NULL DEFAULT '[]',
    "rows"         JSONB NOT NULL DEFAULT '[]',
    "areaLabel"    TEXT NOT NULL DEFAULT 'Functional Areas',
    "rolesLabel"   TEXT NOT NULL DEFAULT 'Primary Career Roles',
    "sectorsLabel" TEXT NOT NULL DEFAULT 'Leading Target Sectors',
    "updatedAt"    TIMESTAMP(3) NOT NULL,

    CONSTRAINT "career_prospects_pkey" PRIMARY KEY ("id")
);

-- Seeded verbatim from the department's Career Prospects document.
INSERT INTO "career_prospects" ("id", "intro", "rows", "updatedAt")
VALUES (
    'singleton',
    '["A degree in Business Administration opens doors to dynamic, high-growth career pathways across local conglomerates, multinational corporations (MNCs), financial institutions, tech startups, and global developmental organizations. Equipped with an outcome-based education (OBE) background and multi-disciplinary skill sets, our graduates are prepared to excel in diverse functional roles:"]'::jsonb,
    '[
      {
        "area": "Finance & Banking",
        "roles": "Management Trainee Officer (MTO), Financial Analyst, Credit Analyst, Risk Management Officer",
        "sectors": "Commercial Banks, NBFIs, Investment & Merchant Banks, Fintech firms"
      },
      {
        "area": "Marketing & Brand Management",
        "roles": "Brand Executive, Digital Marketing Strategist, Market Research Analyst, Business Development Executive",
        "sectors": "FMCG Sector, Advertising & PR Agencies, E-commerce, Telecommunications"
      },
      {
        "area": "Supply Chain & Operations",
        "roles": "Operations Manager, Procurement Officer, Logistics Coordinator, Supply Chain Analyst",
        "sectors": "Manufacturing & Garments (RMG), E-commerce, Freight & Logistics, Retail Chains"
      },
      {
        "area": "HR & Organizational Development",
        "roles": "Talent Acquisition Specialist, HR Business Partner (HRBP), Training & Development Executive",
        "sectors": "Corporate Head Offices, IT & Software Services, Consultancies, Non-profits/NGOs"
      },
      {
        "area": "MIS & Business Analytics",
        "roles": "Business Intelligence Analyst, Systems Analyst, ERP Specialist, Data Consultant",
        "sectors": "Tech Enterprises, Corporate Strategy Divisions, Data Consultancies"
      }
    ]'::jsonb,
    NOW()
);
