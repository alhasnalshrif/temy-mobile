export const API_BASE_URL = "https://backend.temybarber.com/api/v1/";

export const ENDPOINTS = {
    AUTH: {
        LOGIN: "/auth/login",
        SIGNUP: "/auth/signup",
        VERIFY: "/auth/verify",
        RESEND_CODE: "/auth/resend-verification-code",
        REQUEST_PASSWORD_RESET: "/auth/request-password-reset",
        RESET_PASSWORD: "/auth/reset-password",
    },
    HOME: {
        CATEGORY: "/category",
        BARBERS: "/users/barbers",
        BANNERS: "/banners",
    },
    BARBER: {
        DETAIL: (id: string) => `/users/barbers/${id}`,
    },
    CATEGORY: {
        SERVICES: (id: string) => `/category/${id}/services`,
    },
    BOOKING: {
        RESERVATIONS: "/reservations",
        CANCEL: (id: string) => `/reservations/${id}/cancel`,
        AVAILABLE_SLOTS: "/reservations/available-slots",
        GUEST_REQUEST_VERIFICATION: "/reservations/guest/request-verification",
        GUEST_VERIFY_AND_CREATE: "/reservations/guest/verify-and-create",
        MULTIPLE_RESERVATIONS: "/reservations/multiple",
    },
    QUEUE: {
        JOIN: "/queue/join",
        GUEST_JOIN: "/queue/guest/join",
        STATUS: (barberId: string) => `/queue/status/${barberId}`,
        POSITION: (reservationId: string) => `/queue/position/${reservationId}`,
        ADVANCE: (barberId: string) => `/queue/advance/${barberId}`,
        SKIP: (reservationId: string) => `/queue/skip/${reservationId}`,
        CALL: (reservationId: string) => `/queue/call/${reservationId}`,
        HISTORY: (barberId: string) => `/queue/history/${barberId}`,
        SETTINGS: "/queue/settings",
    },
    PROFILE: {
        GET: "/users/profile",
        UPDATE: "/users/profile/update",
        DELETE: "/users/profile/delete",
        REGISTER_DEVICE: "/notifications/devices/register",
    },
    SETTINGS: {
        GET: "/settings",
    },
} as const;
