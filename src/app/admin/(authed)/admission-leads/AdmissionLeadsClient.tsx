'use client';

import { useActionState, useEffect, useState, useTransition } from 'react';
import { toast } from 'sonner';
import { Trash2 } from 'lucide-react';
import type { AdmissionLead, AdmissionLeadPopup } from '@prisma/client';
import {
  updateAdmissionLeadPopupAction,
  updateAdmissionLeadStatusAction,
  deleteAdmissionLeadAction,
  type ActionResult,
} from '@/lib/admin-actions/admission-leads';

type State = ActionResult | { ok: null };

const STATUSES = ['new', 'contacted', 'enrolled', 'closed'] as const;

const STATUS_STYLE: Record<string, string> = {
  new:       'bg-accent/10 text-accent',
  contacted: 'bg-amber-100 text-amber-700',
  enrolled:  'bg-green-100 text-green-700',
  closed:    'bg-gray-100 text-gray-500',
};

export default function AdmissionLeadsClient({
  leads,
  settings,
}: {
  leads: AdmissionLead[];
  settings: AdmissionLeadPopup | null;
}) {
  const [tab, setTab] = useState<'leads' | 'settings'>('leads');

  return (
    <div className="space-y-6">
      <div className="flex gap-2">
        <TabButton active={tab === 'leads'} onClick={() => setTab('leads')}>
          Leads ({leads.length})
        </TabButton>
        <TabButton active={tab === 'settings'} onClick={() => setTab('settings')}>
          Popup settings
        </TabButton>
      </div>

      {tab === 'leads' ? (
        <LeadsTable leads={leads} />
      ) : (
        <SettingsForm settings={settings} />
      )}
    </div>
  );
}

function TabButton({
  active,
  onClick,
  children,
}: {
  active: boolean;
  onClick: () => void;
  children: React.ReactNode;
}) {
  return (
    <button
      type="button"
      onClick={onClick}
      className={`rounded-lg px-4 py-2 text-sm font-semibold transition-colors ${
        active
          ? 'bg-primary text-white'
          : 'border border-gray-200 bg-white text-gray-700 hover:border-accent hover:text-accent'
      }`}
    >
      {children}
    </button>
  );
}

function LeadsTable({ leads }: { leads: AdmissionLead[] }) {
  const [, startTransition] = useTransition();

  if (leads.length === 0) {
    return (
      <p className="rounded-lg border border-dashed border-gray-300 bg-white p-10 text-center text-sm text-gray-500">
        No leads yet. They appear here as visitors submit the homepage popup.
      </p>
    );
  }

  return (
    <div className="overflow-x-auto rounded-lg border border-gray-200 bg-white">
      <table className="w-full min-w-[820px] text-left text-sm">
        <thead>
          <tr className="border-b border-gray-200 bg-gray-50 text-[11px] font-semibold uppercase tracking-wider text-gray-500">
            <th className="px-4 py-3">Name</th>
            <th className="px-4 py-3">Phone</th>
            <th className="px-4 py-3">Programme</th>
            <th className="px-4 py-3">Received</th>
            <th className="px-4 py-3">Status</th>
            <th className="px-4 py-3" />
          </tr>
        </thead>
        <tbody>
          {leads.map((l) => (
            <tr key={l.id} className="border-b border-gray-100 last:border-b-0">
              <td className="px-4 py-3 font-medium text-gray-900">{l.fullName}</td>
              <td className="px-4 py-3">
                <a
                  href={`tel:${l.phone}`}
                  className="font-mono text-[13px] text-primary hover:underline"
                >
                  {l.phone}
                </a>
              </td>
              <td className="px-4 py-3 text-gray-700">{l.programme}</td>
              <td className="px-4 py-3 whitespace-nowrap text-gray-500">
                {new Date(l.submittedAt).toLocaleDateString('en-GB', {
                  day: '2-digit',
                  month: 'short',
                  year: 'numeric',
                })}
              </td>
              <td className="px-4 py-3">
                <select
                  value={l.status}
                  onChange={(e) => {
                    const next = e.target.value;
                    startTransition(async () => {
                      const r = await updateAdmissionLeadStatusAction(l.id, next);
                      if (r.ok) toast.success('Status updated');
                      else toast.error(r.error);
                    });
                  }}
                  className={`rounded-full px-3 py-1 text-[11px] font-bold uppercase tracking-wider ${
                    STATUS_STYLE[l.status] ?? 'bg-gray-100 text-gray-500'
                  }`}
                >
                  {STATUSES.map((s) => (
                    <option key={s} value={s}>
                      {s}
                    </option>
                  ))}
                </select>
              </td>
              <td className="px-4 py-3 text-right">
                <button
                  type="button"
                  aria-label={`Delete lead from ${l.fullName}`}
                  onClick={() => {
                    if (!confirm(`Delete the lead from ${l.fullName}?`)) return;
                    startTransition(async () => {
                      const r = await deleteAdmissionLeadAction(l.id);
                      if (r.ok) toast.success('Lead deleted');
                      else toast.error(r.error);
                    });
                  }}
                  className="p-1.5 text-gray-400 transition-colors hover:text-red-600"
                >
                  <Trash2 size={16} />
                </button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

function SettingsForm({ settings }: { settings: AdmissionLeadPopup | null }) {
  const [state, formAction, pending] = useActionState<State, FormData>(
    updateAdmissionLeadPopupAction,
    { ok: null },
  );

  useEffect(() => {
    if (state.ok === true) toast.success('Popup settings saved');
    if (state.ok === false) toast.error(state.error);
  }, [state]);

  return (
    <form action={formAction} className="space-y-6">
      <Card title="Behaviour">
        <label className="flex items-center gap-3">
          <input
            type="checkbox"
            name="isEnabled"
            defaultChecked={settings?.isEnabled ?? true}
            className="size-4 rounded border-gray-300 text-primary focus:ring-accent/40"
          />
          <span className="text-sm font-medium text-gray-700">
            Show the popup on the homepage
          </span>
        </label>

        <div className="grid gap-4 sm:grid-cols-2">
          <NumberField
            label="Delay before it opens (seconds)"
            name="delaySeconds"
            defaultValue={settings?.delaySeconds ?? 15}
            min={0}
            max={600}
            hint="Time the visitor must stay on the homepage first."
          />
          <NumberField
            label="Do not show again for (days)"
            name="cooldownDays"
            defaultValue={settings?.cooldownDays ?? 7}
            min={0}
            max={365}
            hint="After it is closed or submitted. 0 shows it every visit."
          />
        </div>
      </Card>

      <Card title="Copy">
        <TextField label="Heading" name="heading" required
                   defaultValue={settings?.heading ?? ''} />
        <TextAreaField label="Sub-heading" name="subheading" rows={2}
                       defaultValue={settings?.subheading ?? ''} />
        <TextField label="Button text" name="submitLabel" required
                   defaultValue={settings?.submitLabel ?? ''} />
        <TextField label="Footnote under the button" name="footnote"
                   defaultValue={settings?.footnote ?? ''} />
        <TextAreaField label="Message shown after submitting" name="successMessage"
                       rows={2} required
                       defaultValue={settings?.successMessage ?? ''} />
      </Card>

      <Card title="Field labels">
        <div className="grid gap-4 sm:grid-cols-2">
          <TextField label="Name label" name="nameLabel" required
                     defaultValue={settings?.nameLabel ?? ''} />
          <TextField label="Name placeholder" name="namePlaceholder"
                     defaultValue={settings?.namePlaceholder ?? ''} />
          <TextField label="Phone label" name="phoneLabel" required
                     defaultValue={settings?.phoneLabel ?? ''} />
          <TextField label="Phone placeholder" name="phonePlaceholder"
                     defaultValue={settings?.phonePlaceholder ?? ''} />
          <TextField label="Programme label" name="programmeLabel" required
                     defaultValue={settings?.programmeLabel ?? ''} />
          <TextField label="Programme placeholder" name="programmePlaceholder"
                     defaultValue={settings?.programmePlaceholder ?? ''} />
        </div>
        <p className="text-xs text-gray-500">
          The programme dropdown lists whatever is published under Programs —
          it updates itself when a degree is added or removed.
        </p>
      </Card>

      {state.ok === false && (
        <div role="alert"
             className="rounded-lg border border-red-200 bg-red-50 px-3 py-2 text-sm text-red-700">
          {state.error}
        </div>
      )}

      <div className="flex justify-end">
        <button type="submit" disabled={pending}
                className="rounded-lg bg-primary px-5 py-2.5 font-medium text-white transition-colors hover:bg-primary/90 disabled:cursor-not-allowed disabled:opacity-60">
          {pending ? 'Saving…' : 'Save settings'}
        </button>
      </div>
    </form>
  );
}

function Card({ title, children }: { title: string; children: React.ReactNode }) {
  return (
    <section className="space-y-4 rounded-lg border border-gray-200 bg-white p-6">
      <h2 className="text-sm font-semibold uppercase tracking-wider text-gray-500">
        {title}
      </h2>
      {children}
    </section>
  );
}

function TextField({
  label, name, defaultValue, required,
}: { label: string; name: string; defaultValue?: string; required?: boolean }) {
  return (
    <div>
      <label htmlFor={name} className="mb-1 block text-sm font-medium text-gray-700">
        {label}{required && <span className="ml-0.5 text-red-500" aria-hidden="true">*</span>}
      </label>
      <input id={name} name={name} type="text" required={required} defaultValue={defaultValue}
             className="w-full rounded-lg border border-gray-300 px-3 py-2 text-sm focus:border-accent focus:outline-none focus:ring-2 focus:ring-accent/50" />
    </div>
  );
}

function TextAreaField({
  label, name, defaultValue, rows = 3, required,
}: { label: string; name: string; defaultValue?: string; rows?: number; required?: boolean }) {
  return (
    <div>
      <label htmlFor={name} className="mb-1 block text-sm font-medium text-gray-700">
        {label}{required && <span className="ml-0.5 text-red-500" aria-hidden="true">*</span>}
      </label>
      <textarea id={name} name={name} rows={rows} required={required} defaultValue={defaultValue}
                className="w-full resize-y rounded-lg border border-gray-300 px-3 py-2 text-sm focus:border-accent focus:outline-none focus:ring-2 focus:ring-accent/50" />
    </div>
  );
}

function NumberField({
  label, name, defaultValue, min, max, hint,
}: { label: string; name: string; defaultValue: number; min: number; max: number; hint?: string }) {
  return (
    <div>
      <label htmlFor={name} className="mb-1 block text-sm font-medium text-gray-700">
        {label}
      </label>
      <input id={name} name={name} type="number" min={min} max={max} defaultValue={defaultValue}
             className="w-full rounded-lg border border-gray-300 px-3 py-2 text-sm focus:border-accent focus:outline-none focus:ring-2 focus:ring-accent/50" />
      {hint && <p className="mt-1 text-xs text-gray-500">{hint}</p>}
    </div>
  );
}
