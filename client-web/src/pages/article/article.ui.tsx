import { ReactElement, useState } from "react";
import { useNavigate } from "react-router-dom";
import { RootLayout } from "@shared/layouts/root-layout";
import { CONSTANTS } from "@app/constants/constants.ts";
import { useQuery } from "@tanstack/react-query";
import ArticleQueries from "@entities/article/article.queries.ts";
import { SearchArticle } from "@features/article/search-article";
import { ArticleList } from "@features/article/read-article-list";

// Icons
import WritingIcon from "@shared/assets/icons/Writing.svg?react";

const ArticlePage = (): ReactElement => {
  const [searchTerm, setSearchTerm] = useState("");

  const { data: articleList, isLoading: articleListLoading } = useQuery(
    ArticleQueries.readArticleListQuery(searchTerm)
  );

  const handleSetSearchTerm = (searchTerm: string) => {
    setSearchTerm(searchTerm);
  };

  return (
    <RootLayout>
      <div className="flex flex-col w-full h-full">
        <SearchArticle setSearchTerm={handleSetSearchTerm} />
        <div className="flex-1 overflow-y-auto flex flex-col p-5 gap-2.5">
          <ArticleList
            articleList={articleList!}
            articleListLoading={articleListLoading}
          />
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
      className="fixed flex flex-row right-10 bottom-10 items-center py-5 px-5 bg-primary-500 rounded-full cursor-pointer gap-2 hover:bg-primary-400"
      onClick={handleArticleWrite}
    >
      <h1 className="text-h1 text-white">칼럼 작성하기</h1>
      <WritingIcon className="w-6 h-6 text-white" />
    </button>
  );
};
