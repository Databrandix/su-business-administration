'use client';

import { useState } from 'react';
import { Plus, X, ArrowUp, ArrowDown } from 'lucide-react';

// { office, location, building, highlight }[] editor for the Department
// Layout directory table. `building` is the muted second line of the
// location cell; `highlight` bolds rows belonging to this department so
// visitors can pick them out of the university-wide list.

type Row = {
  office: string;
  location: string;
  building: string;
  highlight: boolean;
};

type Props = {
  name: string;
  initialValue: unknown;
  /** Prefilled as the building line on newly added rows. */
  defaultBuilding?: string;
};

function normalize(v: unknown): Row[] {
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
    }));
}

export default function RoomRowsEditor({
  name,
  initialValue,
  defaultBuilding = '',
}: Props) {
  const [rows, setRows] = useState<Row[]>(normalize(initialValue));

  function addRow() {
    setRows([
      ...rows,
      { office: '', location: '', building: defaultBuilding, highlight: false },
    ]);
  }
  function updateRow(i: number, patch: Partial<Row>) {
    setRows(rows.map((r, idx) => (idx === i ? { ...r, ...patch } : r)));
  }
  function removeRow(i: number) { setRows(rows.filter((_, idx) => idx !== i)); }
  function move(i: number, dir: -1 | 1) {
    const j = i + dir;
    if (j < 0 || j >= rows.length) return;
    const next = [...rows];
    [next[i], next[j]] = [next[j], next[i]];
    setRows(next);
  }

  // Office and location are the two required columns; a row missing
  // either would render as a half-empty table row.
  const cleaned = rows.filter((r) => r.office.trim() && r.location.trim());

  return (
    <div className="space-y-3">
      {rows.length === 0 && (
        <p className="text-xs text-gray-500 italic">
          No offices yet — the table is hidden on the public page until one is added.
        </p>
      )}

      {rows.map((row, i) => (
        <div
          key={i}
          className="rounded-lg border border-gray-200 bg-gray-50/60 p-3 space-y-2"
        >
          <div className="flex items-center gap-2">
            <span className="text-xs font-semibold text-gray-400">{i + 1}.</span>
            <input
              type="text"
              value={row.office}
              onChange={(e) => updateRow(i, { office: e.target.value })}
              placeholder="Name of the office — e.g. Head, Department of Business Administration"
              className="flex-1 px-3 py-1.5 border border-gray-300 rounded-lg text-sm bg-white focus:outline-none focus:ring-2 focus:ring-accent/50 focus:border-accent"
            />
            <div className="flex items-center gap-0.5 shrink-0">
              <button
                type="button" onClick={() => move(i, -1)} disabled={i === 0}
                aria-label="Move up"
                className="p-1 text-gray-400 hover:text-primary disabled:opacity-30 transition-colors"
              >
                <ArrowUp size={14} />
              </button>
              <button
                type="button" onClick={() => move(i, 1)} disabled={i === rows.length - 1}
                aria-label="Move down"
                className="p-1 text-gray-400 hover:text-primary disabled:opacity-30 transition-colors"
              >
                <ArrowDown size={14} />
              </button>
              <button
                type="button" onClick={() => removeRow(i)}
                aria-label="Remove office"
                className="p-1.5 text-gray-400 hover:text-red-600 transition-colors"
              >
                <X size={16} />
              </button>
            </div>
          </div>

          <div className="flex flex-col gap-2 pl-6 sm:flex-row">
            <input
              type="text"
              value={row.location}
              onChange={(e) => updateRow(i, { location: e.target.value })}
              placeholder="Location — e.g. Room 401, Sonargaon University"
              className="flex-1 px-3 py-1.5 border border-gray-300 rounded-lg text-sm bg-white focus:outline-none focus:ring-2 focus:ring-accent/50 focus:border-accent"
            />
            <input
              type="text"
              value={row.building}
              onChange={(e) => updateRow(i, { building: e.target.value })}
              placeholder="Building (optional second line)"
              className="flex-1 px-3 py-1.5 border border-gray-300 rounded-lg text-sm bg-white focus:outline-none focus:ring-2 focus:ring-accent/50 focus:border-accent"
            />
          </div>

          <label className="flex items-center gap-2 pl-6 text-xs font-medium text-gray-600">
            <input
              type="checkbox"
              checked={row.highlight}
              onChange={(e) => updateRow(i, { highlight: e.target.checked })}
              className="h-3.5 w-3.5 rounded border-gray-300 text-primary focus:ring-accent/50"
            />
            Highlight — this department&rsquo;s own office
          </label>
        </div>
      ))}

      <button
        type="button" onClick={addRow}
        className="inline-flex items-center gap-1.5 text-xs font-medium text-accent hover:text-accent/80 transition-colors"
      >
        <Plus size={14} /> Add office
      </button>

      <input type="hidden" name={name} value={JSON.stringify(cleaned)} />
    </div>
  );
}
