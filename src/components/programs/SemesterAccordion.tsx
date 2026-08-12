'use client';

import { useState } from 'react';
import { BookOpen, ChevronDown } from 'lucide-react';

// Collapsible semester list for the Course Structure section. Only the
// open panel's table is mounted, so a nine-semester plan doesn't ship
// ~50 table rows of markup the reader never expands.

export type Course = {
  code: string;
  title: string;
  contact: string;
  credits: string;
};

export type Semester = {
  title: string;
  note: string;
  courses: Course[];
  footer: string;
};

function slugify(s: string): string {
  return s.toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/(^-|-$)/g, '');
}

// Credits are stored as strings ("3.00", "0.75", "----"), so sum
// defensively and drop the trailing zeros the source pads them with.
function sumCredits(courses: Course[]): string {
  const total = courses.reduce((acc, c) => {
    const n = Number.parseFloat(c.credits);
    return acc + (Number.isFinite(n) ? n : 0);
  }, 0);
  return String(Number(total.toFixed(2)));
}

export default function SemesterAccordion({
  semesters,
  defaultOpen = 0,
}: {
  semesters: Semester[];
  defaultOpen?: number;
}) {
  const [openIndex, setOpenIndex] = useState<number | null>(defaultOpen);

  return (
    <div className="mx-auto flex max-w-6xl flex-col gap-3">
      {semesters.map((sem, i) => {
        const isOpen = openIndex === i;
        const panelId = `semester-${slugify(sem.title)}`;

        return (
          <div
            key={i}
            className="overflow-hidden rounded-xl border border-gray-200 bg-white"
          >
            <button
              type="button"
              aria-expanded={isOpen}
              aria-controls={panelId}
              onClick={() => setOpenIndex(isOpen ? null : i)}
              className="flex w-full items-center justify-between gap-4 px-5 py-4 text-left transition-colors hover:bg-gray-50"
            >
              <span className="flex min-w-0 items-center gap-3">
                <span className="inline-flex size-9 shrink-0 items-center justify-center rounded-lg bg-primary/5 text-primary">
                  <BookOpen size={17} strokeWidth={1.75} />
                </span>
                <span className="min-w-0">
                  <span className="block truncate font-display text-[15px] font-bold text-primary">
                    {sem.title}
                  </span>
                  <span className="block text-xs text-gray-500">
                    {sem.courses.length} courses · {sumCredits(sem.courses)} credits
                  </span>
                </span>
              </span>
              <ChevronDown
                size={18}
                className={`shrink-0 text-gray-400 transition-transform ${
                  isOpen ? 'rotate-180' : ''
                }`}
                aria-hidden="true"
              />
            </button>

            {isOpen && (
              <div id={panelId} className="overflow-x-auto border-t border-gray-100">
                {sem.note && (
                  <p className="border-b border-gray-100 bg-gray-50/60 px-5 py-2.5 text-[13px] leading-relaxed text-gray-600">
                    {sem.note}
                  </p>
                )}
                <table className="w-full min-w-[34rem] text-left text-[14px]">
                  <caption className="sr-only">Courses in {sem.title}</caption>
                  <thead>
                    <tr className="bg-gray-50 text-[11px] font-semibold uppercase tracking-wider text-gray-500">
                      <th scope="col" className="px-5 py-2.5">Code</th>
                      <th scope="col" className="px-5 py-2.5">Course</th>
                      <th scope="col" className="px-5 py-2.5 text-right">Credits</th>
                    </tr>
                  </thead>
                  <tbody>
                    {sem.courses.map((c, ci) => (
                      <tr key={ci} className="border-t border-gray-100">
                        <td className="whitespace-nowrap px-5 py-3 font-mono text-[13px] text-primary">
                          {c.code}
                        </td>
                        <td className="px-5 py-3">
                          <span className="font-medium text-gray-800">{c.title}</span>
                        </td>
                        <td className="px-5 py-3 text-right font-semibold tabular-nums text-gray-700">
                          {c.credits}
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
                {sem.footer && (
                  <p className="border-t border-gray-100 bg-gray-50/60 px-5 py-2.5 text-[13px] text-gray-600">
                    {sem.footer}
                  </p>
                )}
              </div>
            )}
          </div>
        );
      })}
    </div>
  );
}
