import { Fragment } from 'react';
import { ArrowRight, UserRound, FileText, Download } from 'lucide-react';
import PageShell from '@/components/layout/PageShell';
import Container from '@/components/ui/Container';
import { getServiceCharter, getPageHero } from '@/lib/identity';

export const metadata = {
  title: 'Service Charter — Department of Business Administration',
  description:
    'What to do, in what order, and who to ask for the services students need from the Department of Business Administration office.',
};

const LINK_CLASS =
  'text-primary decoration-primary/40 hover:decoration-primary underline underline-offset-2 transition-colors break-words';

// Steps are stored as plain sentences that embed bare URLs and email
// addresses ("…follow https://su.edu.bd/… for updates"). Rendering them
// raw would leave those unclickable, so they are split out here rather
// than requiring the admin to write HTML.
const TOKEN = /(https?:\/\/[^\s,)]+[^\s,).]|[\w.+-]+@[\w-]+\.[\w.]+)/g;

function linkify(text: string) {
  return text.split(TOKEN).map((part, i) => {
    if (/^https?:\/\//.test(part)) {
      return (
        <a
          key={i}
          href={part}
          target="_blank"
          rel="noopener noreferrer"
          className={LINK_CLASS}
        >
          {part}
        </a>
      );
    }
    if (/^[\w.+-]+@[\w-]+\.[\w.]+$/.test(part)) {
      return (
        <a key={i} href={`mailto:${part}`} className={LINK_CLASS}>
          {part}
        </a>
      );
    }
    return <Fragment key={i}>{part}</Fragment>;
  });
}

function coerceSteps(v: unknown): string[] {
  if (!Array.isArray(v)) return [];
  return v.filter((s): s is string => typeof s === 'string' && s.trim() !== '');
}

export default async function ServiceCharterPage() {
  const [{ items, meta }, hero] = await Promise.all([
    getServiceCharter(),
    getPageHero('student-society-service-charter'),
  ]);

  return (
    <PageShell
      title={hero?.heroTitle ?? 'Service Charter'}
      subtitle={hero?.heroSubtitle ?? undefined}
      overline={hero?.heroOverline ?? 'Student Society'}
      image={hero?.heroImageUrl ?? undefined}
      imagePosition={hero ? `center ${hero.heroImageVerticalPercent}%` : undefined}
      contentClassName="bg-gray-50 py-12 md:py-16"
    >
      <Container>
        {meta?.intro && (
          <p className="mx-auto mb-10 max-w-3xl text-center text-[15px] leading-[1.85] text-gray-700 md:mb-14">
            {meta.intro}
          </p>
        )}

        {items.length === 0 ? (
          <div className="rounded-2xl border border-dashed border-gray-300 bg-white p-12 text-center">
            <p className="text-gray-500">Service charter will be updated soon.</p>
          </div>
        ) : (
          <>
            <div className="mx-auto grid max-w-[1400px] gap-5 md:gap-6 lg:grid-cols-2 xl:grid-cols-3">
              {items.map((item, idx) => {
                const steps = coerceSteps(item.steps);
                // A single step is an instruction, not a sequence — the
                // source document numbers only multi-step services.
                const numbered = steps.length > 1;

                return (
                  <article
                    key={item.id}
                    className="flex flex-col rounded-xl border border-gray-100 bg-white p-6 shadow-sm transition-shadow hover:shadow-lg md:p-7"
                  >
                    <header className="mb-4 flex items-start gap-3">
                      <span className="inline-flex size-9 shrink-0 items-center justify-center rounded-full bg-primary font-display text-[14px] font-bold text-white">
                        {idx + 1}
                      </span>
                      <h2 className="mt-1 text-[16px] font-bold leading-snug text-primary">
                        {item.title}
                      </h2>
                    </header>

                    <ol className="mb-5 flex flex-1 flex-col gap-3">
                      {steps.map((step, si) => (
                        <li
                          key={si}
                          className="flex gap-3 text-[14px] leading-[1.7] text-gray-700"
                        >
                          {numbered ? (
                            <span className="mt-0.5 inline-flex size-5 shrink-0 items-center justify-center rounded-full bg-accent/10 text-[11px] font-bold text-accent">
                              {si + 1}
                            </span>
                          ) : (
                            <ArrowRight
                              size={15}
                              className="mt-1 shrink-0 text-accent"
                              aria-hidden="true"
                            />
                          )}
                          <span className="min-w-0 break-words">{linkify(step)}</span>
                        </li>
                      ))}
                    </ol>

                    {item.personName && (
                      <footer className="mt-auto flex gap-2.5 border-t border-gray-100 pt-4">
                        <UserRound
                          size={15}
                          className="mt-0.5 shrink-0 text-gray-400"
                          aria-hidden="true"
                        />
                        <div className="min-w-0 text-[13px] leading-[1.65] text-gray-600">
                          <span className="block font-semibold text-gray-800">
                            {item.personName}
                          </span>
                          {item.personPhone && (
                            <span className="block">
                              Contact No:{' '}
                              <a
                                href={`tel:${item.personPhone.replace(/[^\d+]/g, '')}`}
                                className={LINK_CLASS}
                              >
                                {item.personPhone}
                              </a>
                            </span>
                          )}
                          {item.personEmail && (
                            <span className="block">
                              e-mail:{' '}
                              <a href={`mailto:${item.personEmail}`} className={LINK_CLASS}>
                                {item.personEmail}
                              </a>
                              {item.personNote && ` ${item.personNote}`}
                            </span>
                          )}
                          {item.personRoom && (
                            <span className="block">Room no: {item.personRoom}</span>
                          )}
                        </div>
                      </footer>
                    )}
                  </article>
                );
              })}
            </div>

            {/* Download card — hidden until a PDF is uploaded. */}
            {meta?.pdfUrl && (
              <div className="mx-auto mt-12 max-w-[1400px] md:mt-16">
                <div className="flex flex-col items-center gap-5 rounded-2xl border border-primary/15 bg-gradient-to-r from-primary/5 via-white to-white p-6 text-center shadow-sm sm:flex-row sm:p-8 sm:text-left">
                  <span className="inline-flex size-14 shrink-0 items-center justify-center rounded-2xl bg-gradient-to-br from-primary to-accent text-white shadow-md">
                    <FileText size={26} strokeWidth={1.75} aria-hidden="true" />
                  </span>
                  <div className="min-w-0 flex-1">
                    <p className="font-display text-[17px] font-bold text-primary md:text-lg">
                      Service Charter as a PDF
                    </p>
                    <p className="mt-0.5 text-[14.5px] text-gray-600">
                      All {items.length} services, their steps and the person
                      responsible for each — in one document you can keep or print.
                    </p>
                  </div>
                  <a
                    href={meta.pdfUrl}
                    download={meta.pdfFileName || undefined}
                    target="_blank"
                    rel="noopener noreferrer"
                    className="inline-flex shrink-0 items-center justify-center gap-2 rounded-lg bg-primary px-7 py-3.5 font-semibold text-white shadow-md transition-colors hover:bg-primary/90"
                  >
                    <Download size={18} aria-hidden="true" />
                    Download PDF
                  </a>
                </div>
              </div>
            )}
          </>
        )}
      </Container>
    </PageShell>
  );
}
