import { AuthService, authTypes } from "@entities/auth";
import {
  DefaultError,
  UseMutationOptions,
  useMutation,
} from "@tanstack/react-query";

export function useLoginMutation(
  options?: Pick<
    UseMutationOptions<
      Awaited<ReturnType<typeof AuthService.loginMutation>>,
      DefaultError,
      authTypes.LoginDto,
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

    mutationFn: async (loginDto: authTypes.LoginDto) =>
      AuthService.loginMutation({ loginDto }),

    onMutate,
    onSuccess: async (response, variables, context) => {
      await onSuccess?.(response, variables, context);
    },
    onError,
    onSettled,
  });
}

export default useLoginMutation;
