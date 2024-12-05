import { Fragment, ReactElement } from "react";
import { ReadArticleList } from "@entities/article/article.types";
import {
  ArticleItem,
  ArticleItemSkeleton,
} from "@features/article/read-article-list";

interface IArticleListProps {
  articleList: ReadArticleList;
  articleListLoading: boolean;
}

const ArticleList = (props: IArticleListProps): ReactElement => {
  const { articleList, articleListLoading } = props;

  // Skeleton UI
  if (articleListLoading) {
    return (
      <div className="flex flex-col w-full h-auto items-center justify-center">
        {Array.from({ length: 6 }).map((_, index) => (
          <Fragment key={index}>
            <ArticleItemSkeleton />
            {index < 5 && (
              <hr className="w-[60%] h-[1px] border-neutral-700 my-10" />
            )}
          </Fragment>
        ))}
      </div>
    );
  }

  // Empty UI
  if (articleList.articles.length === 0) {
    return (
      <div className="flex flex-col w-full h-96 items-center justify-center gap-4">
        <div className="flex flex-col items-center justify-center p-8 bg-neutral-900 rounded-2xl">
          <p className="text-h2 text-neutral-300">
            아직 작성된 칼럼이 없습니다
          </p>
          <p className="text-sub1 text-neutral-400">
            첫 번째 칼럼의 작성자가 되어보세요!
          </p>
        </div>
      </div>
    );
  }

  // Article List UI
  return (
    <div className="flex flex-col w-full h-auto items-center justify-center">
      {articleList.articles.map((article, index) => (
        <Fragment key={index}>
          <ArticleItem article={article} />
          {index < articleList.articles.length - 1 && (
            <hr className="w-[60%] h-[1px] border-neutral-700 my-10" />
          )}
        </Fragment>
      ))}
    </div>
  );
};

export default ArticleList;
