"use client";

import { useEffect, useState } from "react";
import Image from "next/image";
import { useParams, useRouter } from "next/navigation";
import Link from "next/link";
import { BarberService } from "@/services/barber-service";
import { BarberDetailData, BarberServiceItem } from "@/types/api-types";
import { GuestQueueDialog } from "@/components/guest-queue-dialog";
import { BookingDialog } from "@/components/booking-dialog";

import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Checkbox } from "@/components/ui/checkbox";
import { Badge } from "@/components/ui/badge";
import { Skeleton } from "@/components/ui/skeleton";
import { Button } from "@/components/ui/button";

import { useLanguage } from "@/lib/i18n/language-context";

export default function BarberDetailsPage() {
    const params = useParams(); // params.id
    const { t, language } = useLanguage();
    const router = useRouter();
    const [barber, setBarber] = useState<BarberDetailData | null>(null);
    const [loading, setLoading] = useState(true);
    const [selectedServices, setSelectedServices] = useState<string[]>([]);
    const [totalPrice, setTotalPrice] = useState(0);
    const [totalDuration, setTotalDuration] = useState(0);

    useEffect(() => {
        const fetchBarber = async () => {
            try {
                const id = Array.isArray(params.id) ? params.id[0] : params.id;
                if (!id) return;
                const response = await BarberService.getBarber(id);
                if (response.data) {
                    setBarber(response.data);
                }
            } catch (error) {
                console.error("Failed to fetch barber details", error);
            } finally {
                setLoading(false);
            }
        };

        fetchBarber();
    }, [params.id]);

    const toggleService = (service: BarberServiceItem) => {
        if (selectedServices.includes(service.id)) {
            setSelectedServices(selectedServices.filter((id) => id !== service.id));
            setTotalPrice((prev) => prev - service.price);
            setTotalDuration((prev) => prev - service.duration);
        } else {
            setSelectedServices([...selectedServices, service.id]);
            setTotalPrice((prev) => prev + service.price);
            setTotalDuration((prev) => prev + service.duration);
        }
    };

    // Helper to determine booking mode
    // If barber has availability data (even if empty slots structure), we assume they support bookings.
    // Or if there is a specific flag. For now, relying on 'availability' existing.
    const isBookingMode = !!barber?.availability;

    if (loading) {
        return (
            <div className="container mx-auto p-4 space-y-4">
                <Skeleton className="h-64 w-full rounded-xl" />
                <div className="space-y-2">
                    <Skeleton className="h-4 w-[250px]" />
                    <Skeleton className="h-4 w-[200px]" />
                </div>
            </div>
        );
    }

    if (!barber) {
        return (
            <div className="container mx-auto p-4 flex flex-col items-center justify-center min-h-[50vh]">
                <h3 className="text-2xl font-bold text-primary mb-2">{t('common.barberNotFound')}</h3>
                <Link href="/">
                    <Button variant="outline">{t('common.returnHome')}</Button>
                </Link>
            </div>
        );
    }

    return (
        <div className="container mx-auto p-4 space-y-8 pb-32">
            {/* Barber Header */}
            <div className="relative rounded-3xl overflow-hidden bg-white shadow-xl">
                <div className="relative h-64 md:h-80 w-full bg-gray-100">
                    {/* Cover Image */}
                    {barber.portfolioImages?.length > 0 ? (
                        <Image
                            src={barber.portfolioImages[0]}
                            alt={barber.name}
                            fill
                            className="object-cover"
                            unoptimized
                        />
                    ) : (
                        <div className="absolute inset-0 bg-gradient-to-br from-primary/10 to-primary/5" />
                    )}
                    <div className="absolute inset-0 bg-gradient-to-t from-primary/90 via-primary/40 to-transparent" />
                </div>

                <div className="relative px-6 pb-6 -mt-20 md:-mt-24 flex flex-col md:flex-row items-start md:items-end gap-6">
                    <div className="relative group">
                        <div className="w-32 h-32 md:w-40 md:h-40 rounded-3xl border-[6px] border-white overflow-hidden bg-white shadow-2xl skew-y-0 transition-transform duration-300 hover:rotate-2">
                            <Image
                                src={barber.avatar || "/placeholder.png"}
                                alt={barber.name}
                                fill
                                className="object-cover"
                                unoptimized
                            />
                        </div>
                        <div className={`absolute -bottom-3 ${language === 'ar' ? '-left-3' : '-right-3'} bg-white px-3 py-1 rounded-full shadow-md flex items-center gap-1`}>
                            <span className="text-yellow-500">★</span>
                            <span className="font-bold text-sm text-primary">{barber.rating.average.toFixed(1)}</span>
                        </div>
                    </div>

                    <div className="flex-1 text-white pb-2">
                        <h1 className="text-3xl md:text-5xl font-black tracking-tight mb-2 md:mb-0 shadow-sm">{barber.name}</h1>
                        <p className="text-white/90 font-medium text-lg max-w-2xl text-shadow-sm">{barber.about || "Professional barber ready to create your perfect look."}</p>
                    </div>
                </div>
            </div>

            {/* Services Selection */}
            <div className="space-y-6">
                <div className="flex items-center justify-between">
                    <h2 className="text-3xl font-black tracking-tight text-primary">{t('common.selectServices')}</h2>
                    <span className="text-sm font-semibold text-secondary bg-accent px-3 py-1 rounded-full">
                        {barber.services.length} {t('common.available')}
                    </span>
                </div>

                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                    {barber.services.map((service) => {
                        const isSelected = selectedServices.includes(service.id);
                        return (
                            <Card
                                key={service.id}
                                className={`group cursor-pointer relative overflow-hidden transition-all duration-300 border-2 ${isSelected
                                    ? "border-primary bg-primary/5 shadow-md scale-[1.01]"
                                    : "border-transparent hover:border-primary/20 hover:shadow-lg bg-white"
                                    }`}
                                onClick={() => toggleService(service)}
                            >
                                {isSelected && (
                                    <div className={`absolute top-0 ${language === 'ar' ? 'left-0' : 'right-0'} w-16 h-16 bg-gradient-to-bl from-primary to-transparent ${language === 'ar' ? '-ml-8' : '-mr-8'} -mt-8 rounded-bl-full opacity-20`} />
                                )}
                                <CardContent className="p-5 flex items-start gap-4">
                                    <div className={`mt-1 h-6 w-6 rounded-full border-2 flex items-center justify-center transition-colors ${isSelected ? "border-primary bg-primary" : "border-gray-300 group-hover:border-primary/50"
                                        }`}>
                                        {isSelected && <div className="h-2.5 w-2.5 rounded-full bg-white" />}
                                    </div>

                                    <div className="flex-1">
                                        <div className="flex items-start justify-between mb-1">
                                            <h4 className={`text-lg font-bold transition-colors ${isSelected ? "text-primary" : "text-gray-900 group-hover:text-primary"}`}>
                                                {service.name}
                                            </h4>
                                            <span className={`font-bold text-lg ${isSelected ? "text-primary" : "text-gray-900"}`}>
                                                {service.price} <span className="text-xs font-normal text-muted-foreground">{t('common.sar')}</span>
                                            </span>
                                        </div>

                                        <div className="flex items-center gap-2 text-sm text-secondary mb-2">
                                            <span className="flex items-center gap-1 bg-secondary/10 px-2 py-0.5 rounded-md">
                                                ⏱ {service.duration} {t('common.mins')}
                                            </span>
                                        </div>

                                        {service.description && (
                                            <p className="text-sm text-muted-foreground leading-relaxed">
                                                {service.description}
                                            </p>
                                        )}
                                    </div>
                                </CardContent>
                            </Card>
                        );
                    })}
                </div>
            </div>

            {/* Booking Footer */}
            <div className="fixed bottom-0 left-0 right-0 bg-white/95 backdrop-blur-md p-4 shadow-[0_-4px_20px_rgba(0,0,0,0.05)] border-t z-40 transform transition-transform duration-300">
                <div className="container mx-auto flex items-center justify-between gap-4 max-w-lg">
                    <div className="flex-1">
                        <p className="text-sm text-gray-500 font-medium mb-0.5">{selectedServices.length} {t('common.servicesSelected') || "services"}</p>
                        <p className="text-2xl font-black text-primary flex items-center gap-1">
                            <span>{totalPrice}</span>
                            <span className="text-sm text-gray-500 font-bold">RAS</span>
                        </p>
                    </div>

                    {selectedServices.length > 0 && (
                        isBookingMode ? (
                            <Button
                                className="bg-primary-gradient hover:opacity-90 rounded-2xl h-14 px-8 font-bold text-lg shadow-lg shadow-primary/20 transition-transform active:scale-95"
                                onClick={() => {
                                    router.push(`/booking?barberId=${barber.id}&serviceIds=${selectedServices.join(",")}`);
                                }}
                            >
                                {t('common.bookAppointment')}
                            </Button>
                        ) : (
                            <GuestQueueDialog
                                barberId={barber.id}
                                serviceIds={selectedServices}
                                trigger={
                                    <Button className="bg-primary-gradient hover:opacity-90 rounded-2xl h-14 px-8 font-bold text-lg shadow-lg shadow-primary/20 transition-transform active:scale-95">
                                        {t('common.joinQueue')}
                                    </Button>
                                }
                            />
                        )
                    )}
                </div>
            </div>
        </div>
    );
}
