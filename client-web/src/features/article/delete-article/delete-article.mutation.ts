import ArticleService from "@entities/article/article.service";
import { queryClient } from "@shared/lib/react-query";
import {
  DefaultError,
  useMutation,
  UseMutationOptions,
} from "@tanstack/react-query";

export function useDeleteArticleMutation(
  options?: Pick<
    UseMutationOptions<
      Awaited<ReturnType<typeof ArticleService.deleteArticleMutation>>,
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
    mutationKey: ["article", "delete", ...mutationKey],

    mutationFn: (articleId: number) => {
      return ArticleService.deleteArticleMutation(articleId);
    },

    onMutate,
    onSuccess: (data, variables, context) => {
      queryClient.invalidateQueries({ queryKey: ["article", "list"] });
      onSuccess?.(data, variables, context);
    },
    onError,
    onSettled,
  });
}

export default useDeleteArticleMutation;
