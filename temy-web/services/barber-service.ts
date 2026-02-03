import { apiClient } from "@/lib/api-client";
import { ENDPOINTS } from "@/lib/api-endpoints";
import { BarberResponse, CategoryResponse, ServiceResponse, BarberDetailResponse } from "@/types/api-types";

export const BarberService = {
    getBarber: async (id: string): Promise<BarberDetailResponse> => {
        const response = await apiClient.get<BarberDetailResponse>(ENDPOINTS.BARBER.DETAIL(id));
        return response.data;
    },

    getServicesByCategory: async (categoryId: string): Promise<ServiceResponse> => {
        const response = await apiClient.get<ServiceResponse>(ENDPOINTS.CATEGORY.SERVICES(categoryId));
        return response.data;
    }
};
