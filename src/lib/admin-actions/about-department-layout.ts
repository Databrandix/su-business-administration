'use server';

import { revalidatePath } from 'next/cache';
import { prisma } from '@/lib/db';
import { getSession } from '@/lib/auth-server';
import { aboutDepartmentLayoutUpdateSchema } from '@/lib/validation';

export type ActionResult = { ok: true } | { ok: false; error: string };

function getStr(fd: FormData, key: string): string {
  const v = fd.get(key);
  return typeof v === 'string' ? v.trim() : '';
}

function emptyToNull(v: FormDataEntryValue | null): string | null {
  if (typeof v !== 'string') return null;
  const t = v.trim();
  return t.length > 0 ? t : null;
}

// RoomRowsEditor serializes the whole table as ONE JSON-encoded hidden
// input.
//
// Returns undefined when the field is ABSENT — a form that never carried
// the editor (a stale tab) must leave the stored rows alone. An empty
// array is only returned when the field is genuinely present and empty,
// which is the user deleting every row on purpose. Conflating the two
// once wiped the whole office directory on an unrelated cover upload.
function parseJsonArray(fd: FormData, key: string): unknown {
  const raw = fd.get(key);
  if (typeof raw !== 'string') return undefined;
  if (!raw.trim()) return [];
  try {
    const parsed = JSON.parse(raw);
    return Array.isArray(parsed) ? parsed : [];
  } catch {
    return [];
  }
}

export async function updateAboutDepartmentLayoutAction(
  _prev: ActionResult | { ok: null },
  formData: FormData,
): Promise<ActionResult> {
  const session = await getSession();
  if (!session?.user) return { ok: false, error: 'Not authenticated' };

  // Intro copy is one textarea, one paragraph per non-empty line.
  const paragraphs = getStr(formData, 'paragraphs')
    .split('\n')
    .map((p) => p.trim())
    .filter((p) => p.length > 0);

  const raw = {
    heroTitle:         getStr(formData, 'heroTitle'),
    heroOverline:      emptyToNull(formData.get('heroOverline')),
    heroImageUrl:      getStr(formData, 'heroImageUrl'),
    heroImagePublicId: emptyToNull(formData.get('heroImagePublicId')),
    heroImageVerticalPercent: formData.get('heroImageVerticalPercent') ?? undefined,
    paragraphs,
    roomRows:            parseJsonArray(formData, 'roomRows'),
    // These five have sensible fixed defaults and are edited rarely. A
    // form posted without them — a stale tab open from before the fields
    // existed, or a future partial form — should keep what is stored
    // rather than fail validation on inputs the user never saw.
    tableUniversity:     getStr(formData, 'tableUniversity')     || undefined,
    tableDepartment:     getStr(formData, 'tableDepartment')     || undefined,
    tableAddress:        getStr(formData, 'tableAddress')        || undefined,
    columnOfficeLabel:   getStr(formData, 'columnOfficeLabel')   || undefined,
    columnLocationLabel: getStr(formData, 'columnLocationLabel') || undefined,
    cardTitle:         getStr(formData, 'cardTitle'),
    coverUrl:          emptyToNull(formData.get('coverUrl')),
    coverPublicId:     emptyToNull(formData.get('coverPublicId')),
    pdfUrl:            emptyToNull(formData.get('pdfUrl')),
    pdfPublicId:       emptyToNull(formData.get('pdfPublicId')),
    pdfFileName:       emptyToNull(formData.get('pdfFileName')),
  };

  const parsed = aboutDepartmentLayoutUpdateSchema.safeParse(raw);
  if (!parsed.success) {
    return {
      ok: false,
      error: parsed.error.issues
        .map((i) => `${i.path.join('.') || '(root)'}: ${i.message}`)
        .join('; '),
    };
  }

  try {
    // roomRows is undefined when the submitted form had no rows editor.
    // Prisma skips undefined on update, so the stored directory survives;
    // a brand-new row still needs a concrete value.
    const { roomRows, ...rest } = parsed.data;
    await prisma.aboutDepartmentLayout.upsert({
      where: { id: 'singleton' },
      create: { id: 'singleton', ...rest, roomRows: roomRows ?? [] },
      update: { ...rest, ...(roomRows !== undefined && { roomRows }) },
    });
  } catch (e) {
    return { ok: false, error: e instanceof Error ? e.message : 'Database error' };
  }

  revalidatePath('/admin/about-department-layout');
  revalidatePath('/admin');
  revalidatePath('/about/department-layout');
  return { ok: true };
}
