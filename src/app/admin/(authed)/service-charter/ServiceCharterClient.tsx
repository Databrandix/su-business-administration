'use client';

import { useActionState, useEffect, useState, useTransition } from 'react';
import { toast } from 'sonner';
import { Plus, X, ArrowUp, ArrowDown, Pencil } from 'lucide-react';
import type { ServiceCharterItem, ServiceCharterMeta } from '@prisma/client';
import ImageUploader from '@/components/admin/ImageUploader';
import {
  createServiceCharterItemAction,
  updateServiceCharterItemAction,
  deleteServiceCharterItemAction,
  reorderServiceCharterAction,
  updateServiceCharterMetaAction,
  type ActionResult,
} from '@/lib/admin-actions/service-charter';

type State = ActionResult | { ok: null };

function stepsToText(v: unknown): string {
  if (!Array.isArray(v)) return '';
  return v.filter((s): s is string => typeof s === 'string').join('\n');
}

export default function ServiceCharterClient({
  items,
  meta,
}: {
  items: ServiceCharterItem[];
  meta: ServiceCharterMeta | null;
}) {
  const [editingId, setEditingId] = useState<string | null>(null);
  const [creating, setCreating] = useState(false);
  const [, startTransition] = useTransition();

  return (
    <div className="space-y-8">
      <MetaForm meta={meta} />

      <section className="space-y-3">
        <div className="flex items-center justify-between">
          <h2 className="text-sm font-semibold uppercase tracking-wider text-gray-500">
            Services ({items.length})
          </h2>
          <button
            type="button"
            onClick={() => { setCreating(true); setEditingId(null); }}
            className="inline-flex items-center gap-1.5 rounded-lg bg-primary px-3.5 py-2 text-sm font-medium text-white transition-colors hover:bg-primary/90"
          >
            <Plus size={15} /> Add service
          </button>
        </div>

        {creating && (
          <ItemForm
            onDone={() => setCreating(false)}
            heading="New service"
          />
        )}

        {items.map((item, i) => (
          <div key={item.id} className="rounded-lg border border-gray-200 bg-white">
            {editingId === item.id ? (
              <div className="p-4">
                <ItemForm
                  item={item}
                  heading={`Edit service ${i + 1}`}
                  onDone={() => setEditingId(null)}
                />
              </div>
            ) : (
              <div className="flex items-start gap-3 p-4">
                <span className="mt-0.5 inline-flex size-7 shrink-0 items-center justify-center rounded-full bg-primary/10 text-[12px] font-bold text-primary">
                  {i + 1}
                </span>
                <div className="min-w-0 flex-1">
                  <p className="text-sm font-semibold text-gray-900">{item.title}</p>
                  <p className="mt-1 text-xs text-gray-500">
                    {(Array.isArray(item.steps) ? item.steps.length : 0)} step(s)
                    {item.personName ? ` · ${item.personName}` : ''}
                  </p>
                </div>
                <div className="flex shrink-0 items-center gap-0.5">
                  <button
                    type="button" aria-label="Move up" disabled={i === 0}
                    onClick={() => {
                      const next = [...items];
                      [next[i - 1], next[i]] = [next[i], next[i - 1]];
                      startTransition(async () => {
                        const r = await reorderServiceCharterAction(next.map((x) => x.id));
                        if (!r.ok) toast.error(r.error);
                      });
                    }}
                    className="p-1 text-gray-400 transition-colors hover:text-primary disabled:opacity-30"
                  >
                    <ArrowUp size={15} />
                  </button>
                  <button
                    type="button" aria-label="Move down" disabled={i === items.length - 1}
                    onClick={() => {
                      const next = [...items];
                      [next[i], next[i + 1]] = [next[i + 1], next[i]];
                      startTransition(async () => {
                        const r = await reorderServiceCharterAction(next.map((x) => x.id));
                        if (!r.ok) toast.error(r.error);
                      });
                    }}
                    className="p-1 text-gray-400 transition-colors hover:text-primary disabled:opacity-30"
                  >
                    <ArrowDown size={15} />
                  </button>
                  <button
                    type="button" aria-label="Edit"
                    onClick={() => { setEditingId(item.id); setCreating(false); }}
                    className="p-1.5 text-gray-400 transition-colors hover:text-primary"
                  >
                    <Pencil size={15} />
                  </button>
                  <button
                    type="button" aria-label="Delete"
                    onClick={() => {
                      if (!confirm(`Delete "${item.title}"?`)) return;
                      startTransition(async () => {
                        const r = await deleteServiceCharterItemAction(item.id);
                        if (r.ok) toast.success('Service deleted');
                        else toast.error(r.error);
                      });
                    }}
                    className="p-1.5 text-gray-400 transition-colors hover:text-red-600"
                  >
                    <X size={16} />
                  </button>
                </div>
              </div>
            )}
          </div>
        ))}

        {items.length === 0 && !creating && (
          <p className="rounded-lg border border-dashed border-gray-300 bg-white p-8 text-center text-sm text-gray-500">
            No services yet.
          </p>
        )}
      </section>
    </div>
  );
}

function MetaForm({ meta }: { meta: ServiceCharterMeta | null }) {
  const [state, formAction, pending] = useActionState<State, FormData>(
    updateServiceCharterMetaAction,
    { ok: null },
  );

  const [pdf, setPdf] = useState({
    url:      meta?.pdfUrl ?? '',
    publicId: meta?.pdfPublicId ?? '',
    fileName: meta?.pdfFileName ?? '',
  });

  useEffect(() => {
    if (state.ok === true) toast.success('Page settings saved');
    if (state.ok === false) toast.error(state.error);
  }, [state]);

  return (
    <form action={formAction} className="space-y-4 rounded-lg border border-gray-200 bg-white p-6">
      <h2 className="text-sm font-semibold uppercase tracking-wider text-gray-500">
        Page intro & PDF
      </h2>

      <div>
        <label htmlFor="intro" className="mb-1 block text-sm font-medium text-gray-700">
          Intro paragraph<span className="ml-0.5 text-red-500" aria-hidden="true">*</span>
        </label>
        <textarea
          id="intro" name="intro" rows={3} required
          defaultValue={meta?.intro ?? ''}
          className="w-full resize-y rounded-lg border border-gray-300 px-3 py-2 text-sm focus:border-accent focus:outline-none focus:ring-2 focus:ring-accent/50"
        />
      </div>

      <div>
        <p className="mb-1 text-sm font-medium text-gray-700">Service charter PDF (optional)</p>
        <p className="mb-2 text-xs text-gray-500">
          The download card at the bottom of the page appears once this is uploaded.
        </p>
        <ImageUploader
          kind="service-charter-pdf"
          name="serviceCharterPdf"
          accept="application/pdf"
          initialUrl={pdf.url}
          initialPublicId={pdf.publicId}
          initialFileType="pdf"
          initialFileName={pdf.fileName}
          onChange={(url, publicId, m) => setPdf({ url, publicId, fileName: m?.fileName ?? '' })}
        />
        <input type="hidden" name="pdfUrl" value={pdf.url} />
        <input type="hidden" name="pdfPublicId" value={pdf.publicId} />
        <input type="hidden" name="pdfFileName" value={pdf.fileName} />
      </div>

      <div className="flex justify-end">
        <button type="submit" disabled={pending}
                className="rounded-lg bg-primary px-5 py-2.5 font-medium text-white transition-colors hover:bg-primary/90 disabled:cursor-not-allowed disabled:opacity-60">
          {pending ? 'Saving…' : 'Save settings'}
        </button>
      </div>
    </form>
  );
}

function ItemForm({
  item,
  heading,
  onDone,
}: {
  item?: ServiceCharterItem;
  heading: string;
  onDone: () => void;
}) {
  const action = item
    ? updateServiceCharterItemAction.bind(null, item.id)
    : createServiceCharterItemAction;

  const [state, formAction, pending] = useActionState<State, FormData>(action, { ok: null });

  useEffect(() => {
    if (state.ok === true) { toast.success(item ? 'Service saved' : 'Service added'); onDone(); }
    if (state.ok === false) toast.error(state.error);
  }, [state, item, onDone]);

  return (
    <form action={formAction} className="space-y-3 rounded-lg border border-gray-200 bg-gray-50/60 p-4">
      <p className="text-xs font-semibold uppercase tracking-wider text-gray-500">{heading}</p>

      <Field label="Title" name="title" required defaultValue={item?.title ?? ''} />

      <div>
        <label className="mb-1 block text-sm font-medium text-gray-700">
          Steps — one per line
        </label>
        <p className="mb-1 text-xs text-gray-500">
          A single line renders with an arrow; two or more render as a numbered
          list. URLs and email addresses become links automatically.
        </p>
        <textarea
          name="steps" rows={4}
          defaultValue={stepsToText(item?.steps)}
          className="w-full resize-y rounded-lg border border-gray-300 px-3 py-2 text-sm focus:border-accent focus:outline-none focus:ring-2 focus:ring-accent/50"
        />
      </div>

      <div className="grid gap-3 sm:grid-cols-2">
        <Field label="Person name" name="personName" defaultValue={item?.personName ?? ''} />
        <Field label="Phone" name="personPhone" defaultValue={item?.personPhone ?? ''} />
        <Field label="Email" name="personEmail" defaultValue={item?.personEmail ?? ''} />
        <Field label="Room" name="personRoom" defaultValue={item?.personRoom ?? ''} />
      </div>
      <Field label="Extra note after email (optional)" name="personNote"
             defaultValue={item?.personNote ?? ''} placeholder="Student Welfare Division" />

      <div className="flex justify-end gap-2">
        <button type="button" onClick={onDone}
                className="px-4 py-2 text-sm font-medium text-gray-600 transition-colors hover:text-gray-900">
          Cancel
        </button>
        <button type="submit" disabled={pending}
                className="rounded-lg bg-primary px-4 py-2 text-sm font-medium text-white transition-colors hover:bg-primary/90 disabled:opacity-60">
          {pending ? 'Saving…' : item ? 'Save' : 'Add service'}
        </button>
      </div>
    </form>
  );
}

function Field({
  label, name, defaultValue, required, placeholder,
}: { label: string; name: string; defaultValue?: string; required?: boolean; placeholder?: string }) {
  return (
    <div>
      <label htmlFor={name} className="mb-1 block text-sm font-medium text-gray-700">
        {label}{required && <span className="ml-0.5 text-red-500" aria-hidden="true">*</span>}
      </label>
      <input
        id={name} name={name} type="text" required={required}
        defaultValue={defaultValue} placeholder={placeholder}
        className="w-full rounded-lg border border-gray-300 px-3 py-2 text-sm focus:border-accent focus:outline-none focus:ring-2 focus:ring-accent/50"
      />
    </div>
  );
}
