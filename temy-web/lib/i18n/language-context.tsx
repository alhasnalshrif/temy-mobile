"use client";

import React, { createContext, useContext, useState, useEffect } from "react";
import { Language, translations } from "@/lib/i18n/translations";

type LanguageContextType = {
    language: Language;
    setLanguage: (lang: Language) => void;
    t: (key: string) => string;
    dir: "ltr" | "rtl";
};

const LanguageContext = createContext<LanguageContextType | undefined>(undefined);

export function LanguageProvider({ children }: { children: React.ReactNode }) {
    const [language, setLanguage] = useState<Language>("ar");

    // Force Arabic on mount
    useEffect(() => {
        // We are removing localStorage persistence logic to force Arabic always for now, 
        // or we can just default it to 'ar' if not set.
        // Let's enforce 'ar' as requested "make it just arabic".
        setLanguage("ar");
        document.documentElement.dir = "rtl";
        document.documentElement.lang = "ar";
    }, []);

    const handleSetLanguage = (lang: Language) => {
        // Keeping this for potential future re-enabling, but it won't be exposed via UI for now.
        setLanguage(lang);
        document.documentElement.dir = lang === "ar" ? "rtl" : "ltr";
        document.documentElement.lang = lang;
    };

    const t = (path: string) => {
        const keys = path.split(".");
        let value: any = translations[language];
        for (const key of keys) {
            value = value?.[key];
        }
        return value || path;
    };

    return (
        <LanguageContext.Provider
            value={{
                language,
                setLanguage: handleSetLanguage,
                t,
                dir: language === "ar" ? "rtl" : "ltr",
            }}
        >
            <div dir={language === "ar" ? "rtl" : "ltr"} className={language === 'ar' ? 'font-arabic' : 'font-sans'}>
                {children}
            </div>
        </LanguageContext.Provider>
    );
}

export function useLanguage() {
    const context = useContext(LanguageContext);
    if (context === undefined) {
        throw new Error("useLanguage must be used within a LanguageProvider");
    }
    return context;
}
