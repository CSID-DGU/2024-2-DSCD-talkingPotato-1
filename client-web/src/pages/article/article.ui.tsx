import { ReactElement, startTransition, useState } from "react";
import { useNavigate } from "react-router-dom";
import { useSuspenseQuery } from "@tanstack/react-query";
import { RootLayout } from "@shared/layouts/root-layout";
import { CONSTANTS } from "@app/constants/constants.ts";
import ArticleQueries from "@entities/article/article.queries.ts";
import { SearchArticle } from "@features/article/search-article";
import { ArticleList } from "@features/article/read-article-list";

// Icons
import WritingIcon from "@shared/assets/icons/Writing.svg?react";

const ArticlePage = (): ReactElement => {
  const [searchTerm, setSearchTerm] = useState("");

  const { data: articleList } = useSuspenseQuery(
    ArticleQueries.readArticleListQuery(searchTerm)
  );

  const handleSetSearchTerm = (searchTerm: string) => {
    startTransition(() => {
      setSearchTerm(searchTerm);
    });
  };

  return (
    <RootLayout>
      <div className="flex flex-col w-full h-full">
        <SearchArticle setSearchTerm={handleSetSearchTerm} />
        <div className="flex-1 overflow-y-auto flex flex-col p-5 gap-2.5">
          <ArticleList articleList={articleList} />
          <CreateButton />
        </div>
      </div>
    </RootLayout>
  );
};

export default ArticlePage;

const CreateButton = (): ReactElement => {
  const navigate = useNavigate();

  const handleArticleWrite = () => {
    navigate(CONSTANTS.ROUTER.ARTICLE_WRITE);
  };

  return (
    <button
      className="fixed right-10 bottom-10 items-center py-4 px-5 bg-primary-500 rounded-xl cursor-pointer gap-2"
      onClick={handleArticleWrite}
    >
      <h1 className="text-h3 text-white">칼럼 작성하기</h1>
      <WritingIcon className="w-6 h-6 text-white" />
    </button>
  );
};
