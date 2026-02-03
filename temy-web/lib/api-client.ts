import axios from "axios";
import { API_BASE_URL } from "./api-endpoints";

export const apiClient = axios.create({
    baseURL: API_BASE_URL,
    headers: {
        "Content-Type": "application/json",
    },
});

// Add interceptor to include token if available
apiClient.interceptors.request.use((config) => {
    // TODO: Add token logic here (e.g. from localStorage or cookies)
    // const token = ...
    // if (token) {
    //   config.headers.Authorization = `Bearer ${token}`;
    // }
    return config;
});

apiClient.interceptors.response.use(
    (response) => response,
    (error) => {
        // Handle global errors
        return Promise.reject(error);
    }
);
