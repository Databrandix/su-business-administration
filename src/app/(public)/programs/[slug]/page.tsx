import Link from 'next/link';
import { notFound } from 'next/navigation';
import {
  CheckCircle2,
  Clock,
  ClipboardList,
  CreditCard,
} from 'lucide-react';
import PageShell from '@/components/layout/PageShell';
import Container from '@/components/ui/Container';
import { DynamicLucideIcon } from '@/components/ui/DynamicLucideIcon';
import {
  getProgramBySlug,
  getProgramSlugs,
  getPageHero,
  getCareerProspects,
} from '@/lib/identity';
import { sanitizeHtml } from '@/lib/sanitize-html';

export async function generateStaticParams() {
  const slugs = await getProgramSlugs();
  return slugs.map((slug) => ({ slug }));
}

export async function generateMetadata({
  params,
}: {
  params: Promise<{ slug: string }>;
}) {
  const { slug } = await params;
  const program = await getProgramBySlug(slug);
  if (!program) return { title: 'Program not found' };

  return {
    title: `${program.programName} — Department of Business Administration`,
    description: program.description,
    openGraph: {
      title: `${program.programName} — Sonargaon University`,
      description: program.description,
      images: program.imageUrl ? [{ url: program.imageUrl }] : undefined,
    },
  };
}

// overviewParagraphs is Json — narrow it to the string[] the page needs
// rather than trusting the column shape at render time.
function coerceParagraphs(v: unknown): string[] {
  if (!Array.isArray(v)) return [];
  return v.filter((s): s is string => typeof s === 'string' && s.length > 0);
}

type StatCard = { iconName?: string; label: string; value: string };

function coerceStats(v: unknown): StatCard[] {
  if (!Array.isArray(v)) return [];
  return v
    .filter((r): r is Record<string, unknown> => typeof r === 'object' && r !== null)
    .map((r) => ({
      iconName: typeof r.iconName === 'string' ? r.iconName : undefined,
      label: typeof r.label === 'string' ? r.label : '',
      value: typeof r.value === 'string' ? r.value : '',
    }))
    .filter((r) => r.label && r.value);
}

type Course = { code: string; title: string; contact: string; credits: string };
type Semester = { title: string; note: string; courses: Course[]; footer: string };
type MajorOption = { roman: string; name: string; courses: Course[] };

function coerceCourses(v: unknown): Course[] {
  if (!Array.isArray(v)) return [];
  return v
    .filter((c): c is Record<string, unknown> => typeof c === 'object' && c !== null)
    .map((c) => ({
      code:    typeof c.code === 'string' ? c.code : '',
      title:   typeof c.title === 'string' ? c.title : '',
      contact: typeof c.contact === 'string' ? c.contact : '',
      credits: typeof c.credits === 'string' ? c.credits : '',
    }))
    .filter((c) => c.code && c.title);
}

function coerceSemesters(v: unknown): Semester[] {
  if (!Array.isArray(v)) return [];
  return v
    .filter((s): s is Record<string, unknown> => typeof s === 'object' && s !== null)
    .map((s) => ({
      title:   typeof s.title === 'string' ? s.title : '',
      note:    typeof s.note === 'string' ? s.note : '',
      footer:  typeof s.footer === 'string' ? s.footer : '',
      courses: coerceCourses(s.courses),
    }))
    .filter((s) => s.title);
}

function coerceMajorOptions(v: unknown): MajorOption[] {
  if (!Array.isArray(v)) return [];
  return v
    .filter((o): o is Record<string, unknown> => typeof o === 'object' && o !== null)
    .map((o) => ({
      roman:   typeof o.roman === 'string' ? o.roman : '',
      name:    typeof o.name === 'string' ? o.name : '',
      courses: coerceCourses(o.courses),
    }))
    .filter((o) => o.name && o.courses.length > 0);
}

type CareerRow = { area: string; roles: string; sectors: string };

function coerceCareerRows(v: unknown): CareerRow[] {
  if (!Array.isArray(v)) return [];
  return v
    .filter((r): r is Record<string, unknown> => typeof r === 'object' && r !== null)
    .map((r) => ({
      area:    typeof r.area === 'string' ? r.area : '',
      roles:   typeof r.roles === 'string' ? r.roles : '',
      sectors: typeof r.sectors === 'string' ? r.sectors : '',
    }))
    .filter((r) => r.area && r.roles && r.sectors);
}

export default async function ProgramDetailPage({
  params,
}: {
  params: Promise<{ slug: string }>;
}) {
  const { slug } = await params;
  const [program, hero, careers] = await Promise.all([
    getProgramBySlug(slug),
    getPageHero('programs'),
    getCareerProspects(),
  ]);
  if (!program) notFound();

  const paragraphs = coerceParagraphs(program.overviewParagraphs);
  const stats = coerceStats(program.feeStructure?.overviewStats);
  const careerIntro = coerceParagraphs(careers?.intro);
  const careerRows = coerceCareerRows(careers?.rows);
  const semesters = coerceSemesters(program.courseStructure);
  const majorOptions = coerceMajorOptions(program.majorOptions);

  return (
    <PageShell
      title={program.programName}
      subtitle={hero?.heroSubtitle ?? undefined}
      overline={program.overline || hero?.heroOverline || 'Programs'}
      image={hero?.heroImageUrl ?? undefined}
      imagePosition={hero ? `center ${hero.heroImageVerticalPercent}%` : undefined}
      contentClassName="bg-gray-50 py-12 md:py-20"
    >
      <Container>
        {/* ───── Program overview — centred column, no side image ───── */}
        <section className="mb-14 md:mb-20 mx-auto max-w-4xl text-center">
          <div className="flex items-center justify-center gap-3 mb-3">
            <span className="h-[1.5px] w-10 bg-accent/40" />
            <span className="text-accent text-[10px] font-bold uppercase tracking-[0.2em]">
              Program Overview
            </span>
            <span className="h-[1.5px] w-10 bg-accent/40" />
          </div>
          <h2 className="font-display text-2xl md:text-3xl font-bold text-primary leading-tight mb-5">
            {program.programName}
          </h2>

          {paragraphs.length > 0 ? (
            <div className="space-y-5 text-[15px] md:text-[16px] leading-[1.85] text-gray-800">
              {paragraphs.map((p, i) => (
                <p key={i} dangerouslySetInnerHTML={{ __html: sanitizeHtml(p) }} />
              ))}
            </div>
          ) : (
            <p className="text-[15px] md:text-[16px] leading-[1.85] text-gray-800">
              {program.description}
            </p>
          )}

          {/* Duration pill — hidden when the programme has no
              published duration, so the clock icon never sits alone. */}
          {program.duration && (
            <div className="mt-7 inline-flex items-center gap-2 rounded-full bg-primary/5 px-4 py-2">
              <Clock size={16} className="text-accent" />
              <span className="text-[13px] font-semibold text-primary">
                {program.duration}
              </span>
            </div>
          )}
        </section>

        {/* ───── At a Glance — separate stat cards ───── */}
        {stats.length > 0 && (
          <section className="mb-14 md:mb-20">
            <h2 className="mb-8 text-center font-display text-xl font-bold text-primary md:text-2xl">
              At a Glance
            </h2>
            <div className="mx-auto grid max-w-6xl grid-cols-2 gap-4 lg:grid-cols-4">
              {stats.map((stat) => (
                <div
                  key={stat.label}
                  className="rounded-xl border border-gray-100 bg-white p-5 text-center shadow-sm transition-shadow hover:shadow-md"
                >
                  <div className="mb-3 inline-flex h-11 w-11 items-center justify-center rounded-lg bg-gradient-to-br from-primary to-accent text-white shadow-md">
                    <DynamicLucideIcon name={stat.iconName ?? ''} size={20} strokeWidth={1.75} />
                  </div>
                  <div className="mb-1 text-[10px] font-bold uppercase tracking-wider text-gray-500">
                    {stat.label}
                  </div>
                  <div className="font-display text-lg font-bold leading-tight text-primary md:text-xl">
                    {stat.value}
                  </div>
                </div>
              ))}
            </div>
          </section>
        )}

        {/* ───── Specializations — one panel of pill rows ───── */}
        {program.specializations.length > 0 && (
          <section className="mx-auto mb-14 max-w-6xl md:mb-20">
            <div className="rounded-2xl border border-gray-100 bg-white p-8 shadow-sm md:p-10">
              <h2 className="mb-6 text-center font-display text-xl font-bold text-primary md:text-2xl">
                Specializations
              </h2>
              <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
                {program.specializations.map((spec) => (
                  <div
                    key={spec}
                    className="flex items-center gap-3 rounded-lg bg-primary/5 px-4 py-3"
                  >
                    <CheckCircle2 size={20} className="shrink-0 text-accent" />
                    <span className="text-[15px] font-semibold text-primary">
                      {spec}
                    </span>
                  </div>
                ))}
              </div>
            </div>
          </section>
        )}

        {/* ───── Course Structure — per-program curriculum ───── */}
        {semesters.length > 0 && (
          <section className="mx-auto mb-14 max-w-6xl md:mb-20">
            <h2 className="mb-2 text-center font-display text-xl font-bold text-primary md:text-2xl">
              Course Structure
            </h2>
            {program.courseStructureTotal && (
              <p className="mb-6 text-center text-[15px] text-gray-600">
                {program.courseStructureTotal}
              </p>
            )}

            <div className="flex flex-col gap-5">
              {semesters.map((sem, si) => (
                <div
                  key={si}
                  className="overflow-hidden rounded-2xl border border-gray-100 bg-white shadow-sm"
                >
                  <header className="border-b border-gray-200 bg-primary/5 px-6 py-4">
                    <h3 className="font-display text-base font-bold text-primary md:text-lg">
                      {sem.title}
                    </h3>
                    {sem.note && (
                      <p className="mt-1 text-[13px] leading-relaxed text-gray-600">
                        {sem.note}
                      </p>
                    )}
                  </header>

                  {/* Course titles run long, so the table scrolls
                      horizontally on narrow screens. */}
                  <div className="overflow-x-auto">
                    <table className="w-full min-w-[620px] border-collapse text-left">
                      <thead>
                        <tr className="border-b border-gray-200 bg-gray-50 text-[12px] font-bold uppercase tracking-wider text-gray-500">
                          <th scope="col" className="w-14 px-5 py-2.5">Sl.</th>
                          <th scope="col" className="w-32 px-5 py-2.5">Course Code</th>
                          <th scope="col" className="px-5 py-2.5">Course Title</th>
                          <th scope="col" className="w-32 px-5 py-2.5 text-center">Contact hrs./week</th>
                          <th scope="col" className="w-24 px-5 py-2.5 text-center">Credits</th>
                        </tr>
                      </thead>
                      <tbody>
                        {sem.courses.map((c, ci) => (
                          <tr key={ci} className="border-b border-gray-100 last:border-b-0">
                            <td className="px-5 py-3 align-top text-[14px] text-gray-400">
                              {ci + 1}
                            </td>
                            <td className="px-5 py-3 align-top">
                              <span className="font-mono text-[13.5px] font-semibold text-primary">
                                {c.code}
                              </span>
                            </td>
                            <td className="px-5 py-3 align-top text-[14.5px] leading-[1.6] text-gray-800">
                              {c.title}
                            </td>
                            <td className="px-5 py-3 text-center align-top text-[14px] text-gray-600">
                              {c.contact || '—'}
                            </td>
                            <td className="px-5 py-3 text-center align-top font-display text-[14px] font-bold text-accent">
                              {c.credits || '—'}
                            </td>
                          </tr>
                        ))}
                      </tbody>
                    </table>
                  </div>

                  {sem.footer && (
                    <p className="border-t border-gray-100 bg-gray-50/60 px-6 py-3 text-[13px] text-gray-600">
                      {sem.footer}
                    </p>
                  )}
                </div>
              ))}
            </div>

            {/* Major options — the final semester's elective tracks. */}
            {majorOptions.length > 0 && (
              <div className="mt-8">
                <h3 className="mb-2 text-center font-display text-lg font-bold text-primary md:text-xl">
                  Major Options
                </h3>
                {program.majorOptionsNote && (
                  <p className="mx-auto mb-6 max-w-3xl text-center text-[14px] leading-relaxed text-gray-600">
                    {program.majorOptionsNote}
                  </p>
                )}

                <div className="grid gap-5 lg:grid-cols-2">
                  {majorOptions.map((opt, oi) => (
                    <div
                      key={oi}
                      className="overflow-hidden rounded-2xl border border-gray-100 bg-white shadow-sm"
                    >
                      <header className="flex items-center gap-3 border-b border-gray-200 bg-primary/5 px-5 py-3.5">
                        {opt.roman && (
                          <span className="flex h-8 w-8 shrink-0 items-center justify-center rounded-lg bg-gradient-to-br from-primary to-accent text-[12px] font-bold text-white">
                            {opt.roman}
                          </span>
                        )}
                        <h4 className="font-display text-[15px] font-bold text-primary">
                          {opt.name}
                        </h4>
                      </header>
                      <ul className="divide-y divide-gray-100">
                        {opt.courses.map((c, ci) => (
                          <li key={ci} className="flex gap-3 px-5 py-3">
                            <span className="w-20 shrink-0 font-mono text-[12.5px] font-semibold text-primary">
                              {c.code}
                            </span>
                            <span className="flex-1 text-[14px] leading-[1.6] text-gray-800">
                              {c.title}
                            </span>
                            <span className="shrink-0 font-display text-[13px] font-bold text-accent">
                              {c.credits}
                            </span>
                          </li>
                        ))}
                      </ul>
                    </div>
                  ))}
                </div>
              </div>
            )}
          </section>
        )}

        {/* ───── Career Prospects — shared across every program ───── */}
        {(careerIntro.length > 0 || careerRows.length > 0) && (
          <section className="mx-auto mb-14 max-w-6xl md:mb-20">
            <h2 className="mb-6 text-center font-display text-xl font-bold text-primary md:text-2xl">
              {careers?.heading ?? 'Career Prospects'}
            </h2>
            <div className="rounded-2xl border border-gray-100 bg-white p-8 shadow-sm md:p-10">
              {careerIntro.length > 0 && (
                <div className="mx-auto mb-8 flex max-w-3xl flex-col gap-5">
                  {careerIntro.map((p, i) => (
                    <p key={i} className="text-[15px] leading-[1.85] text-gray-700">
                      {p}
                    </p>
                  ))}
                </div>
              )}

              {careerRows.length > 0 && (
                // Three columns of prose need width, so the table scrolls
                // horizontally on narrow screens rather than wrapping to shreds.
                <div className="overflow-x-auto">
                  <table className="w-full min-w-[720px] border-collapse text-left align-top">
                    <thead>
                      <tr className="border-b border-gray-300 bg-gray-50 text-[13px] font-bold text-gray-700">
                        <th scope="col" className="w-[22%] px-5 py-3">
                          {careers?.areaLabel ?? 'Functional Areas'}
                        </th>
                        <th scope="col" className="px-5 py-3">
                          {careers?.rolesLabel ?? 'Primary Career Roles'}
                        </th>
                        <th scope="col" className="px-5 py-3">
                          {careers?.sectorsLabel ?? 'Leading Target Sectors'}
                        </th>
                      </tr>
                    </thead>
                    <tbody>
                      {careerRows.map((r, i) => (
                        <tr key={i} className="border-b border-gray-200 last:border-b-0">
                          <td className="px-5 py-4 align-top">
                            <span className="text-[15px] font-semibold text-primary">
                              {r.area}
                            </span>
                          </td>
                          <td className="px-5 py-4 align-top text-[14.5px] leading-[1.7] text-gray-700">
                            {r.roles}
                          </td>
                          <td className="px-5 py-4 align-top text-[14.5px] leading-[1.7] text-gray-600">
                            {r.sectors}
                          </td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
              )}
            </div>
          </section>
        )}

        {/* ───── Ready to Apply ───── */}
        <section className="mx-auto max-w-3xl">
          <div className="rounded-2xl bg-primary p-8 text-center shadow-2xl md:p-12">
            <h2 className="mb-4 font-display text-2xl font-bold text-white md:text-3xl">
              Ready to Apply?
            </h2>
            <p className="mx-auto mb-8 max-w-lg text-[15px] leading-relaxed text-white/80">
              Take the next step toward your career in {program.programName}.
              Review the admission requirements or explore the tuition fee
              structure.
            </p>
            <div className="flex flex-col justify-center gap-4 sm:flex-row">
              <Link
                href="/admission/requirements"
                className="inline-flex items-center justify-center gap-2 rounded-lg bg-button-yellow px-8 py-3.5 font-bold text-primary shadow-md transition-colors hover:bg-button-yellow/90"
              >
                <ClipboardList size={18} />
                View Requirements
              </Link>
              <Link
                href="/admission/tuition-fees"
                className="inline-flex items-center justify-center gap-2 rounded-lg border-2 border-white/30 px-8 py-3.5 font-bold text-white transition-colors hover:bg-white/10"
              >
                <CreditCard size={18} />
                Tuition Fees
              </Link>
            </div>
          </div>
        </section>
      </Container>
    </PageShell>
  );
}
