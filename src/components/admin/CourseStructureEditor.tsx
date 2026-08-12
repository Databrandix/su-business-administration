'use client';

import { useState } from 'react';
import { Plus, X, ArrowUp, ArrowDown } from 'lucide-react';

// Semester-by-semester course plan editor for a Program.
//   { title, note, courses: { code, title, contact, credits }[], footer }[]
// Each semester is a collapsible-ish block holding its own course rows,
// because a flat list of ~50 courses would be unusable to reorder.

type Course = { code: string; title: string; contact: string; credits: string };
type Semester = { title: string; note: string; courses: Course[]; footer: string };

type Props = {
  name: string;
  initialValue: unknown;
};

function normalizeCourses(v: unknown): Course[] {
  if (!Array.isArray(v)) return [];
  return v
    .filter((c): c is Record<string, unknown> => typeof c === 'object' && c !== null)
    .map((c) => ({
      code:    typeof c.code === 'string' ? c.code : '',
      title:   typeof c.title === 'string' ? c.title : '',
      contact: typeof c.contact === 'string' ? c.contact : '',
      credits: typeof c.credits === 'string' ? c.credits : '',
    }));
}

function normalize(v: unknown): Semester[] {
  if (!Array.isArray(v)) return [];
  return v
    .filter((s): s is Record<string, unknown> => typeof s === 'object' && s !== null)
    .map((s) => ({
      title:   typeof s.title === 'string' ? s.title : '',
      note:    typeof s.note === 'string' ? s.note : '',
      footer:  typeof s.footer === 'string' ? s.footer : '',
      courses: normalizeCourses(s.courses),
    }));
}

export default function CourseStructureEditor({ name, initialValue }: Props) {
  const [semesters, setSemesters] = useState<Semester[]>(normalize(initialValue));

  function patchSemester(i: number, patch: Partial<Semester>) {
    setSemesters(semesters.map((s, idx) => (idx === i ? { ...s, ...patch } : s)));
  }
  function addSemester() {
    setSemesters([...semesters, { title: '', note: '', courses: [], footer: '' }]);
  }
  function removeSemester(i: number) {
    setSemesters(semesters.filter((_, idx) => idx !== i));
  }
  function moveSemester(i: number, dir: -1 | 1) {
    const j = i + dir;
    if (j < 0 || j >= semesters.length) return;
    const next = [...semesters];
    [next[i], next[j]] = [next[j], next[i]];
    setSemesters(next);
  }

  function addCourse(si: number) {
    patchSemester(si, {
      courses: [...semesters[si].courses, { code: '', title: '', contact: '3.0', credits: '3.00' }],
    });
  }
  function patchCourse(si: number, ci: number, patch: Partial<Course>) {
    patchSemester(si, {
      courses: semesters[si].courses.map((c, idx) => (idx === ci ? { ...c, ...patch } : c)),
    });
  }
  function removeCourse(si: number, ci: number) {
    patchSemester(si, { courses: semesters[si].courses.filter((_, idx) => idx !== ci) });
  }
  function moveCourse(si: number, ci: number, dir: -1 | 1) {
    const cj = ci + dir;
    const list = semesters[si].courses;
    if (cj < 0 || cj >= list.length) return;
    const next = [...list];
    [next[ci], next[cj]] = [next[cj], next[ci]];
    patchSemester(si, { courses: next });
  }

  // A semester needs a title; courses missing a code or title would
  // render as blank table rows.
  const cleaned = semesters
    .filter((s) => s.title.trim())
    .map((s) => ({
      ...s,
      courses: s.courses.filter((c) => c.code.trim() && c.title.trim()),
    }));

  return (
    <div className="space-y-4">
      {semesters.length === 0 && (
        <p className="text-xs text-gray-500 italic">
          No semesters yet — the course structure section is hidden on the
          program page until one is added.
        </p>
      )}

      {semesters.map((sem, si) => (
        <div key={si} className="rounded-lg border border-gray-300 bg-white p-4 space-y-3">
          <div className="flex items-center gap-2">
            <span className="text-xs font-bold text-gray-400">{si + 1}.</span>
            <input
              type="text"
              value={sem.title}
              onChange={(e) => patchSemester(si, { title: e.target.value })}
              placeholder="Semester title — e.g. 1st Year 1st Semester"
              className="flex-1 px-3 py-1.5 border border-gray-300 rounded-lg text-sm font-semibold focus:outline-none focus:ring-2 focus:ring-accent/50 focus:border-accent"
            />
            <div className="flex items-center gap-0.5 shrink-0">
              <button type="button" onClick={() => moveSemester(si, -1)} disabled={si === 0}
                      aria-label="Move semester up"
                      className="p-1 text-gray-400 hover:text-primary disabled:opacity-30 transition-colors">
                <ArrowUp size={14} />
              </button>
              <button type="button" onClick={() => moveSemester(si, 1)} disabled={si === semesters.length - 1}
                      aria-label="Move semester down"
                      className="p-1 text-gray-400 hover:text-primary disabled:opacity-30 transition-colors">
                <ArrowDown size={14} />
              </button>
              <button type="button" onClick={() => removeSemester(si)}
                      aria-label="Remove semester"
                      className="p-1.5 text-gray-400 hover:text-red-600 transition-colors">
                <X size={16} />
              </button>
            </div>
          </div>

          <input
            type="text"
            value={sem.note}
            onChange={(e) => patchSemester(si, { note: e.target.value })}
            placeholder="Note above the table (optional)"
            className="w-full px-3 py-1.5 border border-gray-200 rounded-lg text-xs focus:outline-none focus:ring-2 focus:ring-accent/50 focus:border-accent"
          />

          <div className="space-y-1.5">
            {sem.courses.length > 0 && (
              <div className="flex items-center gap-2 px-1 text-[10px] font-semibold uppercase tracking-wider text-gray-400">
                <span className="w-24 shrink-0">Code</span>
                <span className="flex-1">Course title</span>
                <span className="w-16 shrink-0">Contact</span>
                <span className="w-16 shrink-0">Credits</span>
                <span className="w-[68px] shrink-0" />
              </div>
            )}
            {sem.courses.map((c, ci) => (
              <div key={ci} className="flex items-center gap-2">
                <input type="text" value={c.code}
                       onChange={(e) => patchCourse(si, ci, { code: e.target.value })}
                       placeholder="BA 1101"
                       className="w-24 shrink-0 px-2 py-1 border border-gray-300 rounded text-xs focus:outline-none focus:ring-2 focus:ring-accent/50" />
                <input type="text" value={c.title}
                       onChange={(e) => patchCourse(si, ci, { title: e.target.value })}
                       placeholder="Introduction to Business"
                       className="flex-1 px-2 py-1 border border-gray-300 rounded text-xs focus:outline-none focus:ring-2 focus:ring-accent/50" />
                <input type="text" value={c.contact}
                       onChange={(e) => patchCourse(si, ci, { contact: e.target.value })}
                       placeholder="3.0"
                       className="w-16 shrink-0 px-2 py-1 border border-gray-300 rounded text-xs focus:outline-none focus:ring-2 focus:ring-accent/50" />
                <input type="text" value={c.credits}
                       onChange={(e) => patchCourse(si, ci, { credits: e.target.value })}
                       placeholder="3.00"
                       className="w-16 shrink-0 px-2 py-1 border border-gray-300 rounded text-xs focus:outline-none focus:ring-2 focus:ring-accent/50" />
                <div className="flex items-center gap-0.5 shrink-0">
                  <button type="button" onClick={() => moveCourse(si, ci, -1)} disabled={ci === 0}
                          aria-label="Move course up"
                          className="p-0.5 text-gray-400 hover:text-primary disabled:opacity-30 transition-colors">
                    <ArrowUp size={12} />
                  </button>
                  <button type="button" onClick={() => moveCourse(si, ci, 1)} disabled={ci === sem.courses.length - 1}
                          aria-label="Move course down"
                          className="p-0.5 text-gray-400 hover:text-primary disabled:opacity-30 transition-colors">
                    <ArrowDown size={12} />
                  </button>
                  <button type="button" onClick={() => removeCourse(si, ci)}
                          aria-label="Remove course"
                          className="p-1 text-gray-400 hover:text-red-600 transition-colors">
                    <X size={13} />
                  </button>
                </div>
              </div>
            ))}
            <button type="button" onClick={() => addCourse(si)}
                    className="inline-flex items-center gap-1 text-[11px] font-medium text-accent hover:text-accent/80 transition-colors">
              <Plus size={12} /> Add course
            </button>
          </div>

          <input
            type="text"
            value={sem.footer}
            onChange={(e) => patchSemester(si, { footer: e.target.value })}
            placeholder="Footer line — e.g. Contact hours: 15.0 hrs./week · Total credits: 15.00"
            className="w-full px-3 py-1.5 border border-gray-200 rounded-lg text-xs focus:outline-none focus:ring-2 focus:ring-accent/50 focus:border-accent"
          />
        </div>
      ))}

      <button type="button" onClick={addSemester}
              className="inline-flex items-center gap-1.5 text-xs font-medium text-accent hover:text-accent/80 transition-colors">
        <Plus size={14} /> Add semester
      </button>

      <input type="hidden" name={name} value={JSON.stringify(cleaned)} />
    </div>
  );
}
