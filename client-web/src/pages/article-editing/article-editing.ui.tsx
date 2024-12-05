import { ReactElement } from "react";
import { useParams } from "react-router-dom";
import { DefaultLayout } from "@shared/layouts/default-layout";
import { UpdateArticle } from "@features/article/update-article";

const ArticleEditingPage = (): ReactElement => {
  const articleId = useParams().id;

  return (
    <DefaultLayout>
      <UpdateArticle articleId={parseInt(articleId!)} />
    </DefaultLayout>
  );
};

export default ArticleEditingPage;
