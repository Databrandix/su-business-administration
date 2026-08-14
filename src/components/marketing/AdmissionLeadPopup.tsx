'use client';

import { useCallback, useEffect, useRef, useState } from 'react';
import { X, ArrowRight, Loader2, CheckCircle2 } from 'lucide-react';

export type AdmissionLeadPopupSettings = {
  heading: string;
  subheading: string;
  nameLabel: string;
  namePlaceholder: string;
  phoneLabel: string;
  phonePlaceholder: string;
  programmeLabel: string;
  programmePlaceholder: string;
  submitLabel: string;
  footnote: string;
  successMessage: string;
  delaySeconds: number;
  cooldownDays: number;
};

// One key for both "already submitted" and "dismissed", holding the
// timestamp the popup was last closed. localStorage rather than a cookie:
// this is a UX preference, never read on the server.
const STORAGE_KEY = 'su-admission-popup-dismissed-at';

function suppressedUntil(cooldownDays: number): boolean {
  if (typeof window === 'undefined') return true;
  try {
    const raw = window.localStorage.getItem(STORAGE_KEY);
    if (!raw) return false;
    // cooldownDays = 0 means "show on every visit", so a stored
    // timestamp never suppresses.
    if (cooldownDays <= 0) return false;
    const then = Number.parseInt(raw, 10);
    if (!Number.isFinite(then)) return false;
    return Date.now() - then < cooldownDays * 24 * 60 * 60 * 1000;
  } catch {
    // Private mode / storage disabled — fall back to showing it.
    return false;
  }
}

function remember() {
  try {
    window.localStorage.setItem(STORAGE_KEY, String(Date.now()));
  } catch {
    /* storage unavailable — the popup simply reappears next visit */
  }
}

export default function AdmissionLeadPopup({
  settings,
  programmes,
}: {
  settings: AdmissionLeadPopupSettings;
  programmes: readonly string[];
}) {
  const [open, setOpen] = useState(false);
  const [pending, setPending] = useState(false);
  const [done, setDone] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const dialogRef = useRef<HTMLDivElement>(null);
  const nameRef = useRef<HTMLInputElement>(null);

  // Open once, after the configured dwell time.
  useEffect(() => {
    if (suppressedUntil(settings.cooldownDays)) return;
    const t = setTimeout(() => setOpen(true), Math.max(0, settings.delaySeconds) * 1000);
    return () => clearTimeout(t);
  }, [settings.delaySeconds, settings.cooldownDays]);

  const close = useCallback(() => {
    setOpen(false);
    remember();
  }, []);

  // Escape to close, and lock the page behind the dialog while it is up.
  useEffect(() => {
    if (!open) return;
    const onKey = (e: KeyboardEvent) => {
      if (e.key === 'Escape') close();
    };
    document.addEventListener('keydown', onKey);
    const prevOverflow = document.body.style.overflow;
    document.body.style.overflow = 'hidden';
    nameRef.current?.focus();
    return () => {
      document.removeEventListener('keydown', onKey);
      document.body.style.overflow = prevOverflow;
    };
  }, [open, close]);

  async function onSubmit(e: React.FormEvent<HTMLFormElement>) {
    e.preventDefault();
    setError(null);
    setPending(true);

    const fd = new FormData(e.currentTarget);
    const payload = {
      fullName:  String(fd.get('fullName') ?? ''),
      phone:     String(fd.get('phone') ?? ''),
      programme: String(fd.get('programme') ?? ''),
      website:   String(fd.get('website') ?? ''),
    };

    try {
      const res = await fetch('/api/admission-lead', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(payload),
      });
      const data = await res.json().catch(() => ({}));
      if (!res.ok) {
        setError(data?.issues?.[0]?.message ?? data?.error ?? 'Something went wrong.');
        setPending(false);
        return;
      }
      setDone(true);
      remember();
      // Leave the confirmation up long enough to read.
      setTimeout(() => setOpen(false), 2600);
    } catch {
      setError('Network error. Please try again.');
    } finally {
      setPending(false);
    }
  }

  if (!open) return null;

  return (
    <div
      className="fixed inset-0 z-[100] flex items-center justify-center p-4"
      role="dialog"
      aria-modal="true"
      aria-labelledby="admission-popup-heading"
    >
      {/* Backdrop — clicking it dismisses, same as the close button. */}
      <button
        type="button"
        aria-label="Close"
        onClick={close}
        className="absolute inset-0 h-full w-full cursor-default bg-black/50 backdrop-blur-[2px]"
      />

      <div
        ref={dialogRef}
        className="relative z-10 w-full max-w-md overflow-hidden rounded-2xl bg-white shadow-2xl"
      >
        {/* Gradient hairline echoing the site's primary→accent ramp. */}
        <span className="absolute inset-x-0 top-0 h-1 bg-gradient-to-r from-primary to-accent" />

        <button
          type="button"
          onClick={close}
          aria-label="Close"
          className="absolute right-4 top-4 z-10 inline-flex size-9 items-center justify-center rounded-full bg-gray-100 text-gray-500 transition-colors hover:bg-gray-200 hover:text-gray-700"
        >
          <X size={18} />
        </button>

        {done ? (
          <div className="flex flex-col items-center gap-3 px-8 py-14 text-center">
            <CheckCircle2 size={44} className="text-accent" aria-hidden="true" />
            <p className="font-display text-lg font-bold text-primary">
              {settings.successMessage}
            </p>
          </div>
        ) : (
          <div className="p-7 md:p-8">
            <h2
              id="admission-popup-heading"
              className="pr-10 font-display text-xl font-bold leading-snug text-primary md:text-2xl"
            >
              {settings.heading}
            </h2>
            {settings.subheading && (
              <p className="mt-2 text-[14.5px] leading-relaxed text-gray-600">
                {settings.subheading}
              </p>
            )}

            <form onSubmit={onSubmit} className="mt-6 flex flex-col gap-4">
              <Field label={settings.nameLabel} htmlFor="admission-popup-name">
                <input
                  ref={nameRef}
                  id="admission-popup-name"
                  name="fullName"
                  type="text"
                  required
                  maxLength={200}
                  placeholder={settings.namePlaceholder}
                  className="w-full rounded-lg bg-gray-100 px-4 py-3 text-sm text-gray-900 transition placeholder:text-gray-400 focus:bg-white focus:outline-none focus:ring-2 focus:ring-accent/40"
                />
              </Field>

              <Field label={settings.phoneLabel} htmlFor="admission-popup-phone">
                <input
                  id="admission-popup-phone"
                  name="phone"
                  type="tel"
                  inputMode="tel"
                  required
                  maxLength={50}
                  placeholder={settings.phonePlaceholder}
                  className="w-full rounded-lg bg-gray-100 px-4 py-3 text-sm text-gray-900 transition placeholder:text-gray-400 focus:bg-white focus:outline-none focus:ring-2 focus:ring-accent/40"
                />
              </Field>

              <Field label={settings.programmeLabel} htmlFor="admission-popup-programme">
                <select
                  id="admission-popup-programme"
                  name="programme"
                  required
                  defaultValue=""
                  className="w-full appearance-none rounded-lg bg-gray-100 bg-[length:18px] bg-[right_1rem_center] bg-no-repeat px-4 py-3 text-sm text-gray-900 transition focus:bg-white focus:outline-none focus:ring-2 focus:ring-accent/40"
                  style={{
                    backgroundImage:
                      "url(\"data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%236b7280' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpath d='m6 9 6 6 6-6'/%3E%3C/svg%3E\")",
                  }}
                >
                  <option value="" disabled>
                    {settings.programmePlaceholder}
                  </option>
                  {programmes.map((p) => (
                    <option key={p} value={p}>
                      {p}
                    </option>
                  ))}
                </select>
              </Field>

              {/* Honeypot — hidden from people, irresistible to bots. */}
              <input
                type="text"
                name="website"
                tabIndex={-1}
                autoComplete="off"
                aria-hidden="true"
                className="absolute left-[-9999px] h-0 w-0 opacity-0"
              />

              {error && (
                <p role="alert" className="text-sm text-red-600">
                  {error}
                </p>
              )}

              <button
                type="submit"
                disabled={pending}
                className="mt-1 inline-flex w-full items-center justify-center gap-2 rounded-lg bg-gradient-to-r from-primary to-accent px-6 py-3.5 font-bold text-white shadow-md transition-opacity hover:opacity-95 disabled:cursor-not-allowed disabled:opacity-60"
              >
                {pending ? (
                  <>
                    <Loader2 size={18} className="animate-spin" />
                    Sending…
                  </>
                ) : (
                  <>
                    {settings.submitLabel}
                    <ArrowRight size={18} />
                  </>
                )}
              </button>

              {settings.footnote && (
                <p className="text-center text-[13px] text-gray-500">
                  {settings.footnote}
                </p>
              )}
            </form>
          </div>
        )}
      </div>
    </div>
  );
}

function Field({
  label,
  htmlFor,
  children,
}: {
  label: string;
  htmlFor: string;
  children: React.ReactNode;
}) {
  return (
    <div>
      <label
        htmlFor={htmlFor}
        className="mb-1.5 block text-[13.5px] font-semibold text-gray-800"
      >
        {label}
        <span className="ml-0.5 text-accent" aria-hidden="true">
          *
        </span>
      </label>
      {children}
    </div>
  );
}
