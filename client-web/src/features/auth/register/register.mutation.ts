import { AuthService, authTypes } from "@entities/auth";
import {
  DefaultError,
  UseMutationOptions,
  useMutation,
} from "@tanstack/react-query";

export function useRegisterMutation(
  options?: Pick<
    UseMutationOptions<
      Awaited<ReturnType<typeof AuthService.register>>,
      DefaultError,
      authTypes.RegisterDto,
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
    mutationFn: async (registerDto: authTypes.RegisterDto) =>
      AuthService.register(registerDto),
    onMutate,
    onSuccess,
    onError,
    onSettled,
  });
}
