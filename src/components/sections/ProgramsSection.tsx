'use client';

import Image from 'next/image';
import { motion } from 'motion/react';
import { Clock, CheckCircle2, ArrowRight } from 'lucide-react';
import Container from '../ui/Container';

const DEFAULT_PROGRAM_IMAGE = '/assets/program-undergraduate.webp';
const DEFAULT_CTA_TEXT = 'View More';

type ProgramRow = {
  id: string;
  overline: string;
  programName: string;
  degreeCode: string;
  duration: string;
  description: string;
  imageUrl: string | null;
  specializations: string[];
  cta: string | null;
  ctaHref: string | null;
};

const DEFAULT_CTA_HREF = '/admission/requirements';

type ProgramsSectionProps = {
  programs: readonly ProgramRow[];
};

export default function ProgramsSection({ programs }: ProgramsSectionProps) {
  return (
    <section className="bg-[#F2F2F2] py-12 md:py-20">
      <Container>
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          className="text-center mb-10 md:mb-14"
        >
          <div className="flex items-center justify-center gap-3 mb-2">
            <span className="w-10 h-[1.5px] bg-accent/40" />
            <span className="text-accent font-bold tracking-[0.2em] uppercase text-[10px]">
              Academic Programs
            </span>
          </div>
          <h2 className="text-2xl md:text-3xl lg:text-4xl font-bold text-primary">
            Programmes Offered
          </h2>
          <div className="mt-3 mx-auto h-1 w-16 bg-accent rounded-full" />
        </motion.div>

        <div className="space-y-12 md:space-y-16">
          {programs.map((program, idx) => {
            const heading = program.programName;
            const imageSrc = program.imageUrl || DEFAULT_PROGRAM_IMAGE;
            const ctaText = program.cta || DEFAULT_CTA_TEXT;
            // Alternate sides: even rows put the image left, odd rows
            // flip it to the right. Mobile always stacks image-first.
            const imageRight = idx % 2 === 1;

            return (
              <div key={program.id}>
                {/* Overline sits above the whole row, so it stays on the
                    left even when the image flips to the right. */}
                {program.overline && (
                  <p className="mb-4 border-l-[3px] border-accent pl-3 text-[22px] md:text-[26px] font-display font-bold text-primary">
                    {program.overline}
                  </p>
                )}
              <motion.article
                initial={{ opacity: 0, y: 30 }}
                whileInView={{ opacity: 1, y: 0 }}
                viewport={{ once: true }}
                transition={{ delay: idx * 0.08, duration: 0.6 }}
                className="grid items-start gap-8 md:gap-12 lg:gap-16 lg:grid-cols-2"
              >
                {/* Image — alternates left / right */}
                <div className={imageRight ? 'order-1 lg:order-2' : 'order-1'}>
                  <div className="relative rounded-2xl overflow-hidden shadow-2xl group h-[300px] md:h-[400px]">
                  <Image
                    src={imageSrc}
                    alt={program.programName}
                    fill
                    sizes="(min-width: 1024px) 50vw, 100vw"
                    className="object-cover transition-transform duration-700 group-hover:scale-105"
                  />
                  <div className="absolute inset-0 bg-gradient-to-t from-primary/40 via-transparent to-transparent pointer-events-none" />
                  {program.duration && (
                    <span className="absolute top-4 left-4 inline-flex items-center gap-1.5 rounded-full bg-white/95 backdrop-blur-sm px-4 py-1.5 text-[12px] font-bold text-primary shadow-md">
                      <Clock size={13} className="text-accent" />
                      {program.duration}
                    </span>
                  )}
                  </div>
                </div>

                {/* Content — alternates right / left */}
                <div className={imageRight ? 'order-2 lg:order-1' : 'order-2'}>
                  <h3 className="text-2xl md:text-3xl lg:text-[34px] font-display font-bold text-primary leading-tight mb-4">
                    {heading}
                  </h3>

                  <p className="text-[15px] md:text-[16px] leading-[1.85] text-gray-700 mb-6">
                    {program.description}
                  </p>

                  {program.specializations && program.specializations.length > 0 && (
                    <div className="mb-7">
                      <p className="text-[12px] font-bold uppercase tracking-wider text-gray-500 mb-3">
                        Specializations
                      </p>
                      <ul className="grid sm:grid-cols-2 gap-2.5">
                        {program.specializations.map((spec) => (
                          <li
                            key={spec}
                            className="flex items-center gap-2.5 text-[14px] font-semibold text-primary"
                          >
                            <CheckCircle2 size={18} className="shrink-0 text-accent" />
                            {spec}
                          </li>
                        ))}
                      </ul>
                    </div>
                  )}

                  <a
                    href={program.ctaHref ?? DEFAULT_CTA_HREF}
                    className="group inline-flex items-center gap-2 rounded-full bg-gradient-to-r from-primary to-accent px-8 py-3 text-base font-bold text-white shadow-md transition-all hover:shadow-premium"
                  >
                    {ctaText}
                    <ArrowRight
                      size={18}
                      className="transition-transform group-hover:translate-x-1"
                    />
                  </a>
                </div>
              </motion.article>
              </div>
            );
          })}

        </div>
      </Container>
    </section>
  );
}
