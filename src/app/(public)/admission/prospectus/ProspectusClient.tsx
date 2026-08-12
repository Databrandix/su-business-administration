'use client';

import { useMemo, useState } from 'react';
import { Search, Download, FileText, ExternalLink, BookOpen } from 'lucide-react';

type Level = 'Undergraduate' | 'Postgraduate';

export interface ProspectusItem {
  slug: string;
  title: string;
  shortTitle: string;
  department: string;
  // 'Undergraduate' | 'Postgraduate' (Zod-validated upstream), or null
  // for entries that belong to neither tier — those render without the
  // level pill and only appear under the "All" tab.
  level: string | null;
  // No `cover` here: the page embeds the PDF itself rather than a
  // thumbnail of it. The coverUrl column is still populated in the DB and
  // still editable in admin, so covers can return without a migration.
  pdf: string;
}

const filters: ('All' | Level)[] = ['All', 'Undergraduate', 'Postgraduate'];

export default function ProspectusClient({ items }: { items: ProspectusItem[] }) {
  const [query, setQuery] = useState('');
  const [active, setActive] = useState<'All' | Level>('All');

  const filtered = useMemo(() => {
    const q = query.trim().toLowerCase();
    return items.filter((p) => {
      if (active !== 'All' && p.level !== active) return false;
      if (!q) return true;
      return (
        p.title.toLowerCase().includes(q) ||
        p.department.toLowerCase().includes(q) ||
        (p.level?.toLowerCase().includes(q) ?? false)
      );
    });
  }, [items, query, active]);

  return (
    <>
      {/* Search + Filters */}
      <div className="flex flex-col lg:flex-row gap-3 lg:items-center mb-3">
        <div className="relative flex-1">
          <Search
            size={18}
            className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 pointer-events-none"
          />
          <input
            type="text"
            value={query}
            onChange={(e) => setQuery(e.target.value)}
            placeholder="Search programs..."
            className="w-full pl-11 pr-4 py-3 rounded-lg border border-gray-200 bg-white text-sm placeholder:text-gray-400 focus:outline-none focus:border-accent focus:ring-2 focus:ring-accent/15 transition"
          />
        </div>

        <div className="flex gap-2 flex-wrap">
          {filters.map((f) => {
            const isActive = active === f;
            return (
              <button
                key={f}
                type="button"
                onClick={() => setActive(f)}
                className={`px-5 py-3 rounded-lg text-sm font-semibold transition-all whitespace-nowrap ${
                  isActive
                    ? 'bg-primary text-white shadow-md'
                    : 'bg-white text-gray-700 border border-gray-200 hover:border-accent hover:text-accent'
                }`}
              >
                {f}
              </button>
            );
          })}
        </div>
      </div>

      <p className="text-sm text-gray-500 mb-8">
        Showing <span className="font-semibold text-primary">{filtered.length}</span>{' '}
        {filtered.length === 1 ? 'program' : 'programs'}
      </p>

      {/* Program cards */}
      {filtered.length === 0 ? (
        <div className="bg-white rounded-2xl border border-dashed border-gray-300 p-12 text-center">
          {active === 'Postgraduate' && !query ? (
            <>
              <p className="text-primary font-semibold text-base mb-1">
                Postgraduate prospectus coming soon
              </p>
              <p className="text-gray-500 text-sm">
                Postgraduate programs in Business Administration are not offered yet. Please check back later for updates.
              </p>
            </>
          ) : (
            <p className="text-gray-500">No programs match your search.</p>
          )}
        </div>
      ) : (
        <>
          {/* One full-width reader per programme that has a PDF, so the
              document itself is the page rather than a thumbnail of it. */}
          {filtered
            .filter((p) => p.pdf)
            .map((p) => (
              <section key={p.slug} className="mb-10 md:mb-14">
                <div className="mb-4 flex flex-wrap items-end justify-between gap-3">
                  <div>
                    <h2 className="font-display text-lg font-bold text-primary md:text-xl">
                      {p.shortTitle}
                    </h2>
                    <p className="text-sm text-gray-600">{p.department}</p>
                  </div>
                  <a
                    href={p.pdf}
                    target="_blank"
                    rel="noopener noreferrer"
                    className="inline-flex items-center gap-1.5 text-sm font-semibold text-primary transition-colors hover:text-accent"
                  >
                    <ExternalLink size={15} />
                    Open in a new tab
                  </a>
                </div>

                {/* A4 ratio on phones where a tall viewport is fine;
                    a viewport-relative height from sm up so the reader
                    never runs longer than the screen. */}
                <div className="aspect-[595/842] min-h-[320px] overflow-hidden rounded-2xl border border-gray-200 bg-white shadow-sm sm:aspect-auto sm:h-[75vh] sm:min-h-[420px]">
                  <iframe
                    src={`${p.pdf}#toolbar=0&navpanes=0&statusbar=0&view=FitH`}
                    title={`${p.title} — prospectus`}
                    className="h-full w-full"
                  />
                </div>
              </section>
            ))}

          {/* Compact download rows — every programme, including any whose
              PDF is not published yet. */}
          <div className="mx-auto grid max-w-4xl gap-4">
            {filtered.map((p) => (
              <article
                key={p.slug}
                className="flex flex-col items-center gap-4 rounded-2xl border border-gray-200 bg-white p-5 text-center shadow-sm transition-shadow hover:shadow-md sm:flex-row sm:p-6 sm:text-left"
              >
                <span className="inline-flex size-12 shrink-0 items-center justify-center rounded-xl bg-gradient-to-br from-primary to-accent text-white shadow-md">
                  <BookOpen size={22} strokeWidth={1.75} aria-hidden="true" />
                </span>

                <div className="min-w-0 flex-1">
                  {p.level && (
                    <span
                      className={`mb-1.5 inline-block w-fit rounded-full px-3 py-1 text-[11px] font-bold uppercase tracking-wider ${
                        p.level === 'Undergraduate'
                          ? 'bg-primary/8 text-primary'
                          : 'bg-accent/10 text-accent'
                      }`}
                    >
                      {p.level}
                    </span>
                  )}
                  <p className="font-display text-[15px] font-bold text-primary md:text-base">
                    {p.shortTitle}
                  </p>
                  <p className="text-sm text-gray-500">{p.department}</p>
                </div>

                {p.pdf ? (
                  <a
                    href={p.pdf}
                    download
                    className="inline-flex shrink-0 items-center justify-center gap-2 rounded-lg bg-primary px-6 py-3 font-semibold text-white shadow-md transition-colors hover:bg-primary/90"
                  >
                    <Download size={17} />
                    Download PDF
                  </a>
                ) : (
                  <span className="inline-flex shrink-0 cursor-not-allowed items-center justify-center gap-2 rounded-lg bg-gray-100 px-6 py-3 font-semibold text-gray-400">
                    <FileText size={17} />
                    PDF coming soon
                  </span>
                )}
              </article>
            ))}
          </div>
        </>
      )}
    </>
  );
}
