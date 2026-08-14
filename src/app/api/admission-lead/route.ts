import { NextResponse, type NextRequest } from 'next/server';
import { prisma } from '@/lib/db';
import { admissionLeadCreateSchema } from '@/lib/validation';
import { checkRateLimit } from '@/lib/rate-limit';

// Honeypot field name — must match the hidden input in
// AdmissionLeadPopup. Real users never fill it; bots fill all inputs.
const HONEYPOT_FIELD = 'website';

function getClientIp(request: NextRequest): string | null {
  const xff = request.headers.get('x-forwarded-for');
  if (xff) {
    const first = xff.split(',')[0];
    if (first) return first.trim();
  }
  const real = request.headers.get('x-real-ip');
  if (real) return real.trim();
  return null;
}

export async function POST(request: NextRequest) {
  let body: unknown;
  try {
    body = await request.json();
  } catch {
    return NextResponse.json({ error: 'Invalid JSON' }, { status: 400 });
  }

  if (!body || typeof body !== 'object') {
    return NextResponse.json({ error: 'Invalid request' }, { status: 400 });
  }

  // Bots fill every input, so a non-empty honeypot means discard. It
  // returns ok so the bot has no signal that it was caught.
  const honeypotValue = (body as Record<string, unknown>)[HONEYPOT_FIELD];
  if (typeof honeypotValue === 'string' && honeypotValue.trim().length > 0) {
    return NextResponse.json({ ok: true });
  }

  const ip = getClientIp(request);
  const userAgent = request.headers.get('user-agent');

  // Dedicated namespace so this bucket is not shared with the contact
  // form, newsletter signup, or club application.
  const limit = checkRateLimit(`admission-lead:${ip ?? 'no-ip'}`);
  if (!limit.allowed) {
    const retryAfter = Math.max(1, Math.ceil((limit.resetMs - Date.now()) / 1000));
    return NextResponse.json(
      { error: 'Too many submissions from your IP. Please try again later.' },
      { status: 429, headers: { 'Retry-After': String(retryAfter) } },
    );
  }

  const parsed = admissionLeadCreateSchema.safeParse(body);
  if (!parsed.success) {
    return NextResponse.json(
      {
        error: 'Please double-check the form fields and try again.',
        issues: parsed.error.issues.map((i) => ({
          path: i.path.join('.'),
          message: i.message,
        })),
      },
      { status: 400 },
    );
  }

  try {
    await prisma.admissionLead.create({
      data: {
        ...parsed.data,
        // Store digits only, so 01712345678 and +880 1712-345678 are
        // recognisably the same person in the admin list.
        phone: parsed.data.phone.replace(/[\s-]/g, ''),
        ipAddress: ip,
        userAgent: userAgent ?? null,
      },
    });
  } catch {
    return NextResponse.json(
      { error: 'Could not save your request. Please try again.' },
      { status: 500 },
    );
  }

  return NextResponse.json({ ok: true });
}
