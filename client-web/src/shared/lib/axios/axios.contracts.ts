import { AxiosHeaders, AxiosResponse } from "axios";
import { ZodType } from "zod";
import { AxiosValidationError } from "./axios.error";
import { AxiosResponseType } from "@shared/lib/axios/axios.type.ts";

export class AxiosContracts {
  static responseContract<Data>(schema: ZodType<Data>) {
    return (
      response: AxiosResponse<AxiosResponseType<unknown>>
    ): AxiosResponse<Data> => {
      const validation = schema.safeParse(response.data.data);

      if (validation.error) {
        throw new AxiosValidationError(
          response.config,
          response.request,
          response,
          validation.error.errors
        );
      }

      return { ...response, data: validation.data };
    };
  }

  static requestContract<Data>(schema: ZodType<Data>, data: unknown) {
    const validation = schema.safeParse(data);

    if (validation.error) {
      throw new AxiosValidationError(
        { headers: new AxiosHeaders() },
        undefined,
        undefined,
        validation.error.errors
      );
    }

    return validation.data;
  }
}

export default AxiosContracts;
