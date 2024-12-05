import { AuthService, authTypes } from "@entities/auth";
import {
  DefaultError,
  UseMutationOptions,
  useMutation,
} from "@tanstack/react-query";

export function useValidateAuthenticationCodeMutation(
  options?: Pick<
    UseMutationOptions<
      Awaited<
        ReturnType<typeof AuthService.validateAuthenticationCodeMutation>
      >,
      DefaultError,
      authTypes.ValidateAuthenticationCodeDto,
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
    mutationFn: async (
      validateAuthenticationCodeDto: authTypes.ValidateAuthenticationCodeDto
    ) =>
      AuthService.validateAuthenticationCodeMutation(
        validateAuthenticationCodeDto
      ),
    onMutate,
    onSuccess,
    onError,
    onSettled,
  });
}
