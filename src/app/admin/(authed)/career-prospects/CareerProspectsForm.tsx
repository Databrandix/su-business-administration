'use client';

import { useActionState, useEffect } from 'react';
import { toast } from 'sonner';
import type { CareerProspects } from '@prisma/client';
import CareerRowsEditor from '@/components/admin/CareerRowsEditor';
import {
  updateCareerProspectsAction,
  type ActionResult,
} from '@/lib/admin-actions/career-prospects';

type State = ActionResult | { ok: null };

export default function CareerProspectsForm({
  initial,
}: {
  initial: CareerProspects | null;
}) {
  const [state, formAction, pending] = useActionState<State, FormData>(
    updateCareerProspectsAction,
    { ok: null },
  );

  useEffect(() => {
    if (state.ok === true) toast.success('Career Prospects saved');
    if (state.ok === false) toast.error(state.error);
  }, [state]);

  const intro = Array.isArray(initial?.intro)
    ? (initial.intro as unknown[])
        .filter((p): p is string => typeof p === 'string')
        .join('\n')
    : '';

  return (
    <form action={formAction} className="space-y-6">
      <Card title="Section">
        <TextField label="Heading" name="heading" required
                   defaultValue={initial?.heading ?? 'Career Prospects'} />
        <TextAreaField
          label="Intro paragraphs — one per line"
          name="intro"
          rows={5}
          defaultValue={intro}
          placeholder="Leave empty to show only the table."
        />
      </Card>

      <Card title="Table">
        <div className="grid gap-4 sm:grid-cols-3">
          <TextField label="Column 1 header" name="areaLabel" required
                     defaultValue={initial?.areaLabel ?? 'Functional Areas'} />
          <TextField label="Column 2 header" name="rolesLabel" required
                     defaultValue={initial?.rolesLabel ?? 'Primary Career Roles'} />
          <TextField label="Column 3 header" name="sectorsLabel" required
                     defaultValue={initial?.sectorsLabel ?? 'Leading Target Sectors'} />
        </div>

        <div>
          <p className="mb-1 text-sm font-medium text-gray-700">Functional areas</p>
          <p className="mb-2 text-xs text-gray-500">
            Rows appear in this order — use the arrows to reorder. This
            section shows on every program detail page.
          </p>
          <CareerRowsEditor name="rows" initialValue={initial?.rows} />
        </div>
      </Card>

      {state.ok === false && (
        <div role="alert"
             className="text-sm text-red-700 bg-red-50 border border-red-200 rounded-lg px-3 py-2">
          {state.error}
        </div>
      )}

      <div className="flex justify-end">
        <button type="submit" disabled={pending}
                className="bg-primary hover:bg-primary/90 text-white font-medium rounded-lg px-5 py-2.5 transition-colors disabled:opacity-60 disabled:cursor-not-allowed focus:outline-none focus:ring-2 focus:ring-accent/40">
          {pending ? 'Saving…' : 'Save changes'}
        </button>
      </div>
    </form>
  );
}

function Card({ title, children }: { title: string; children: React.ReactNode }) {
  return (
    <section className="bg-white border border-gray-200 rounded-lg p-6 space-y-4">
      <h2 className="text-sm font-semibold uppercase tracking-wider text-gray-500">{title}</h2>
      {children}
    </section>
  );
}

function TextField({
  label, name, defaultValue, required, placeholder,
}: { label: string; name: string; defaultValue?: string; required?: boolean; placeholder?: string }) {
  return (
    <div>
      <label htmlFor={name} className="block text-sm font-medium text-gray-700 mb-1">
        {label}{required && <span className="text-red-500 ml-0.5" aria-hidden="true">*</span>}
      </label>
      <input id={name} name={name} type="text"
             defaultValue={defaultValue} required={required} placeholder={placeholder}
             className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-accent/50 focus:border-accent" />
    </div>
  );
}

function TextAreaField({
  label, name, defaultValue, required, rows = 4, placeholder,
}: { label: string; name: string; defaultValue?: string; required?: boolean; rows?: number; placeholder?: string }) {
  return (
    <div>
      <label htmlFor={name} className="block text-sm font-medium text-gray-700 mb-1">
        {label}{required && <span className="text-red-500 ml-0.5" aria-hidden="true">*</span>}
      </label>
      <textarea id={name} name={name}
                defaultValue={defaultValue} required={required} rows={rows} placeholder={placeholder}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-accent/50 focus:border-accent resize-y" />
    </div>
  );
}
