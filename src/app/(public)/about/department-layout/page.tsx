import Image from 'next/image';
import { Download, ExternalLink, Image as ImageIcon } from 'lucide-react';
import PageShell from '@/components/layout/PageShell';
import Container from '@/components/ui/Container';
import { getAboutDepartmentLayout } from '@/lib/identity';

export const metadata = {
  title: 'Department Layout — Department of Business Administration',
  description:
    'Office directory and layout plan for the Department of Business Administration, Sonargaon University.',
};

type OfficeRow = {
  office: string;
  location: string;
  building: string;
  highlight: boolean;
};

function toOfficeRows(v: unknown): OfficeRow[] {
  if (!Array.isArray(v)) return [];
  return v
    .filter((r): r is Record<string, unknown> =>
      typeof r === 'object' && r !== null,
    )
    .map((r) => ({
      office:    typeof r.office === 'string' ? r.office : '',
      location:  typeof r.location === 'string' ? r.location : '',
      building:  typeof r.building === 'string' ? r.building : '',
      highlight: r.highlight === true,
    }))
    .filter((r) => r.office !== '' && r.location !== '');
}

export default async function DepartmentLayoutPage() {
  const row = await getAboutDepartmentLayout();
  if (!row) {
    throw new Error(
      'AboutDepartmentLayout row missing (id="singleton"). Create it from the admin panel.',
    );
  }

  const paragraphs = Array.isArray(row.paragraphs)
    ? (row.paragraphs as unknown[]).filter(
        (p): p is string => typeof p === 'string' && p.trim() !== '',
      )
    : [];

  const offices = toOfficeRows(row.roomRows);

  return (
    <PageShell
      title={row.heroTitle}
      overline={row.heroOverline ?? undefined}
      image={row.heroImageUrl}
      imagePosition={`center ${row.heroImageVerticalPercent}%`}
      contentClassName="bg-gray-50 py-12 md:py-20"
    >
      <Container>
        {paragraphs.length > 0 && (
          <div className="mx-auto mb-10 max-w-3xl space-y-6 text-[16px] leading-[1.85] text-gray-800 md:text-[17px] md:mb-14">
            {paragraphs.map((p, i) => (
              <p key={i}>{p}</p>
            ))}
          </div>
        )}

        {offices.length > 0 && (
          <section className="mx-auto max-w-4xl">
            <div className="overflow-hidden rounded-2xl border border-gray-300 bg-white shadow-sm">
              <header className="border-b border-gray-300 px-6 py-6 text-center">
                <h2 className="font-display text-xl font-bold text-primary md:text-2xl">
                  {row.tableUniversity}
                </h2>
                <p className="mt-1 text-[15px] text-gray-700">
                  {row.tableDepartment}
                </p>
                <p className="mt-0.5 text-[13.5px] text-gray-500">
                  {row.tableAddress}
                </p>
              </header>

              {/* Long office names force a min-width, so the table scrolls
                  horizontally on narrow screens instead of wrapping to shreds. */}
              <div className="overflow-x-auto">
                <table className="w-full min-w-[520px] text-left align-top text-[15px]">
                  <caption className="sr-only">
                    Each office of {row.tableUniversity} and where it is located
                  </caption>
                  <thead>
                    <tr className="border-b border-gray-300 bg-gray-50 text-[13px] font-bold text-gray-700">
                      <th scope="col" className="w-[45%] px-5 py-3">
                        {row.columnOfficeLabel}
                      </th>
                      <th scope="col" className="px-5 py-3">
                        {row.columnLocationLabel}
                      </th>
                    </tr>
                  </thead>
                  <tbody>
                    {offices.map((o, i) => (
                      <tr key={i} className="border-b border-gray-200 last:border-b-0">
                        <td className="px-5 py-3.5 align-top">
                          {/* This department's own offices are bolded so a
                              visitor can find them in the wider list. */}
                          <span
                            className={
                              o.highlight
                                ? 'font-semibold text-primary'
                                : 'text-gray-800'
                            }
                          >
                            {o.office}
                          </span>
                        </td>
                        <td className="px-5 py-3.5 align-top text-gray-700">
                          <span className="block">{o.location}</span>
                          {o.building && (
                            <span className="block text-[13.5px] text-gray-500">
                              Building: {o.building}
                            </span>
                          )}
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            </div>
          </section>
        )}

        {row.coverUrl || row.pdfUrl ? (
          <div className={offices.length > 0 ? 'mt-14 md:mt-20' : ''}>
            <h2 className="mb-2 text-center font-display text-xl font-bold text-primary md:text-2xl">
              Download the plan
            </h2>
            <p className="mx-auto mb-8 max-w-xl text-center text-[15px] text-gray-600">
              The same directory as a printable document.
            </p>

            <div className="flex justify-center">
              <article className="flex w-full max-w-md flex-col overflow-hidden rounded-xl border border-gray-100 bg-white shadow-sm transition-shadow hover:shadow-md">
                {row.coverUrl ? (
                  <div className="bg-gray-50">
                    <Image
                      src={row.coverUrl}
                      alt={row.cardTitle}
                      width={800}
                      height={1000}
                      sizes="(min-width: 768px) 448px, 100vw"
                      className="block h-auto w-full"
                      priority
                    />
                  </div>
                ) : (
                  // Cover is still to be uploaded — a placeholder holds the
                  // card's proportions instead of collapsing it.
                  <div className="flex aspect-[3/4] flex-col items-center justify-center gap-3 border-b border-dashed border-gray-200 bg-gray-50 text-gray-400">
                    <ImageIcon size={32} strokeWidth={1.5} aria-hidden="true" />
                    <span className="text-[13px] font-medium">
                      Cover image coming soon
                    </span>
                  </div>
                )}

                <div className="flex flex-1 flex-col p-5">
                  <h3 className="mb-1 font-display text-base font-bold leading-snug text-primary md:text-lg">
                    {row.cardTitle}
                  </h3>

                  {row.pdfUrl ? (
                    <div className="mt-4 flex flex-col gap-2.5">
                      {/* View opens in a new tab so the visitor keeps this
                          page; Download forces a save via the download attr. */}
                      <a
                        href={row.pdfUrl}
                        target="_blank"
                        rel="noopener noreferrer"
                        className="inline-flex w-full items-center justify-center gap-2 rounded-md bg-primary px-5 py-3 text-sm font-semibold text-white transition-colors hover:bg-primary/90"
                      >
                        <ExternalLink size={16} />
                        View Layout
                      </a>
                      <a
                        href={row.pdfUrl}
                        download={row.pdfFileName ?? 'Layout-Plan'}
                        className="inline-flex w-full items-center justify-center gap-2 rounded-md border-2 border-primary bg-white px-5 py-3 text-sm font-semibold text-primary transition-colors hover:bg-primary hover:text-white"
                      >
                        <Download size={16} />
                        Download
                      </a>
                    </div>
                  ) : (
                    <span className="mt-4 inline-flex w-full cursor-not-allowed items-center justify-center gap-2 rounded-md bg-gray-100 px-5 py-3 text-sm font-semibold text-gray-400">
                      PDF not uploaded yet
                    </span>
                  )}
                </div>
              </article>
            </div>
          </div>
        ) : (
          offices.length === 0 && (
            <div className="rounded-2xl border border-dashed border-gray-300 bg-white p-10 text-center md:p-14">
              <p className="font-display text-lg font-bold text-primary md:text-xl">
                Content coming soon
              </p>
              <p className="mx-auto mt-2 max-w-xl text-sm leading-relaxed text-gray-500">
                The department layout is being prepared and will be published
                here shortly.
              </p>
            </div>
          )
        )}
      </Container>
    </PageShell>
  );
}
