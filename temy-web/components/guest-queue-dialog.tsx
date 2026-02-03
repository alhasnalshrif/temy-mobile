"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import * as z from "zod";
import { toast } from "sonner";
import { GuestService } from "@/services/guest-service";
import { Button } from "@/components/ui/button";
import { useLanguage } from "@/lib/i18n/language-context";

import {
    Dialog,
    DialogContent,
    DialogDescription,
    DialogFooter, // Make sure to use or remove if unused, but restoring for safety
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
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";



interface GuestQueueDialogProps {
    barberId: string;
    serviceIds: string[];
    trigger?: React.ReactNode;
    onSuccess?: () => void;
}

export function GuestQueueDialog({ barberId, serviceIds, trigger, onSuccess }: GuestQueueDialogProps) {
    const { t, language } = useLanguage();
    const [open, setOpen] = useState(false);
    const [isLoading, setIsLoading] = useState(false);
    const router = useRouter();

    const formSchema = z.object({
        name: z.string().min(3, t('validation.nameTooShort') || "الاسم يجب أن يكون 3 أحرف على الأقل"),
        phone: z.string().regex(/^\+?[0-9]{10,15}$/, t('validation.phoneInvalid') || "رقم الهاتف غير صحيح"),
        note: z.string().optional(),
    });

    const form = useForm<z.infer<typeof formSchema>>({
        resolver: zodResolver(formSchema),
        defaultValues: {
            name: "",
            phone: "",
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
            // ... (keep logic same)
            const response = await GuestService.joinQueue({
                barberId,
                serviceIds,
                guest: {
                    name: values.name,
                    phone: values.phone,
                },
                note: values.note
            });

            if (response.status === "success" || response.data) {
                toast.success(t('common.queueJoinedSuccess') || "Successfully joined the queue!");
                setOpen(false);
                if (onSuccess) onSuccess();

                if (response.data && response.data._id) {
                    router.push(`/queue/${response.data._id}`);
                }
            } else {
                toast.error(response.message || t('common.error') || "Failed to join queue");
            }
        } catch (error: any) {
            // ...
        } finally {
            setIsLoading(false);
        }
    }

    return (
        <Dialog open={open} onOpenChange={setOpen}>
            <DialogTrigger asChild>
                {trigger || <Button className="bg-primary-gradient hover:opacity-90 shadow-lg transition-all">{t('common.joinQueue')}</Button>}
            </DialogTrigger>
            <DialogContent className="sm:max-w-[425px] p-0 overflow-hidden border-none shadow-2xl bg-white/95 backdrop-blur-xl">
                <DialogHeader className="bg-primary-gradient p-6 text-white text-center">
                    <DialogTitle className="text-2xl font-black tracking-tight text-center text-white mx-auto">{t('common.guestQueueDialog.title')}</DialogTitle>
                    <DialogDescription className="text-white/80 text-center mx-auto text-base">
                        {t('common.guestQueueDialog.description')}
                    </DialogDescription>
                </DialogHeader>
                <div className="p-6">
                    <Form {...form}>
                        <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-5">
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
                            {/* Note field optional, keeping it simple for now or adding translation if needed */}

                            <Button type="submit" className="w-full h-14 text-lg font-bold rounded-xl bg-primary-gradient hover:opacity-95 shadow-lg shadow-primary/20 transition-all active:scale-[0.98]" disabled={isLoading}>
                                {isLoading ? ( // Changed 'loading' to 'isLoading'
                                    <span className="flex items-center gap-2">
                                        <span className="h-5 w-5 animate-spin rounded-full border-2 border-white border-t-transparent" />
                                        {t('common.pleaseWait') || "Please wait..."}
                                    </span>
                                ) : (
                                    t('common.guestQueueDialog.submit')
                                )}
                            </Button>
                        </form>
                    </Form>
                </div>
            </DialogContent>
        </Dialog>
    );
}
