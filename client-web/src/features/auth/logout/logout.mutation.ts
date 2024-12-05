import { AuthService } from "@entities/auth/auth.service";
import {
  DefaultError,
  UseMutationOptions,
  useMutation,
} from "@tanstack/react-query";

export function useLogoutMutation(
  options?: Pick<
    UseMutationOptions<
      Awaited<ReturnType<typeof AuthService.logoutMutation>>,
      DefaultError,
      void,
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
    mutationFn: async () => AuthService.logoutMutation(),
    onMutate,
    onSuccess: async (response, variables, context) => {
      await onSuccess?.(response, variables, context);
    },
    onError,
    onSettled,
  });
}
