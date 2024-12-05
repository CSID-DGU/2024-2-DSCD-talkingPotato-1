interface AxiosResponseType<T> {
    success: boolean;
    data?: T;
    error?: string;
}

export type {AxiosResponseType};