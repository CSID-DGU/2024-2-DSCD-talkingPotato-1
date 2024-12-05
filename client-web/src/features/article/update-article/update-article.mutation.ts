import ArticleService from "@entities/article/article.service";
import { CreateArticle } from "@entities/article/article.types";
import {
  DefaultError,
  useMutation,
  UseMutationOptions,
} from "@tanstack/react-query";

type TMutationType = {
  articleId: number;
  article: CreateArticle;
};

export function useUpdateArticleMutation(
  options?: Pick<
    UseMutationOptions<
      Awaited<ReturnType<typeof ArticleService.updateArticleMutation>>,
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
  } = options || {};

  return useMutation({
    mutationKey: ["article", "update", ...mutationKey],

    mutationFn: ({ articleId, article }: TMutationType) => {
      return ArticleService.updateArticleMutation(articleId, article);
    },

    onMutate,
    onSuccess,
    onError,
    onSettled,
  });
}

export default useUpdateArticleMutation;
