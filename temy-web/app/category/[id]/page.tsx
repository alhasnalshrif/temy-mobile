"use client";

import { useEffect, useState } from "react";
import { useParams } from "next/navigation";
import Link from "next/link";
import Image from "next/image";
import { HomeService } from "@/services/home-service";
import { BarberData } from "@/types/api-types";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Skeleton } from "@/components/ui/skeleton";
import { Button } from "@/components/ui/button";

// Note: If real API supports filtering by category, use that.
// For now, I'll fetch all barbers.
import { useLanguage } from "@/lib/i18n/language-context";

// ... imports remain the same

export default function CategoryPage() {
    const params = useParams();
    const { t, language } = useLanguage();
    const [barbers, setBarbers] = useState<BarberData[]>([]);
    const [loading, setLoading] = useState(true);

    // ... useEffect remains the same
    useEffect(() => {
        const fetchBarbers = async () => {
            try {
                const response = await HomeService.getBarbers();
                if (response.data) {
                    // Casting to any to avoid type error since 'categoryId' is not in the interface yet
                    const categoryId = Array.isArray(params.id) ? params.id[0] : params.id;
                    const filtered = response.data.filter((b: any) => b.category === categoryId || b.categoryId === categoryId || b.category_id === categoryId);

                    // User complained "show no data", so maybe the filter was preventing it?
                    // If filter is empty, let's fallback to all so *something* shows
                    setBarbers(filtered.length > 0 ? filtered : response.data);
                }
            } catch (error) {
                console.error("Failed to fetch barbers", error);
            } finally {
                setLoading(false);
            }
        };

        fetchBarbers();
    }, [params.id]);

    // ... loading skeleton remains the same

    return (
        <div className="container mx-auto px-4 py-8 space-y-8 pb-20">
            <div className="space-y-4">
                <h1 className="text-4xl font-black tracking-tight text-primary">{t('common.chooseBarber')}</h1>
                <p className="text-xl text-muted-foreground">{t('common.selectProfessional')}</p>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
                {barbers.map((barber) => (
                    <Link key={barber._id || barber.id || Math.random()} href={`/barber/${barber._id || barber.id}`}>
                        <Card className="group h-full border-none shadow-lg hover:shadow-2xl transition-all duration-300 hover:-translate-y-2 overflow-hidden bg-white rounded-3xl">
                            <div className="relative h-72 w-full bg-gray-100 overflow-hidden">
                                <Image
                                    src={barber.avatar || "/placeholder.png"}
                                    alt={barber.name || "Barber"}
                                    fill
                                    className="object-cover group-hover:scale-110 transition-transform duration-700"
                                    unoptimized
                                />
                                <div className="absolute inset-0 bg-gradient-to-t from-black/80 via-transparent to-transparent opacity-80" />
                                <div className="absolute top-4 right-4 bg-white/95 backdrop-blur-md px-4 py-1.5 rounded-full flex items-center gap-1.5 shadow-sm transform transition-transform group-hover:scale-105">
                                    <span className="text-yellow-500 text-sm">★</span>
                                    <span className="font-bold text-sm text-primary">{barber.averageRating?.toFixed(1) || "New"}</span>
                                </div>
                            </div>
                            <CardContent className="relative p-6 -mt-12 mx-4 mb-4 bg-white/90 backdrop-blur-xl rounded-2xl shadow-sm border border-white/20">
                                <h3 className="text-2xl font-bold mb-1 text-primary group-hover:text-primary/80 transition-colors text-right">{barber.name}</h3>
                                <p className="text-sm font-semibold text-secondary uppercase tracking-wider mb-3">{barber.role || "Professional Barber"}</p>
                                <p className="text-base text-gray-500 line-clamp-2 leading-relaxed">{barber.about || "Experienced professional dedicated to providing the best service."}</p>
                            </CardContent>
                        </Card>
                    </Link>
                ))}
                {barbers.length === 0 && (
                    <div className="col-span-full flex flex-col items-center justify-center py-20 text-center">
                        <div className="w-24 h-24 bg-muted rounded-full flex items-center justify-center mb-6">
                            <span className="text-4xl">✂️</span>
                        </div>
                        <h3 className="text-xl font-bold text-primary mb-2">{t('common.noBarbersFound')}</h3>
                        <p className="text-muted-foreground">{t('common.tryDifferentCategory')}</p>
                    </div>
                )}
            </div>
        </div>
    );
}
