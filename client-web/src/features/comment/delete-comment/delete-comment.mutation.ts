import { useMutation, UseMutationOptions } from "@tanstack/react-query";
import { CommentService } from "@entities/comment";
import { queryClient } from "@shared/lib/react-query";

export function useDeleteCommentMutation(
  options?: Pick<
    UseMutationOptions<
      Awaited<ReturnType<typeof CommentService.deleteCommentMutation>>,
      Error,
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
    mutationKey: ["comment", "delete", ...mutationKey],

    mutationFn: (commentId: number) => {
      return CommentService.deleteCommentMutation(commentId);
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

export default useDeleteCommentMutation;
