export type Language = 'en' | 'ar';

export const translations = {
    en: {
        common: {
            browseCategories: "Browse Categories",
            chooseBarber: "Choose your Barber",
            selectProfessional: "Select a professional to proceed with your booking.",
            selectServices: "Select Services",
            available: "Available",
            joinQueue: "Join Queue",
            bookAppointment: "Book Appointment",
            totalEstimation: "Total Estimation",
            mins: "mins",
            sar: "SAR",
            featured: "Featured",
            barberNotFound: "Barber not found",
            returnHome: "Return Home",
            noBarbersFound: "No barbers found",
            tryDifferentCategory: "Try selecting a different category or come back later.",
            reviews: "reviews",
            guestQueueDialog: {
                title: "Join Queue",
                description: "Enter your details to join the queue.",
                name: "Name",
                phone: "Phone Number",
                submit: "Confirm"
            }
        },
        validation: {
            nameRequired: "Name is required",
            nameTooShort: "Name must be at least 3 characters",
            phoneRequired: "Phone number is required",
            phoneInvalid: "Invalid phone number",
            dateRequired: "Date is required",
            timeRequired: "Time is required",
        },
        header: {
            title: "Temy Barber"
        }
    },
    ar: {
        common: {
            browseCategories: "تصفح الأقسام",
            chooseBarber: "اختر الحلاق",
            selectProfessional: "اختر محترفاً للمتابعة في الحجز.",
            selectServices: "اختر الخدمات",
            available: "متاح",
            joinQueue: "انضم للطابور",
            bookAppointment: "حجز موعد",
            totalEstimation: "إجمالي التقدير",
            mins: "دقيقة",
            sar: "ريال",
            featured: "مميز",
            barberNotFound: "لم يتم العثور على حلاق",
            returnHome: "العودة للرئيسية",
            noBarbersFound: "لم يتم العثور على حلاقين",
            tryDifferentCategory: "حاول اختيار قسم آخر أو عد لاحقاً.",
            reviews: "تقييمات",
            guestQueueDialog: {
                title: "انضم للطابور",
                description: "أدخل بياناتك للانضمام للطابور.",
                name: "الاسم",
                phone: "رقم الهاتف",
                submit: "تأكيد"
            }
        },
        validation: {
            nameRequired: "الاسم مطلوب",
            nameTooShort: "الاسم يجب أن يكون 3 أحرف على الأقل",
            phoneRequired: "رقم الهاتف مطلوب",
            phoneInvalid: "رقم الهاتف غير صحيح",
            dateRequired: "التاريخ مطلوب",
            timeRequired: "الوقت مطلوب",
        },
        header: {
            title: "تيمي باربر"
        }
    }
};
