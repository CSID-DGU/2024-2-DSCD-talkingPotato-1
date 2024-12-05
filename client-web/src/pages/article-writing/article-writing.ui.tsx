import { ReactElement } from "react";
import { DefaultLayout } from "@shared/layouts/default-layout";
import { CreateArticle } from "@features/article/create-article";

const ArticleWritingPage = (): ReactElement => {
  return (
    <DefaultLayout>
      <CreateArticle />
    </DefaultLayout>
  );
};

export default ArticleWritingPage;
