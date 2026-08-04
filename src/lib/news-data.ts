export type NewsCategory =
  | 'Academic'
  | 'Achievement'
  | 'Event'
  | 'Workshop'
  | 'Seminar'
  | 'Industrial Visit';

export interface NewsArticle {
  slug: string;
  title: string;
  shortTitle: string;
  category: NewsCategory;
  /** Display date (e.g., "01 Sep, 2025"). */
  date: string;
  /** ISO yyyy-mm-dd for sorting. */
  isoDate: string;
  /** Optional secondary line (organiser / location / event). */
  meta?: { label: string; value: string }[];
  /** One-line summary used on cards. */
  summary: string;
  cover: string;
  /** Full body — array of paragraphs. */
  body: string[];
}

export const news: NewsArticle[] = [
  {
    slug: "internship-thesis-viva-2025",
    title:
      "Final-Semester Students Defend Internship Reports and Theses Before Faculty Panel",
    shortTitle: "BA Students Complete Internship & Thesis Viva Voce",
    category: "Academic",
    date: "13 Sep, 2025",
    isoDate: "2025-09-13",
    meta: [
      { label: "Sessions", value: "11 January 2025 and 13 September 2025" },
      { label: "Assessment", value: "Internship report and thesis defence" },
    ],
    summary:
      "Final-semester BBA students presented and defended their internship reports and thesis research before a panel of faculty examiners across two viva sessions held in January and September 2025.",
    cover: "https://res.cloudinary.com/n3n2tgqk/image/upload/f_auto,q_auto:good/v1785834166/bba-dept/events/internship-thesis-viva.jpg",
    body: [
      "The Department of Business Administration completed its Internship and Thesis Viva Voce for the 2025 academic year, with final-semester students appearing before a panel of faculty examiners to present and defend their capstone work.",
      "Internship candidates reported on their host organisations — the problems they were assigned, the analysis they carried out, and the recommendations they delivered at the end of their placement. Thesis candidates presented their research design, data collection, and findings, then answered examiner questions on methodology and interpretation.",
      "The viva is the final assessment of the BBA programme and the point at which classroom theory is tested against documented practice. Faculty examiners noted the growing methodological confidence among thesis candidates, several of whom applied quantitative techniques introduced through the department’s research workshops.",
      "Two sessions were held during the year — 11 January and 13 September 2025 — accommodating both graduating cohorts.",
    ],
  },
  {
    slug: "blockchain-supply-chain-seminar-2025",
    title:
      "Department Hosts Seminar on Blockchain Technology for Sustainable Supply Chain Management",
    shortTitle: "Seminar Explores Blockchain in Sustainable Supply Chains",
    category: "Seminar",
    date: "01 Aug, 2025",
    isoDate: "2025-08-01",
    meta: [
      { label: "Organised by", value: "Department of Business Administration" },
      { label: "Venue", value: "Sonargaon University" },
    ],
    summary:
      "A departmental seminar examined how blockchain-enabled traceability is reshaping sustainable supply chain management and what the shift means for business graduates entering the field.",
    cover: "https://res.cloudinary.com/n3n2tgqk/image/upload/f_auto,q_auto:good/v1785835691/bba-dept/events/blockchain-supply-chain-seminar.jpg",
    body: [
      "The Department of Business Administration hosted a seminar on Blockchain Technology for Sustainable Supply Chain Management, bringing faculty and students together for a focused discussion on one of the fastest-moving areas in operations and logistics.",
      "The session covered the mechanics of distributed ledgers, how immutable transaction records improve traceability from raw material to end consumer, and the ways firms are using these systems to verify sustainability claims and reduce compliance risk.",
      "Participants also worked through the practical adoption questions that determine whether such systems succeed — integration cost, supplier readiness, and the governance arrangements needed to make a shared ledger function across organisational boundaries.",
      "The seminar concluded with a certificate handover ceremony attended by senior university officials.",
    ],
  },
  {
    slug: "first-class-permanent-campus-2025",
    title:
      "Department of Business Administration Holds First Class at Sonargaon University’s Permanent Campus",
    shortTitle: "BA Department Begins Classes at Permanent Campus",
    category: "Achievement",
    date: "14 May, 2025",
    isoDate: "2025-05-14",
    meta: [
      { label: "Location", value: "Sonargaon University Permanent Campus" },
    ],
    summary:
      "A milestone for the Department — the first class held at Sonargaon University’s permanent campus, opening a new chapter for students and faculty alike.",
    cover: "https://res.cloudinary.com/n3n2tgqk/image/upload/f_auto,q_auto:good/v1785834167/bba-dept/events/first-class-permanent-campus.jpg",
    body: [
      "On 14 May 2025 the Department of Business Administration held its first class at Sonargaon University’s permanent campus, marking a milestone that had been years in the making.",
      "The move brings students into purpose-built classrooms with improved learning facilities, dedicated study spaces, and room for the departmental and club activities that shape student life beyond the syllabus.",
      "Faculty and students marked the occasion together. For the Department, the permanent campus provides the physical foundation for its next phase of growth — larger cohorts, expanded research activity, and the facilities to host the seminars and workshops that have become a fixture of its academic calendar.",
    ],
  },
  {
    slug: "business-adda-2024",
    title:
      "Business Club Hosts Business Adda 2024 for Students, Alumni and Faculty",
    shortTitle: "Business Adda 2024 Connects Students with Alumni",
    category: "Event",
    date: "02 Jun, 2024",
    isoDate: "2024-06-02",
    meta: [
      { label: "Organised by", value: "Business Club" },
    ],
    summary:
      "An open-format gathering organised by the Business Club, where students, alumni, and faculty exchanged ideas on business, careers, and campus life.",
    cover: "https://res.cloudinary.com/n3n2tgqk/image/upload/f_auto,q_auto:good/v1785834172/bba-dept/events/business-adda-2024.jpg",
    body: [
      "Business Adda 2024, organised by the Business Club of the Department of Business Administration, brought students, alumni, and faculty together in an informal setting built around conversation rather than presentation.",
      "The format was deliberately loose — small groups, open topics, and the freedom to move between them. Discussions ranged over career planning, entrepreneurial ideas, internship experiences, and the practical realities of moving from campus into the workplace.",
      "Gatherings of this kind build the horizontal connections that formal classes rarely create: juniors meeting seniors, and current students meeting graduates already working in the field. For many attendees, the alumni conversations proved the most valuable part of the afternoon.",
    ],
  },
  {
    slug: "iftar-mahfil-recitation-2024",
    title:
      "Business Club Organises Iftar Mahfil with Hamd, Nat and Quran Recitation Competition",
    shortTitle: "Iftar Mahfil and Recitation Competition 2024",
    category: "Event",
    date: "25 Mar, 2024",
    isoDate: "2024-03-25",
    meta: [
      { label: "Organised by", value: "Business Club, Department of Business Administration" },
    ],
    summary:
      "The Business Club’s Ramadan gathering combined an Iftar Mahfil with competitions in Hamd, Nat, and Quran recitation, drawing students and faculty from across the Department.",
    cover: "https://res.cloudinary.com/n3n2tgqk/image/upload/f_auto,q_auto:good/v1785834172/bba-dept/events/iftar-mahfil-2024.jpg",
    body: [
      "The Business Club of the Department of Business Administration organised an Iftar Mahfil during Ramadan, held alongside competitions in Hamd, Nat, and Quran recitation.",
      "Students from across batches took part in the recitation events, with winners recognised before the Iftar. Faculty members joined students at the table, making it one of the year’s most well-attended departmental gatherings.",
      "The programme reflects the Department’s view that student life should make room for shared observance and cultural expression alongside academic work — a principle the Business Club has carried through its annual calendar.",
    ],
  },
];
