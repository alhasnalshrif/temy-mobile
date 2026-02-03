import { apiClient } from "@/lib/api-client";
import { ENDPOINTS } from "@/lib/api-endpoints";
import {
    LoginRequest,
    LoginResponse,
    SignupRequest,
    SignupResponse,
    VerifyRequest
} from "@/types/api-types";

export const AuthService = {
    login: async (data: LoginRequest): Promise<LoginResponse> => {
        const response = await apiClient.post<LoginResponse>(ENDPOINTS.AUTH.LOGIN, data);
        return response.data;
    },

    signup: async (data: SignupRequest): Promise<SignupResponse> => {
        const response = await apiClient.post<SignupResponse>(ENDPOINTS.AUTH.SIGNUP, data);
        return response.data;
    },

    verify: async (data: VerifyRequest): Promise<SignupResponse> => {
        const response = await apiClient.post<SignupResponse>(ENDPOINTS.AUTH.VERIFY, data);
        return response.data;
    },
};
