"use client";

import { useState, useEffect, Suspense } from "react";
import { useSearchParams, useRouter } from "next/navigation";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import * as z from "zod";
import { toast } from "sonner";
import { format, addDays, startOfToday, isSameDay } from "date-fns";
import { ar } from "date-fns/locale";
import { ArrowRight, ChevronRight, Clock, CalendarDays, CheckCircle2 } from "lucide-react";

import { useLanguage } from "@/lib/i18n/language-context";
import { cn } from "@/lib/utils";
import { Button } from "@/components/ui/button";
import {
    Form,
    FormControl,
    FormField,
    FormItem,
    FormLabel,
    FormMessage,
} from "@/components/ui/form";
import { Input } from "@/components/ui/input";
import { Card } from "@/components/ui/card";
import { Separator } from "@/components/ui/separator";

// --- Types & Schema ---

type TimeSlot = {
    id: string;
    time: string;
    label: string; // e.g., "10:00 AM"
    period: "morning" | "afternoon" | "evening";
};

// --- Mock Data Generator ---

const generateDates = (days = 14) => {
    const today = startOfToday();
    return Array.from({ length: days }, (_, i) => addDays(today, i));
};

const generateTimeSlots = (): TimeSlot[] => {
    // This would typically come from the API based on the selected date and barber
    return [
        { id: "10:00", time: "10:00", label: "10:00 ص", period: "morning" },
        { id: "10:30", time: "10:30", label: "10:30 ص", period: "morning" },
        { id: "11:00", time: "11:00", label: "11:00 ص", period: "morning" },
        { id: "11:30", time: "11:30", label: "11:30 ص", period: "morning" },
        { id: "14:00", time: "14:00", label: "02:00 م", period: "afternoon" },
        { id: "14:30", time: "14:30", label: "02:30 م", period: "afternoon" },
        { id: "15:00", time: "15:00", label: "03:00 م", period: "afternoon" },
        { id: "15:30", time: "15:30", label: "03:30 م", period: "afternoon" },
        { id: "16:00", time: "16:00", label: "04:00 م", period: "afternoon" },
        { id: "19:00", time: "19:00", label: "07:00 م", period: "evening" },
        { id: "19:30", time: "19:30", label: "07:30 م", period: "evening" },
        { id: "20:00", time: "20:00", label: "08:00 م", period: "evening" },
    ];
};

function BookingPageContent() {
    const { t, language } = useLanguage();
    const router = useRouter();
    const searchParams = useSearchParams();

    // Query Params
    const barberId = searchParams.get("barberId");
    const serviceIds = searchParams.get("serviceIds")?.split(",") || [];

    // State
    const [dates] = useState(generateDates());
    const [selectedDate, setSelectedDate] = useState<Date>(startOfToday());
    const [timeSlots, setTimeSlots] = useState<TimeSlot[]>([]);
    const [selectedTime, setSelectedTime] = useState<string>("");
    const [isLoading, setIsLoading] = useState(false);

    const formSchema = z.object({
        name: z.string().min(3, t('validation.nameTooShort') || "الاسم يجب أن يكون 3 أحرف على الأقل"),
        phone: z.string().regex(/^\+?[0-9]{10,15}$/, t('validation.phoneInvalid') || "رقم الهاتف غير صحيح"),
        date: z.date({ message: t('validation.dateRequired') || "التاريخ مطلوب" }),
        time: z.string().min(1, t('validation.timeRequired') || "يجب اختيار الوقت"),
        note: z.string().optional(),
    });

    const form = useForm<z.infer<typeof formSchema>>({
        resolver: zodResolver(formSchema),
        defaultValues: {
            name: "",
            phone: "",
            date: startOfToday(),
            time: "",
            note: "",
        },
    });

    // Validations & Effects
    useEffect(() => {
        if (!barberId || serviceIds.length === 0) {
            toast.error(t('common.error') || "Missing booking information");
            // router.push("/"); // Uncomment to redirect if invalid
        }
        // Load time slots when date changes (Mock)
        setTimeSlots(generateTimeSlots());
    }, [barberId, serviceIds, selectedDate, t]); // Removed router from deps

    useEffect(() => {
        form.setValue("date", selectedDate);
        form.setValue("time", selectedTime);
    }, [selectedDate, selectedTime, form]);


    async function onSubmit(values: z.infer<typeof formSchema>) {
        setIsLoading(true);
        try {
            // Mock API Submission
            await new Promise(resolve => setTimeout(resolve, 1500));

            console.log("Submitting Booking:", {
                barberId,
                serviceIds,
                ...values
            });

            toast.success(t('common.bookingSuccess') || "تم حجز الموعد بنجاح!");
            router.push("/"); // Redirect to home or success page
        } catch (error) {
            toast.error(t('common.error') || "حدث خطأ أثناء الحجز");
        } finally {
            setIsLoading(false);
        }
    }

    // Handlers
    const handleDateSelect = (date: Date) => {
        setSelectedDate(date);
        setSelectedTime(""); // Reset time when date changes
    };

    return (
        <div className="min-h-screen bg-gray-50/50 pb-24 font-arabic">
            {/* Header */}
            <header className="sticky top-0 z-10 bg-white/80 backdrop-blur-md border-b border-gray-100">
                <div className="container mx-auto px-4 h-16 flex items-center gap-4">
                    <Button variant="ghost" size="icon" onClick={() => router.back()} className="rounded-full hover:bg-gray-100">
                        <ArrowRight className="h-6 w-6 text-primary" />
                    </Button>
                    <h1 className="text-xl font-bold text-primary">{t('common.bookAppointment')}</h1>
                </div>
            </header>

            <main className="container mx-auto px-4 py-8 max-w-2xl space-y-8">

                {/* 1. Date Selection (Strip) */}
                <section className="space-y-4">
                    <div className="flex items-center gap-2 text-primary">
                        <CalendarDays className="h-5 w-5" />
                        <h2 className="text-lg font-bold">{t('common.date') || "اختر اليوم"}</h2>
                    </div>

                    <div className="flex gap-3 overflow-x-auto pb-4 scrollbar-hide -mx-4 px-4 snap-x">
                        {dates.map((date, index) => {
                            const isSelected = isSameDay(date, selectedDate);
                            return (
                                <button
                                    key={index}
                                    onClick={() => handleDateSelect(date)}
                                    className={cn(
                                        "flex flex-col items-center justify-center min-w-[4.5rem] h-20 rounded-2xl border transition-all duration-300 snap-start",
                                        isSelected
                                            ? "bg-primary-gradient border-transparent text-white shadow-lg shadow-primary/20 scale-105"
                                            : "bg-white border-gray-200 text-gray-600 hover:border-primary/30 hover:bg-gray-50"
                                    )}
                                >
                                    <span className="text-xs font-medium opacity-80 uppercase">
                                        {format(date, "EEE", { locale: ar })}
                                    </span>
                                    <span className={cn("text-2xl font-bold", isSelected ? "text-white" : "text-primary")}>
                                        {format(date, "d")}
                                    </span>
                                </button>
                            );
                        })}
                    </div>
                </section>

                <Separator className="bg-gray-100" />

                {/* 2. Time Selection (Grid) */}
                <section className="space-y-4">
                    <div className="flex items-center gap-2 text-primary">
                        <Clock className="h-5 w-5" />
                        <h2 className="text-lg font-bold">{t('common.time') || "اختر الوقت"}</h2>
                    </div>

                    {/* Periods - Grouping logic could be added here visually if needed */}
                    <div className="grid grid-cols-3 sm:grid-cols-4 gap-3">
                        {timeSlots.map((slot) => {
                            const isSelected = selectedTime === slot.time;
                            return (
                                <button
                                    key={slot.id}
                                    onClick={() => setSelectedTime(slot.time)}
                                    className={cn(
                                        "py-3 px-2 rounded-xl text-sm font-bold border transition-all duration-200 relative overflow-hidden",
                                        isSelected
                                            ? "bg-primary text-white border-primary shadow-md ring-2 ring-primary/20"
                                            : "bg-white border-gray-200 text-gray-700 hover:border-primary/50 hover:bg-primary/5"
                                    )}
                                >
                                    {slot.label}
                                    {isSelected && <CheckCircle2 className="absolute top-1 left-1 h-3 w-3 text-white/50" />}
                                </button>
                            );
                        })}
                    </div>
                    {timeSlots.length === 0 && (
                        <p className="text-center text-muted-foreground py-8">لا توجد مواعيد متاحة لهذا اليوم</p>
                    )}
                </section>

                <Separator className="bg-gray-100" />

                {/* 3. Guest Details Form */}
                <section className="space-y-4">
                    <h2 className="text-lg font-bold text-primary">{t('common.fillDetailsToBook') || "بيانات الحجز"}</h2>
                    <Card className="p-6 border-none shadow-sm bg-white rounded-3xl">
                        <Form {...form}>
                            <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-5">
                                <FormField
                                    control={form.control}
                                    name="name"
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel className="text-primary font-bold">{t('common.guestQueueDialog.name')}</FormLabel>
                                            <FormControl>
                                                <Input
                                                    placeholder={t('common.guestQueueDialog.name')}
                                                    {...field}
                                                    className="h-12 rounded-xl border-gray-200 focus:border-primary focus:ring-primary/20 bg-gray-50/50 text-right"
                                                />
                                            </FormControl>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />
                                <FormField
                                    control={form.control}
                                    name="phone"
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel className="text-primary font-bold">{t('common.guestQueueDialog.phone')}</FormLabel>
                                            <FormControl>
                                                <Input
                                                    placeholder="05xxxxxxxx"
                                                    {...field}
                                                    dir="ltr"
                                                    className="h-12 rounded-xl border-gray-200 focus:border-primary focus:ring-primary/20 bg-gray-50/50"
                                                />
                                            </FormControl>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />

                                <Button
                                    type="submit"
                                    className="w-full h-14 text-lg font-bold rounded-2xl bg-primary-gradient hover:opacity-95 shadow-xl shadow-primary/20 transition-all active:scale-[0.98] mt-4"
                                    disabled={isLoading || !selectedTime}
                                >
                                    {isLoading ? (
                                        <span className="flex items-center gap-2">
                                            <span className="h-5 w-5 animate-spin rounded-full border-2 border-white border-t-transparent" />
                                            {t('common.pleaseWait') || "جاري الحجز..."}
                                        </span>
                                    ) : (
                                        t('common.confirmBooking') || "تأكيد الحجز"
                                    )}
                                </Button>
                            </form>
                        </Form>
                    </Card>
                </section>
            </main>
        </div>
    );
}

export default function BookingPage() {
    return (
        <Suspense fallback={<div className="flex items-center justify-center min-h-screen"><span className="animate-spin h-8 w-8 border-4 border-primary border-t-transparent rounded-full"></span></div>}>
            <BookingPageContent />
        </Suspense>
    );
}
