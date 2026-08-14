'use server';

import { revalidatePath } from 'next/cache';
import { prisma } from '@/lib/db';
import { getSession } from '@/lib/auth-server';
import {
  admissionLeadPopupUpdateSchema,
  admissionLeadStatusEnum,
} from '@/lib/validation';

export type ActionResult = { ok: true } | { ok: false; error: string };

function getStr(fd: FormData, key: string): string {
  const v = fd.get(key);
  return typeof v === 'string' ? v.trim() : '';
}

async function requireAuth(): Promise<ActionResult | null> {
  const session = await getSession();
  if (!session?.user) return { ok: false, error: 'Not authenticated' };
  return null;
}

function revalidate() {
  revalidatePath('/admin/admission-leads');
  revalidatePath('/admin');
  revalidatePath('/');
}

export async function updateAdmissionLeadPopupAction(
  _prev: ActionResult | { ok: null },
  formData: FormData,
): Promise<ActionResult> {
  const denied = await requireAuth();
  if (denied) return denied;

  const parsed = admissionLeadPopupUpdateSchema.safeParse({
    // An unchecked checkbox posts nothing at all.
    isEnabled:            formData.get('isEnabled') !== null,
    heading:              getStr(formData, 'heading'),
    subheading:           getStr(formData, 'subheading'),
    nameLabel:            getStr(formData, 'nameLabel'),
    namePlaceholder:      getStr(formData, 'namePlaceholder'),
    phoneLabel:           getStr(formData, 'phoneLabel'),
    phonePlaceholder:     getStr(formData, 'phonePlaceholder'),
    programmeLabel:       getStr(formData, 'programmeLabel'),
    programmePlaceholder: getStr(formData, 'programmePlaceholder'),
    submitLabel:          getStr(formData, 'submitLabel'),
    footnote:             getStr(formData, 'footnote'),
    successMessage:       getStr(formData, 'successMessage'),
    delaySeconds:         getStr(formData, 'delaySeconds'),
    cooldownDays:         getStr(formData, 'cooldownDays'),
  });

  if (!parsed.success) {
    return {
      ok: false,
      error: parsed.error.issues
        .map((i) => `${i.path.map(String).join('.') || '(root)'}: ${i.message}`)
        .join('; '),
    };
  }

  try {
    await prisma.admissionLeadPopup.upsert({
      where: { id: 'singleton' },
      create: { id: 'singleton', ...parsed.data },
      update: parsed.data,
    });
  } catch (e) {
    return { ok: false, error: e instanceof Error ? e.message : 'Database error' };
  }

  revalidate();
  return { ok: true };
}

export async function updateAdmissionLeadStatusAction(
  id: string,
  status: string,
): Promise<ActionResult> {
  const denied = await requireAuth();
  if (denied) return denied;

  const parsed = admissionLeadStatusEnum.safeParse(status);
  if (!parsed.success) return { ok: false, error: 'Unknown status' };

  try {
    await prisma.admissionLead.update({
      where: { id },
      data: { status: parsed.data },
    });
  } catch (e) {
    const code = (e as { code?: string })?.code;
    if (code === 'P2025') return { ok: false, error: 'Lead not found' };
    return { ok: false, error: e instanceof Error ? e.message : 'Database error' };
  }

  revalidate();
  return { ok: true };
}

export async function deleteAdmissionLeadAction(id: string): Promise<ActionResult> {
  const denied = await requireAuth();
  if (denied) return denied;

  try {
    await prisma.admissionLead.delete({ where: { id } });
  } catch (e) {
    const code = (e as { code?: string })?.code;
    if (code === 'P2025') return { ok: false, error: 'Lead not found' };
    return { ok: false, error: e instanceof Error ? e.message : 'Database error' };
  }

  revalidate();
  return { ok: true };
}
