import { useMutation, UseMutationOptions } from "@tanstack/react-query";
import { CreateCommentDto } from "@entities/comment/comment.contracts.ts";
import { CommentService } from "@entities/comment";
import { queryClient } from "@shared/lib/react-query";

type TMutationType = {
  columnId: number;
  comment: CreateCommentDto;
};

export function useCreateCommentMutation(
  options?: Pick<
    UseMutationOptions<
      Awaited<ReturnType<typeof CommentService.createCommentMutation>>,
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
    mutationKey: ["comment", "create", ...mutationKey],

    mutationFn: ({ columnId, comment }: TMutationType) => {
      return CommentService.createCommentMutation(columnId, comment);
    },

    onMutate,
    onSuccess: (data, variables, context) => {
      queryClient.invalidateQueries({
        queryKey: ["comment", "list", variables],
      });
      onSuccess?.(data, variables, context);
    },
    onError,
    onSettled,
  });
}

export default useCreateCommentMutation;
