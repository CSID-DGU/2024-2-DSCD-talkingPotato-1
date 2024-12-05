import ArticleService from "@entities/article/article.service";
import { CreateArticle } from "@entities/article/article.types";
import { queryClient } from "@shared/lib/react-query";
import {
  DefaultError,
  useMutation,
  UseMutationOptions,
} from "@tanstack/react-query";

export function useCreateArticleMutation(
  options?: Pick<
    UseMutationOptions<
      Awaited<ReturnType<typeof ArticleService.createArticleMutation>>,
      DefaultError,
      CreateArticle,
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
    mutationKey: ["article", "create", ...mutationKey],

    mutationFn: async (article: CreateArticle) => {
      return ArticleService.createArticleMutation(article);
    },

    onMutate,
    onSuccess: async (response, variables, context) => {
      queryClient.invalidateQueries({ queryKey: ["article", "list"] });
      onSuccess?.(response, variables, context);
    },
    onError,
    onSettled,
  });
}

export default useCreateArticleMutation;
