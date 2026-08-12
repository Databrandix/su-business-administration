'use server';

import { revalidatePath } from 'next/cache';
import { prisma } from '@/lib/db';
import { getSession } from '@/lib/auth-server';
import { careerProspectsUpdateSchema } from '@/lib/validation';

export type ActionResult = { ok: true } | { ok: false; error: string };

function getStr(fd: FormData, key: string): string {
  const v = fd.get(key);
  return typeof v === 'string' ? v.trim() : '';
}

// CareerRowsEditor serializes the whole table as ONE JSON-encoded hidden
// input. Defensive parse — returns [] on malformed.
function parseJsonArray(fd: FormData, key: string): unknown {
  const raw = fd.get(key);
  if (typeof raw !== 'string' || !raw.trim()) return [];
  try {
    return JSON.parse(raw);
  } catch {
    return [];
  }
}

export async function updateCareerProspectsAction(
  _prev: ActionResult | { ok: null },
  formData: FormData,
): Promise<ActionResult> {
  const session = await getSession();
  if (!session?.user) return { ok: false, error: 'Not authenticated' };

  // Intro copy is one textarea, one paragraph per non-empty line.
  const intro = getStr(formData, 'intro')
    .split('\n')
    .map((p) => p.trim())
    .filter((p) => p.length > 0);

  const raw = {
    heading:      getStr(formData, 'heading'),
    intro,
    rows:         parseJsonArray(formData, 'rows'),
    areaLabel:    getStr(formData, 'areaLabel'),
    rolesLabel:   getStr(formData, 'rolesLabel'),
    sectorsLabel: getStr(formData, 'sectorsLabel'),
  };

  const parsed = careerProspectsUpdateSchema.safeParse(raw);
  if (!parsed.success) {
    return {
      ok: false,
      error: parsed.error.issues
        .map((i) => `${i.path.join('.') || '(root)'}: ${i.message}`)
        .join('; '),
    };
  }

  try {
    await prisma.careerProspects.upsert({
      where: { id: 'singleton' },
      create: { id: 'singleton', ...parsed.data },
      update: parsed.data,
    });
  } catch (e) {
    return { ok: false, error: e instanceof Error ? e.message : 'Database error' };
  }

  revalidatePath('/admin/career-prospects');
  revalidatePath('/admin');
  // Every program detail page embeds this section.
  revalidatePath('/programs', 'layout');
  return { ok: true };
}
