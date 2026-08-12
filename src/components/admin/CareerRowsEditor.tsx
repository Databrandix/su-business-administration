'use client';

import { useState } from 'react';
import { Plus, X, ArrowUp, ArrowDown } from 'lucide-react';

// { area, roles, sectors }[] editor for the Career Prospects table on
// /programs/<slug>. Roles and sectors are comma-separated lists that run
// long, so each row is a stacked block with textareas rather than a
// single line of inputs.

type Row = { area: string; roles: string; sectors: string };

type Props = {
  name: string;
  initialValue: unknown;
};

function normalize(v: unknown): Row[] {
  if (!Array.isArray(v)) return [];
  return v
    .filter((r): r is Record<string, unknown> =>
      typeof r === 'object' && r !== null,
    )
    .map((r) => ({
      area:    typeof r.area === 'string' ? r.area : '',
      roles:   typeof r.roles === 'string' ? r.roles : '',
      sectors: typeof r.sectors === 'string' ? r.sectors : '',
    }));
}

export default function CareerRowsEditor({ name, initialValue }: Props) {
  const [rows, setRows] = useState<Row[]>(normalize(initialValue));

  function addRow() {
    setRows([...rows, { area: '', roles: '', sectors: '' }]);
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

  // All three columns are required — a partial row would render as a
  // table row with empty cells.
  const cleaned = rows.filter(
    (r) => r.area.trim() && r.roles.trim() && r.sectors.trim(),
  );

  return (
    <div className="space-y-3">
      {rows.length === 0 && (
        <p className="text-xs text-gray-500 italic">
          No rows yet — the table is hidden on the program pages until one is added.
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
              value={row.area}
              onChange={(e) => updateRow(i, { area: e.target.value })}
              placeholder="Functional area — e.g. Finance & Banking"
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
                aria-label="Remove row"
                className="p-1.5 text-gray-400 hover:text-red-600 transition-colors"
              >
                <X size={16} />
              </button>
            </div>
          </div>

          <div className="grid gap-2 pl-6 sm:grid-cols-2">
            <div>
              <label className="mb-1 block text-[11px] font-medium text-gray-500">
                Primary career roles
              </label>
              <textarea
                value={row.roles}
                onChange={(e) => updateRow(i, { roles: e.target.value })}
                rows={3}
                placeholder="Management Trainee Officer (MTO), Financial Analyst, …"
                className="w-full px-3 py-1.5 border border-gray-300 rounded-lg text-sm bg-white resize-y focus:outline-none focus:ring-2 focus:ring-accent/50 focus:border-accent"
              />
            </div>
            <div>
              <label className="mb-1 block text-[11px] font-medium text-gray-500">
                Leading target sectors
              </label>
              <textarea
                value={row.sectors}
                onChange={(e) => updateRow(i, { sectors: e.target.value })}
                rows={3}
                placeholder="Commercial Banks, NBFIs, Fintech firms, …"
                className="w-full px-3 py-1.5 border border-gray-300 rounded-lg text-sm bg-white resize-y focus:outline-none focus:ring-2 focus:ring-accent/50 focus:border-accent"
              />
            </div>
          </div>
        </div>
      ))}

      <button
        type="button" onClick={addRow}
        className="inline-flex items-center gap-1.5 text-xs font-medium text-accent hover:text-accent/80 transition-colors"
      >
        <Plus size={14} /> Add functional area
      </button>

      <input type="hidden" name={name} value={JSON.stringify(cleaned)} />
    </div>
  );
}
