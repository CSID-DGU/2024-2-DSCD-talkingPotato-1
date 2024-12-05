import { AuthService, authTypes } from "@entities/auth";
import {
  DefaultError,
  UseMutationOptions,
  useMutation,
} from "@tanstack/react-query";

type TMutationType = {
  registerDto: authTypes.RegisterDto;
  temporaryToken: string;
};

export function useRegisterMutation(
  options?: Pick<
    UseMutationOptions<
      Awaited<ReturnType<typeof AuthService.register>>,
      DefaultError,
      TMutationType,
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
    mutationFn: async (data: TMutationType) =>
      AuthService.register(data.registerDto, data.temporaryToken),
    onMutate,
    onSuccess,
    onError,
    onSettled,
  });
}
