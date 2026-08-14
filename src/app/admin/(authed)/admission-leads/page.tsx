import { redirect } from 'next/navigation';
import { prisma } from '@/lib/db';
import { getSession } from '@/lib/auth-server';
import AdmissionLeadsClient from './AdmissionLeadsClient';

export const metadata = { title: 'Admission Leads' };

export default async function AdmissionLeadsPage() {
  const session = await getSession();
  if (!session?.user) redirect('/admin/login');

  const [leads, settings] = await Promise.all([
    prisma.admissionLead.findMany({ orderBy: { submittedAt: 'desc' } }),
    prisma.admissionLeadPopup.findUnique({ where: { id: 'singleton' } }),
  ]);

  return (
    <div className="max-w-5xl space-y-6">
      <header>
        <h1 className="font-display text-2xl font-bold text-gray-900">
          Admission Leads
        </h1>
        <p className="mt-1 text-sm text-gray-500">
          Enquiries from the homepage popup, and the settings that control it.
        </p>
      </header>
      <AdmissionLeadsClient leads={leads} settings={settings} />
    </div>
  );
}
