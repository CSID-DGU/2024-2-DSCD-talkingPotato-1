import { AuthService, authTypes } from "@entities/auth";
import {
  DefaultError,
  UseMutationOptions,
  useMutation,
} from "@tanstack/react-query";

export function useValidateEmailMutation(
  options?: Pick<
    UseMutationOptions<
      Awaited<ReturnType<typeof AuthService.validateEmailMutation>>,
      DefaultError,
      authTypes.ValidateEmailDto,
      unknown
    >,
    "mutationKey" | "onMutate" | "onSuccess" | "onError" | "onSettled"
  >
) {
  const {
    mutationKey = [],
    onMutate,
    onSuccess,
    onError,
    onSettled,
  } = options ?? {};

  return useMutation({
    mutationKey: ["auth", ...mutationKey],

    mutationFn: async (validateEmailDto: authTypes.ValidateEmailDto) =>
      AuthService.validateEmailMutation(validateEmailDto),

    onMutate,
    onSuccess,
    onError,
    onSettled,
  });
}
