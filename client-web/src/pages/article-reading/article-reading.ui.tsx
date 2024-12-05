import { ReactElement } from "react";
import { DefaultLayout } from "@shared/layouts/default-layout";
import { useParams } from "react-router-dom";
import { ReadArticle } from "@features/article/read-article";

const ArticleReadingPage = (): ReactElement => {
  const articleId = parseInt(useParams().id!);

  return (
    <DefaultLayout>
      <ReadArticle articleId={articleId} />
    </DefaultLayout>
  );
};

export default ArticleReadingPage;
