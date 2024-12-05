import { useMutation, UseMutationOptions } from "@tanstack/react-query";
import { AnswerService } from "@entities/answer";
import { CreateAnswerDto } from "@entities/answer/answer.contracts.ts";
import { queryClient } from "@shared/lib/react-query";

type TMutationType = {
  questionId: number;
  answer: CreateAnswerDto;
};

export function useCreateAnswerMutation(
  options?: Pick<
    UseMutationOptions<
      Awaited<ReturnType<typeof AnswerService.createAnswerMutation>>,
      Error,
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
  } = options || {};

  return useMutation({
    mutationKey: ["answer", "create", ...mutationKey],

    mutationFn: ({ questionId, answer }: TMutationType) => {
      return AnswerService.createAnswerMutation(questionId, answer);
    },

    onMutate,
    onSuccess: (data, variables, context) => {
      queryClient.invalidateQueries({
        queryKey: ["answer", "list", variables.questionId],
      });
      onSuccess?.(data, variables, context);
    },
    onError,
    onSettled,
  });
}

export default useCreateAnswerMutation;
