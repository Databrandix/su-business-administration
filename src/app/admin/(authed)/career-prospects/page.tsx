import { redirect } from 'next/navigation';
import { prisma } from '@/lib/db';
import { getSession } from '@/lib/auth-server';
import CareerProspectsForm from './CareerProspectsForm';

export const metadata = { title: 'Career Prospects' };

export default async function CareerProspectsAdminPage() {
  const session = await getSession();
  if (!session?.user) redirect('/admin/login');

  const row = await prisma.careerProspects.findUnique({
    where: { id: 'singleton' },
  });

  return (
    <div className="space-y-6 max-w-3xl">
      <header>
        <h1 className="text-2xl font-display font-bold text-gray-900">
          Career Prospects
        </h1>
        <p className="mt-1 text-sm text-gray-500">
          Shared careers section shown on every{' '}
          <code className="font-mono">/programs/&lt;slug&gt;</code> page.
        </p>
      </header>
      <CareerProspectsForm initial={row} />
    </div>
  );
}
