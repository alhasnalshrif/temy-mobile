import { apiClient } from "@/lib/api-client";
import { ENDPOINTS } from "@/lib/api-endpoints";
import {
    GuestOtpRequest,
    GuestOtpResponse,
    VerifyGuestRequest,
    ReservationResponse,
    JoinQueueRequest
} from "@/types/api-types";

export const GuestService = {
    requestVerification: async (data: GuestOtpRequest): Promise<GuestOtpResponse> => {
        const response = await apiClient.post<GuestOtpResponse>(ENDPOINTS.BOOKING.GUEST_REQUEST_VERIFICATION, data);
        return response.data;
    },

    verifyAndCreateReservation: async (data: VerifyGuestRequest): Promise<ReservationResponse> => {
        const response = await apiClient.post<ReservationResponse>(ENDPOINTS.BOOKING.GUEST_VERIFY_AND_CREATE, data);
        return response.data;
    },

    joinQueue: async (data: JoinQueueRequest): Promise<ReservationResponse> => {
        const response = await apiClient.post<ReservationResponse>(ENDPOINTS.QUEUE.GUEST_JOIN, data);
        return response.data;
    }
};
