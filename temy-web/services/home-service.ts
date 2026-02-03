import { apiClient } from "@/lib/api-client";
import { ENDPOINTS } from "@/lib/api-endpoints";
import { BaseResponse, CategoryData, BarberData } from "@/types/api-types";

export interface BannerData {
    image: string;
}

export const HomeService = {
    getBanners: async (): Promise<BaseResponse<BannerData[]>> => {
        try {
            const response = await apiClient.get<BaseResponse<BannerData[]>>(ENDPOINTS.HOME.BANNERS);
            return response.data;
        } catch (error) {
            console.warn("Failed to fetch banners, returning empty list", error);
            return { status: "success", data: [] };
        }
    },

    getCategories: async (): Promise<BaseResponse<CategoryData[]>> => {
        const response = await apiClient.get<BaseResponse<CategoryData[]>>(ENDPOINTS.HOME.CATEGORY);
        return response.data;
    },

    getBarbers: async (): Promise<BaseResponse<BarberData[]>> => {
        const response = await apiClient.get<BaseResponse<BarberData[]>>(ENDPOINTS.HOME.BARBERS);
        return response.data;
    }
};
