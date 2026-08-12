'use server';

import { revalidatePath } from 'next/cache';
import { prisma } from '@/lib/db';
import { getSession } from '@/lib/auth-server';
import {
  serviceCharterItemCreateSchema,
  serviceCharterItemUpdateSchema,
  serviceCharterMetaUpdateSchema,
} from '@/lib/validation';

export type ActionResult = { ok: true } | { ok: false; error: string };

const PUBLIC_PATH = '/student-society/service-charter';

function getStr(fd: FormData, key: string): string {
  const v = fd.get(key);
  return typeof v === 'string' ? v.trim() : '';
}

function emptyToNull(v: FormDataEntryValue | null): string | null {
  if (typeof v !== 'string') return null;
  const t = v.trim();
  return t.length > 0 ? t : null;
}

async function requireAuth(): Promise<ActionResult | null> {
  const session = await getSession();
  if (!session?.user) return { ok: false, error: 'Not authenticated' };
  return null;
}

function fail(
  issues: readonly { path: readonly PropertyKey[]; message: string }[],
): ActionResult {
  return {
    ok: false,
    error: issues
      .map((i) => `${i.path.map(String).join('.') || '(root)'}: ${i.message}`)
      .join('; '),
  };
}

function revalidate() {
  revalidatePath('/admin/service-charter');
  revalidatePath('/admin');
  revalidatePath(PUBLIC_PATH);
}

// Steps are one textarea, one step per non-empty line.
function readItem(fd: FormData) {
  return {
    title: getStr(fd, 'title'),
    steps: getStr(fd, 'steps')
      .split(/\r?\n/)
      .map((s) => s.trim())
      .filter(Boolean),
    personName:  emptyToNull(fd.get('personName')),
    personPhone: emptyToNull(fd.get('personPhone')),
    personEmail: emptyToNull(fd.get('personEmail')),
    personRoom:  emptyToNull(fd.get('personRoom')),
    personNote:  emptyToNull(fd.get('personNote')),
  };
}

export async function createServiceCharterItemAction(
  _prev: ActionResult | { ok: null },
  formData: FormData,
): Promise<ActionResult> {
  const denied = await requireAuth();
  if (denied) return denied;

  const parsed = serviceCharterItemCreateSchema.safeParse(readItem(formData));
  if (!parsed.success) return fail(parsed.error.issues);

  const last = await prisma.serviceCharterItem.findFirst({
    orderBy: { displayOrder: 'desc' },
    select: { displayOrder: true },
  });

  try {
    await prisma.serviceCharterItem.create({
      data: { ...parsed.data, displayOrder: (last?.displayOrder ?? -1) + 1 },
    });
  } catch (e) {
    return { ok: false, error: e instanceof Error ? e.message : 'Database error' };
  }

  revalidate();
  return { ok: true };
}

export async function updateServiceCharterItemAction(
  id: string,
  _prev: ActionResult | { ok: null },
  formData: FormData,
): Promise<ActionResult> {
  const denied = await requireAuth();
  if (denied) return denied;

  const parsed = serviceCharterItemUpdateSchema.safeParse(readItem(formData));
  if (!parsed.success) return fail(parsed.error.issues);

  try {
    await prisma.serviceCharterItem.update({ where: { id }, data: parsed.data });
  } catch (e) {
    const code = (e as { code?: string })?.code;
    if (code === 'P2025') return { ok: false, error: 'Service not found' };
    return { ok: false, error: e instanceof Error ? e.message : 'Database error' };
  }

  revalidate();
  return { ok: true };
}

export async function deleteServiceCharterItemAction(id: string): Promise<ActionResult> {
  const denied = await requireAuth();
  if (denied) return denied;

  try {
    await prisma.serviceCharterItem.delete({ where: { id } });
  } catch (e) {
    const code = (e as { code?: string })?.code;
    if (code === 'P2025') return { ok: false, error: 'Service not found' };
    return { ok: false, error: e instanceof Error ? e.message : 'Database error' };
  }

  revalidate();
  return { ok: true };
}

export async function reorderServiceCharterAction(ids: string[]): Promise<ActionResult> {
  const denied = await requireAuth();
  if (denied) return denied;

  try {
    await prisma.$transaction(
      ids.map((id, i) =>
        prisma.serviceCharterItem.update({ where: { id }, data: { displayOrder: i } }),
      ),
    );
  } catch (e) {
    return { ok: false, error: e instanceof Error ? e.message : 'Database error' };
  }

  revalidate();
  return { ok: true };
}

export async function updateServiceCharterMetaAction(
  _prev: ActionResult | { ok: null },
  formData: FormData,
): Promise<ActionResult> {
  const denied = await requireAuth();
  if (denied) return denied;

  const parsed = serviceCharterMetaUpdateSchema.safeParse({
    intro:       getStr(formData, 'intro'),
    pdfUrl:      emptyToNull(formData.get('pdfUrl')),
    pdfPublicId: emptyToNull(formData.get('pdfPublicId')),
    pdfFileName: emptyToNull(formData.get('pdfFileName')),
  });
  if (!parsed.success) return fail(parsed.error.issues);

  try {
    await prisma.serviceCharterMeta.upsert({
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
