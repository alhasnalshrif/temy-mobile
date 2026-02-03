"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import * as z from "zod";
import { toast } from "sonner";
import { format } from "date-fns";
import { CalendarIcon } from "lucide-react";

import { GuestService } from "@/services/guest-service";
import { useLanguage } from "@/lib/i18n/language-context";
import { cn } from "@/lib/utils";

import { Button } from "@/components/ui/button";
import { Calendar } from "@/components/ui/calendar";
import {
    Dialog,
    DialogContent,
    DialogDescription,
    DialogHeader,
    DialogTitle,
    DialogTrigger,
} from "@/components/ui/dialog";
import {
    Form,
    FormControl,
    FormField,
    FormItem,
    FormLabel,
    FormMessage,
} from "@/components/ui/form";
import {
    Popover,
    PopoverContent,
    PopoverTrigger,
} from "@/components/ui/popover";
import { Input } from "@/components/ui/input";

const formSchema = z.object({
    name: z.string().min(2, "Name must be at least 2 characters"),
    phone: z.string().min(10, "Phone number must be at least 10 characters"),
    date: z.date(),
    time: z.string().min(1, "Time is required"),
    note: z.string().optional(),
});

interface BookingDialogProps {
    barberId: string;
    serviceIds: string[];
    trigger?: React.ReactNode;
    onSuccess?: () => void;
}

export function BookingDialog({ barberId, serviceIds, trigger, onSuccess }: BookingDialogProps) {
    const { t, language } = useLanguage();
    const [open, setOpen] = useState(false);
    const [isLoading, setIsLoading] = useState(false);
    const router = useRouter();

    const form = useForm<z.infer<typeof formSchema>>({
        resolver: zodResolver(formSchema),
        defaultValues: {
            name: "",
            phone: "",
            time: "",
            note: "",
        },
    });

    async function onSubmit(values: z.infer<typeof formSchema>) {
        if (serviceIds.length === 0) {
            toast.error(t('common.selectServices') || "Please select at least one service.");
            return;
        }

        setIsLoading(true);
        try {
            // Mock API call simulation
            await new Promise(resolve => setTimeout(resolve, 1000));

            // Example payload preparation using date-fns
            // const formattedDate = format(values.date, "yyyy-MM-dd");

            toast.success(t('common.bookingSuccess') || "Appointment booked successfully!");
            setOpen(false);
            if (onSuccess) onSuccess();

        } catch (error: any) {
            toast.error(t('common.error') || "Failed to book appointment");
        } finally {
            setIsLoading(false);
        }
    }

    return (
        <Dialog open={open} onOpenChange={setOpen}>
            <DialogTrigger asChild>
                {trigger || <Button className="bg-primary-gradient hover:opacity-90 transition-opacity shadow-lg">{t('common.bookAppointment')}</Button>}
            </DialogTrigger>
            <DialogContent className="sm:max-w-[425px] p-0 overflow-hidden border-none shadow-2xl bg-white/95 backdrop-blur-xl">
                <DialogHeader className="bg-primary-gradient p-6 text-white text-center">
                    <DialogTitle className="text-2xl font-black tracking-tight text-center text-white mx-auto">{t('common.bookAppointment')}</DialogTitle>
                    <DialogDescription className="text-white/80 text-center mx-auto text-base">
                        {t('common.fillDetailsToBook')}
                    </DialogDescription>
                </DialogHeader>
                <div className="p-6">
                    <Form {...form}>
                        <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-5">
                            <div className="grid grid-cols-2 gap-4">
                                <FormField
                                    control={form.control}
                                    name="date"
                                    render={({ field }) => (
                                        <FormItem className="flex flex-col">
                                            <FormLabel className="text-primary font-bold">{t('common.date')}</FormLabel>
                                            <Popover>
                                                <PopoverTrigger asChild>
                                                    <FormControl>
                                                        <Button
                                                            variant={"outline"}
                                                            className={cn(
                                                                "w-full h-12 rounded-xl pl-3 text-left font-normal border-gray-200 focus:border-primary focus:ring-primary/20 bg-gray-50/50 hover:bg-gray-100",
                                                                !field.value && "text-muted-foreground"
                                                            )}
                                                        >
                                                            {field.value ? (
                                                                format(field.value, "PPP")
                                                            ) : (
                                                                <span>{t('common.pickDate') || "Pick a date"}</span>
                                                            )}
                                                            <CalendarIcon className="ml-auto h-4 w-4 opacity-50" />
                                                        </Button>
                                                    </FormControl>
                                                </PopoverTrigger>
                                                <PopoverContent className="w-auto p-0" align="start">
                                                    <Calendar
                                                        mode="single"
                                                        selected={field.value}
                                                        onSelect={field.onChange}
                                                        disabled={(date) =>
                                                            date < new Date() || date < new Date("1900-01-01")
                                                        }
                                                        initialFocus
                                                    />
                                                </PopoverContent>
                                            </Popover>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />
                                <FormField
                                    control={form.control}
                                    name="time"
                                    render={({ field }) => (
                                        <FormItem>
                                            <FormLabel className="text-primary font-bold">{t('common.time')}</FormLabel>
                                            <FormControl>
                                                <Input type="time" {...field} className="w-full h-12 rounded-xl border-gray-200 focus:border-primary focus:ring-primary/20 bg-gray-50/50" />
                                            </FormControl>
                                            <FormMessage />
                                        </FormItem>
                                    )}
                                />
                            </div>

                            <FormField
                                control={form.control}
                                name="name"
                                render={({ field }) => (
                                    <FormItem>
                                        <FormLabel className="text-primary font-bold">{t('common.guestQueueDialog.name')}</FormLabel>
                                        <FormControl>
                                            <Input placeholder={t('common.guestQueueDialog.name')} {...field} className={`h-12 rounded-xl border-gray-200 focus:border-primary focus:ring-primary/20 bg-gray-50/50 ${language === 'ar' ? 'text-right' : ''}`} />
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
                                            <Input placeholder="05xxxxxxxx" {...field} dir="ltr" className="h-12 rounded-xl border-gray-200 focus:border-primary focus:ring-primary/20 bg-gray-50/50" />
                                        </FormControl>
                                        <FormMessage />
                                    </FormItem>
                                )}
                            />

                            <Button type="submit" className="w-full h-14 text-lg font-bold rounded-xl bg-primary-gradient hover:opacity-95 shadow-lg shadow-primary/20 transition-all active:scale-[0.98]" disabled={isLoading}>
                                {isLoading ? (
                                    <span className="flex items-center gap-2">
                                        <span className="h-5 w-5 animate-spin rounded-full border-2 border-white border-t-transparent" />
                                        {t('common.pleaseWait') || "Please wait..."}
                                    </span>
                                ) : (
                                    t('common.confirmBooking') || "Confirm Booking"
                                )}
                            </Button>
                        </form>
                    </Form>
                </div>
            </DialogContent>
        </Dialog>
    );
}
