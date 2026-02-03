"use client";

import Link from "next/link";
import Image from "next/image";
import {
    Carousel,
    CarouselContent,
    CarouselItem,
    CarouselNext,
    CarouselPrevious,
} from "@/components/ui/carousel";
import { useLanguage } from "@/lib/i18n/language-context";
import { CategoryData, BannerData } from "@/types/api-types";

interface HomeClientProps {
    banners: BannerData[];
    categories: CategoryData[];
}

export default function HomeClient({ banners, categories }: HomeClientProps) {
    const { t, language } = useLanguage();
    const isRtl = language === 'ar';

    return (
        <div className="container mx-auto px-4 py-8 space-y-16">
            <section className="space-y-6">
                <div className="flex items-center gap-4">
                    <div className="h-10 w-2 bg-primary-gradient rounded-full" />
                    <h2 className="text-4xl font-black tracking-tight text-primary">{t('common.featured')}</h2>
                </div>

                <div className="w-full relative group">
                    <div className="absolute inset-0 bg-primary-gradient blur-2xl opacity-10 rounded-3xl -z-10" />
                    <div className="w-full" dir="ltr">
                        <Carousel className="w-full" opts={{ direction: isRtl ? 'rtl' : 'ltr' }}>
                            <CarouselContent className="-ml-4">
                                {banners.map((banner, index) => (
                                    <CarouselItem key={index} className="pl-4 md:basis-1/2 lg:basis-2/3">
                                        <div className="relative aspect-[21/9] rounded-3xl overflow-hidden shadow-2xl border-4 border-white/50 hover:border-primary/20 transition-all duration-500 group-hover:scale-[1.01]">
                                            <Image
                                                src={banner.image}
                                                alt={`Banner ${index}`}
                                                fill
                                                className="object-cover"
                                                unoptimized
                                            />
                                            <div className="absolute inset-0 bg-gradient-to-t from-black/60 to-transparent" />
                                        </div>
                                    </CarouselItem>
                                ))}
                            </CarouselContent>
                            <CarouselPrevious className="left-4 h-12 w-12 border-none bg-white/20 backdrop-blur text-white hover:bg-primary hover:text-white" />
                            <CarouselNext className="right-4 h-12 w-12 border-none bg-white/20 backdrop-blur text-white hover:bg-primary hover:text-white" />
                        </Carousel>
                    </div>
                </div>
            </section>

            <section className="space-y-8">
                <div className="flex items-center justify-between items-end">
                    <div className="space-y-2">
                        <span className="text-sm font-bold tracking-widest text-secondary uppercase px-4 py-1.5 bg-secondary/10 rounded-full w-fit block">
                            {t('common.browseCategories') || "Discover"}
                        </span>
                        <h2 className="text-4xl md:text-5xl font-black tracking-tight text-gray-900">
                            {t('common.browseCategories')}
                        </h2>
                    </div>
                    {/* Optional View All or arrows could go here */}
                </div>

                <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
                    {categories.map((category) => (
                        <Link
                            key={category._id || category.id}
                            href={`/category/${category._id || category.id}`}
                            className="group relative block aspect-[3/4] overflow-hidden rounded-[2rem] bg-white shadow-xl transition-all duration-500 hover:shadow-2xl hover:-translate-y-2 hover:shadow-primary/20"
                        >
                            <Image
                                src={category.imageCover || ""}
                                alt={category.name || "Category"}
                                fill
                                className="object-cover transition-transform duration-700 group-hover:scale-110 group-hover:rotate-1"
                                unoptimized
                            />
                            {/* Gradient Overlay */}
                            <div className="absolute inset-0 bg-gradient-to-t from-primary/90 via-primary/20 to-transparent opacity-60 transition-opacity duration-500 group-hover:opacity-80" />
                            <div className="absolute inset-0 bg-gradient-to-b from-transparent via-transparent to-black/80" />

                            <div className="absolute bottom-0 left-0 w-full p-6 text-white">
                                <div className="transform transition-transform duration-500 translate-y-2 group-hover:translate-y-0">
                                    <h3 className="text-2xl font-bold mb-2 leading-tight">
                                        {category.name}
                                    </h3>
                                    <div className={`h-1.5 w-12 bg-white/80 rounded-full transition-all duration-500 group-hover:w-full group-hover:bg-white`} />

                                    {category.description && (
                                        <p className="mt-3 text-sm text-gray-100 line-clamp-2 opacity-0 transition-all duration-500 group-hover:opacity-100 delay-75">
                                            {category.description}
                                        </p>
                                    )}
                                </div>
                            </div>

                            {/* Hover Border/Glow */}
                            <div className="absolute inset-0 border-4 border-transparent rounded-[2rem] transition-colors duration-300 group-hover:border-white/20 pointer-events-none" />
                        </Link>
                    ))}
                </div>
            </section>
        </div>
    );
}
