import { Fragment, ReactElement, Suspense } from "react";
import { LoadingIndicator } from "@widgets/loading-indicator";
import { ReadArticle, ReadArticleList } from "@entities/article/article.types";
import { useNavigate } from "react-router-dom";
import { CONSTANTS } from "@app/constants/constants";
import { DateTimeUtil } from "@app/utils";

/**
 * Public Component
 */
interface IArticleListProps {
  articleList: ReadArticleList;
}

const ArticleList = (props: IArticleListProps): ReactElement => {
  const { articleList } = props;

  return (
    <Suspense fallback={<LoadingIndicator />}>
      <ArticleListContent articleList={articleList} />
    </Suspense>
  );
};

export default ArticleList;

/**
 * Private Component
 */
const ArticleListContent = (props: IArticleListProps): ReactElement => {
  const { articleList } = props;

  return (
    <div className="flex flex-col w-full h-auto items-center justify-center">
      {articleList.articles.map((article, index) => (
        <Fragment key={index}>
          <ArticleItem article={article} />
          {index < articleList.articles.length - 1 && (
            <hr className="w-[60%] border-none border-t border-neutral-700" />
          )}
        </Fragment>
      ))}
    </div>
  );
};

interface IArticleItemProps {
  article: ReadArticle;
}

const ArticleItem = (props: IArticleItemProps): ReactElement => {
  const article = props.article;
  const navigate = useNavigate();

  const handleItemClick = () => {
    navigate(CONSTANTS.ROUTER.ARTICLE_READ + `${article.id}`);
  };

  return (
    <div
      className="flex flex-col w-3/5 py-12 px-3 cursor-pointer"
      onClick={handleItemClick}
    >
      <h1 className="text-h1 text-black text-start">{article.title}</h1>
      <p className="text-sub2 text-neutral-300 text-start">{article.preview}</p>
      <div className="flex flex-row gap-2">
        {article.tags.map((tag, index) => (
          <ItemTag tag={tag} isFirst={index === 0} />
        ))}
      </div>
      <div className="flex flex-row gap-2">
        <p className="text-sub3 text-neutral-500">
          {DateTimeUtil.convertDateToKoreanString(
            DateTimeUtil.convertStringToDate(article.createdAt!)
          )}
        </p>
        <p className="text-sub3 text-neutral-500">|</p>
        <p className="text-sub3 text-neutral-500">
          {`${article.commentCnt}개의 댓글`}
        </p>
        <p className="text-sub3 text-neutral-500">|</p>
        <p className="text-sub3 text-neutral-500">{article.nickname}</p>
      </div>
    </div>
  );
};

interface IItemTagProps {
  tag: string;
  isFirst: boolean;
}

const ItemTag = (props: IItemTagProps): ReactElement => {
  const { tag, isFirst } = props;

  return (
    <div
      className={`flex flex-col items-center justify-center py-5 h-6 bg-secondary-900 rounded-lg ${
        isFirst ? "ml-0" : "ml-2"
      }`}
    >
      <p className="text-sub2 text-primary-500 text-center">{tag}</p>
    </div>
  );
};
