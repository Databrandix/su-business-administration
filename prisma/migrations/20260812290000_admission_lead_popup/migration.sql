-- Homepage admission-guidance popup: the leads it captures, and the
-- settings that let the department retune it without a deploy.
CREATE TABLE "admission_lead" (
    "id"          TEXT NOT NULL,
    "fullName"    TEXT NOT NULL,
    "phone"       TEXT NOT NULL,
    "programme"   TEXT NOT NULL,
    "status"      TEXT NOT NULL DEFAULT 'new',
    "notes"       TEXT,
    "ipAddress"   TEXT,
    "userAgent"   TEXT,
    "submittedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAt"   TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt"   TIMESTAMP(3) NOT NULL,

    CONSTRAINT "admission_lead_pkey" PRIMARY KEY ("id")
);
CREATE INDEX "admission_lead_status_submittedAt_idx" ON "admission_lead"("status", "submittedAt");
CREATE INDEX "admission_lead_submittedAt_idx" ON "admission_lead"("submittedAt");

CREATE TABLE "admission_lead_popup" (
    "id"                   TEXT NOT NULL DEFAULT 'singleton',
    "isEnabled"            BOOLEAN NOT NULL DEFAULT true,
    "heading"              TEXT NOT NULL DEFAULT 'Start your journey with Sonargaon University',
    "subheading"           TEXT NOT NULL DEFAULT 'Get personalized admission guidance from our admission team.',
    "nameLabel"            TEXT NOT NULL DEFAULT 'Full name',
    "namePlaceholder"      TEXT NOT NULL DEFAULT 'As written on your certificate',
    "phoneLabel"           TEXT NOT NULL DEFAULT 'Mobile number',
    "phonePlaceholder"     TEXT NOT NULL DEFAULT '01XXXXXXXXX',
    "programmeLabel"       TEXT NOT NULL DEFAULT 'Programme you are interested in',
    "programmePlaceholder" TEXT NOT NULL DEFAULT 'Choose a programme',
    "submitLabel"          TEXT NOT NULL DEFAULT 'Get admission guidance',
    "footnote"             TEXT NOT NULL DEFAULT 'Our admission team will contact you shortly.',
    "successMessage"       TEXT NOT NULL DEFAULT 'Thank you! Our admission team will contact you shortly.',
    "delaySeconds"         INTEGER NOT NULL DEFAULT 15,
    "cooldownDays"         INTEGER NOT NULL DEFAULT 7,
    "updatedAt"            TIMESTAMP(3) NOT NULL,

    CONSTRAINT "admission_lead_popup_pkey" PRIMARY KEY ("id")
);

INSERT INTO "admission_lead_popup" ("id", "updatedAt") VALUES ('singleton', NOW());
