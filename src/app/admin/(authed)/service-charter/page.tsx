import { redirect } from 'next/navigation';
import { prisma } from '@/lib/db';
import { getSession } from '@/lib/auth-server';
import ServiceCharterClient from './ServiceCharterClient';

export const metadata = { title: 'Service Charter' };

export default async function ServiceCharterAdminPage() {
  const session = await getSession();
  if (!session?.user) redirect('/admin/login');

  const [items, meta] = await Promise.all([
    prisma.serviceCharterItem.findMany({ orderBy: { displayOrder: 'asc' } }),
    prisma.serviceCharterMeta.findUnique({ where: { id: 'singleton' } }),
  ]);

  return (
    <div className="max-w-4xl space-y-6">
      <header>
        <h1 className="font-display text-2xl font-bold text-gray-900">Service Charter</h1>
        <p className="mt-1 text-sm text-gray-500">
          Services shown on{' '}
          <code className="font-mono">/student-society/service-charter</code>.
        </p>
      </header>
      <ServiceCharterClient items={items} meta={meta} />
    </div>
  );
}
