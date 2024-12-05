import {
  DefaultError,
  useMutation,
  UseMutationOptions,
} from "@tanstack/react-query";
import { AnswerService } from "@entities/answer";
import { queryClient } from "@shared/lib/react-query";

export function useDeleteAnswerMutation(
  options?: Pick<
    UseMutationOptions<
      Awaited<ReturnType<typeof AnswerService.deleteAnswerMutation>>,
      DefaultError,
      number,
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
  } = options || {};

  return useMutation({
    mutationKey: ["answer", "delete", ...mutationKey],

    mutationFn: (answerId: number) => {
      return AnswerService.deleteAnswerMutation(answerId);
    },

    onMutate,
    onSuccess: (data, variables, context) => {
      queryClient.invalidateQueries({
        queryKey: ["answer", "list"],
      });
      onSuccess?.(data, variables, context);
    },
    onError,
    onSettled,
  });
}

export default useDeleteAnswerMutation;
