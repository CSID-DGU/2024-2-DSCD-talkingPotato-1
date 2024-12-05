import axios from "axios";
import { Cookies } from "react-cookie";
import AxiosConvertor from "@shared/lib/axios/axios.convertor.ts";

const cookies = new Cookies();
const accessToken = cookies.get("access_token");

export const httpClient = axios.create({
  baseURL: import.meta.env.VITE_APP_SERVER_URL,
  withCredentials: true,
  responseType: "json",
  headers: {
    "Content-Type": "application/json",
    Authorization: `Bearer ${accessToken}`,
  },
});

httpClient.interceptors.request.use(
  (config) => {
    const accessToken = cookies.get("access_token");

    if (accessToken) {
      config.headers["Authorization"] = `Bearer ${accessToken}`;
      config.withCredentials = true;
    }

    if (config.data) {
      config.data = AxiosConvertor.convertCamelToSnake(config.data);
    }

    if (config.params) {
      config.params = AxiosConvertor.convertCamelToSnake(config.params);
    }

    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
);

httpClient.interceptors.response.use(
  (response) => {
    response.data = AxiosConvertor.convertSnakeToCamel(response.data);
    return response;
  },
  async (error) => {
    if (
      error.response &&
      error.response.status === 401 &&
      error.response.data.error.code === "40101"
    ) {
      const originalRequest = error.config;
      if (!originalRequest._retry) {
        originalRequest._retry = true;

        try {
          const response = await axios.post(
            `${import.meta.env.VITE_APP_SERVER_URL}/auth/reissue/token`,
            {},
            {
              withCredentials: true,
            }
          );

          if (response.status === 200) {
            const accessToken = cookies.get("access_token");
            originalRequest.headers["Authorization"] = `Bearer ${accessToken}`;
            return httpClient(originalRequest);
          }
        } catch (refreshError) {
          return Promise.reject(refreshError);
        }
      }
    }

    return Promise.reject(error);
  }
);

export default httpClient;
