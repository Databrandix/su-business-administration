'use client';

import { useState } from 'react';
import { Plus, X, ArrowUp, ArrowDown } from 'lucide-react';

// Final-semester elective tracks for a Program:
//   { roman, name, courses: { code, title, contact, credits }[] }[]
// Same course-row shape as CourseStructureEditor, but grouped by major
// rather than by semester.

type Course = { code: string; title: string; contact: string; credits: string };
type Option = { roman: string; name: string; courses: Course[] };

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

function normalize(v: unknown): Option[] {
  if (!Array.isArray(v)) return [];
  return v
    .filter((o): o is Record<string, unknown> => typeof o === 'object' && o !== null)
    .map((o) => ({
      roman:   typeof o.roman === 'string' ? o.roman : '',
      name:    typeof o.name === 'string' ? o.name : '',
      courses: normalizeCourses(o.courses),
    }));
}

export default function MajorOptionsEditor({ name, initialValue }: Props) {
  const [options, setOptions] = useState<Option[]>(normalize(initialValue));

  function patchOption(i: number, patch: Partial<Option>) {
    setOptions(options.map((o, idx) => (idx === i ? { ...o, ...patch } : o)));
  }
  function addOption() {
    setOptions([...options, { roman: '', name: '', courses: [] }]);
  }
  function removeOption(i: number) {
    setOptions(options.filter((_, idx) => idx !== i));
  }
  function moveOption(i: number, dir: -1 | 1) {
    const j = i + dir;
    if (j < 0 || j >= options.length) return;
    const next = [...options];
    [next[i], next[j]] = [next[j], next[i]];
    setOptions(next);
  }

  function addCourse(oi: number) {
    patchOption(oi, {
      courses: [...options[oi].courses, { code: '', title: '', contact: '3.0', credits: '3.00' }],
    });
  }
  function patchCourse(oi: number, ci: number, patch: Partial<Course>) {
    patchOption(oi, {
      courses: options[oi].courses.map((c, idx) => (idx === ci ? { ...c, ...patch } : c)),
    });
  }
  function removeCourse(oi: number, ci: number) {
    patchOption(oi, { courses: options[oi].courses.filter((_, idx) => idx !== ci) });
  }
  function moveCourse(oi: number, ci: number, dir: -1 | 1) {
    const cj = ci + dir;
    const list = options[oi].courses;
    if (cj < 0 || cj >= list.length) return;
    const next = [...list];
    [next[ci], next[cj]] = [next[cj], next[ci]];
    patchOption(oi, { courses: next });
  }

  const cleaned = options
    .filter((o) => o.name.trim())
    .map((o) => ({
      ...o,
      courses: o.courses.filter((c) => c.code.trim() && c.title.trim()),
    }));

  return (
    <div className="space-y-4">
      {options.length === 0 && (
        <p className="text-xs text-gray-500 italic">
          No major options — leave empty for programs without elective tracks.
        </p>
      )}

      {options.map((opt, oi) => (
        <div key={oi} className="rounded-lg border border-gray-300 bg-white p-4 space-y-3">
          <div className="flex items-center gap-2">
            <input
              type="text"
              value={opt.roman}
              onChange={(e) => patchOption(oi, { roman: e.target.value })}
              placeholder="I"
              className="w-16 shrink-0 px-2 py-1.5 border border-gray-300 rounded-lg text-sm text-center font-semibold focus:outline-none focus:ring-2 focus:ring-accent/50"
            />
            <input
              type="text"
              value={opt.name}
              onChange={(e) => patchOption(oi, { name: e.target.value })}
              placeholder="Major name — e.g. Management"
              className="flex-1 px-3 py-1.5 border border-gray-300 rounded-lg text-sm font-semibold focus:outline-none focus:ring-2 focus:ring-accent/50 focus:border-accent"
            />
            <div className="flex items-center gap-0.5 shrink-0">
              <button type="button" onClick={() => moveOption(oi, -1)} disabled={oi === 0}
                      aria-label="Move option up"
                      className="p-1 text-gray-400 hover:text-primary disabled:opacity-30 transition-colors">
                <ArrowUp size={14} />
              </button>
              <button type="button" onClick={() => moveOption(oi, 1)} disabled={oi === options.length - 1}
                      aria-label="Move option down"
                      className="p-1 text-gray-400 hover:text-primary disabled:opacity-30 transition-colors">
                <ArrowDown size={14} />
              </button>
              <button type="button" onClick={() => removeOption(oi)}
                      aria-label="Remove option"
                      className="p-1.5 text-gray-400 hover:text-red-600 transition-colors">
                <X size={16} />
              </button>
            </div>
          </div>

          <div className="space-y-1.5">
            {opt.courses.map((c, ci) => (
              <div key={ci} className="flex items-center gap-2">
                <input type="text" value={c.code}
                       onChange={(e) => patchCourse(oi, ci, { code: e.target.value })}
                       placeholder="BA 4211"
                       className="w-24 shrink-0 px-2 py-1 border border-gray-300 rounded text-xs focus:outline-none focus:ring-2 focus:ring-accent/50" />
                <input type="text" value={c.title}
                       onChange={(e) => patchCourse(oi, ci, { title: e.target.value })}
                       placeholder="Management Consultancy"
                       className="flex-1 px-2 py-1 border border-gray-300 rounded text-xs focus:outline-none focus:ring-2 focus:ring-accent/50" />
                <input type="text" value={c.contact}
                       onChange={(e) => patchCourse(oi, ci, { contact: e.target.value })}
                       placeholder="3.0"
                       className="w-16 shrink-0 px-2 py-1 border border-gray-300 rounded text-xs focus:outline-none focus:ring-2 focus:ring-accent/50" />
                <input type="text" value={c.credits}
                       onChange={(e) => patchCourse(oi, ci, { credits: e.target.value })}
                       placeholder="3.00"
                       className="w-16 shrink-0 px-2 py-1 border border-gray-300 rounded text-xs focus:outline-none focus:ring-2 focus:ring-accent/50" />
                <div className="flex items-center gap-0.5 shrink-0">
                  <button type="button" onClick={() => moveCourse(oi, ci, -1)} disabled={ci === 0}
                          aria-label="Move course up"
                          className="p-0.5 text-gray-400 hover:text-primary disabled:opacity-30 transition-colors">
                    <ArrowUp size={12} />
                  </button>
                  <button type="button" onClick={() => moveCourse(oi, ci, 1)} disabled={ci === opt.courses.length - 1}
                          aria-label="Move course down"
                          className="p-0.5 text-gray-400 hover:text-primary disabled:opacity-30 transition-colors">
                    <ArrowDown size={12} />
                  </button>
                  <button type="button" onClick={() => removeCourse(oi, ci)}
                          aria-label="Remove course"
                          className="p-1 text-gray-400 hover:text-red-600 transition-colors">
                    <X size={13} />
                  </button>
                </div>
              </div>
            ))}
            <button type="button" onClick={() => addCourse(oi)}
                    className="inline-flex items-center gap-1 text-[11px] font-medium text-accent hover:text-accent/80 transition-colors">
              <Plus size={12} /> Add course
            </button>
          </div>
        </div>
      ))}

      <button type="button" onClick={addOption}
              className="inline-flex items-center gap-1.5 text-xs font-medium text-accent hover:text-accent/80 transition-colors">
        <Plus size={14} /> Add major option
      </button>

      <input type="hidden" name={name} value={JSON.stringify(cleaned)} />
    </div>
  );
}
