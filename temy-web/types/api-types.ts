// Common Interfaces
export interface PaginationResult {
    currentPage: number;
    limit: number;
    numberOfPages: number;
}

export interface BaseResponse<T> {
    status: string;
    results?: number;
    paginationResult?: PaginationResult;
    data: T;
}

// Banner
export interface BannerData {
    image: string;
}

export type BannerResponse = BaseResponse<BannerData[]>;

// Category
export interface CategoryData {
    _id?: string;
    id?: string;
    name?: string;
    description?: string;
    imageCover?: string;
}

export type CategoryResponse = BaseResponse<CategoryData[]>;

// Barber
export interface RestTime {
    start?: string;
    end?: string;
}

export interface WorkingHours {
    restTime?: RestTime;
    start?: string;
    end?: string;
    daysOff?: string[];
}

export interface BarberData {
    _id?: string;
    id?: string;
    name?: string;
    phone?: string;
    countryCode?: string;
    role?: string;
    avatar?: string;
    about?: string;
    portfolioImages?: string[];
    averageRating?: number;
    numberOfReviews?: number;
    workingHours?: WorkingHours;
    featured?: boolean;
}

export type BarberResponse = BaseResponse<BarberData[]>;

export interface BarberServiceItem {
    id: string;
    name: string;
    description?: string;
    price: number;
    duration: number;
    category: string;
    imageCover?: string;
}

export interface BarberDetailData {
    id: string;
    name: string;
    avatar: string;
    about?: string;
    portfolioImages: string[];
    max_reservation_days: number;
    workingHours: WorkingHours;
    rating: {
        average: number;
        total: number;
    };
    services: BarberServiceItem[];
    availability: {
        date: string;
        slots: {
            time: string;
            isAvailable: boolean;
        }[];
        isDayOff: boolean;
    };
}

export type BarberDetailResponse = {
    status: string;
    data: BarberDetailData;
};

// Auth Types
export interface LoginRequest {
    phone: string;
    password?: string;
    countryCode?: string;
}

export interface LoginResponse {
    status: string;
    token?: string;
    data?: {
        user: UserData;
    };
    message?: string;
}

export interface SignupRequest {
    name: string;
    phone: string;
    password?: string;
    countryCode?: string;
    role?: string;
}

export interface SignupResponse {
    status: string;
    message?: string;
    data?: {
        user: UserData;
    };
}

export interface VerifyRequest {
    phone: string;
    code: string;
}

export interface UserData {
    _id: string;
    name: string;
    phone: string;
    role: string;
    avatar?: string;
    email?: string;
}

// Service
export interface ServiceData {
    _id?: string;
    id?: string;
    name?: string;
    price?: number;
    duration?: number;
    images?: string[];
    imageCover?: string;
    category?: CategoryData;
    available?: boolean;
    createdAt?: string;
    updatedAt?: string;
}

export type ServiceResponse = BaseResponse<ServiceData[]>;

// Queue & Booking Types

export interface JoinQueueRequest {
    barberId: string;
    serviceIds: string[];
    userId?: string; // Optional for Guest
    guest?: {
        name: string;
        phone: string;
    };
    note?: string;
}

export interface QueueStatusResponse {
    status: string;
    data: {
        barber: BarberData;
        queue: {
            total_in_queue: number;
            estimated_service_time: number;
            waiting_customers: any[];
        };
    };
}

export interface ReservationData {
    _id: string;
    user?: string;
    userName?: string;
    userPhone?: string;
    barber: BarberData;
    services: ServiceData[];
    date: string;
    startTime: string;
    totalDuration: number;
    status: string;
    totalPrice: number;
    queue_position?: number;
    queue_status?: string;
}

export interface ReservationResponse {
    status: string;
    message: string;
    data: ReservationData;
}

// Guest OTP
export interface GuestOtpRequest {
    name: string;
    phone: string;
}

export interface GuestOtpResponse {
    status: string;
    message: string;
    data?: any;
}

export interface VerifyGuestRequest {
    phone: string;
    code: string;
    barberId: string;
    serviceIds: string[];
    date?: string;
    startTime?: string;
}
