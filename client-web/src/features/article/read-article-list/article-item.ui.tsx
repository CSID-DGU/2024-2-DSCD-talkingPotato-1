import { CONSTANTS } from "@app/constants/constants";
import { DateTimeUtil } from "@app/utils";
import { ReadArticle } from "@entities/article/article.types";
import { Fragment, ReactElement } from "react";
import { useNavigate } from "react-router-dom";

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
      className="flex flex-col w-3/5 py-12 px-3 gap-3 cursor-pointer hover:bg-neutral-900 rounded-2xl"
      onClick={handleItemClick}
    >
      <h1 className="text-h1 text-black text-start">{article.title}</h1>
      <p className="text-sub2 text-neutral-300 text-start">{article.preview}</p>
      <div className="flex flex-row gap-2">
        {article.tags.map((tag, index) => (
          <Fragment key={index}>
            <ItemTag tag={tag} isFirst={index === 0} />
          </Fragment>
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

export default ArticleItem;

interface IItemTagProps {
  tag: string;
  isFirst: boolean;
}

const ItemTag = (props: IItemTagProps): ReactElement => {
  const { tag, isFirst } = props;

  return (
    <div
      className={`flex flex-col items-center justify-center px-3 py-2 h-6 bg-secondary-900 rounded-full ${
        isFirst ? "ml-0" : "ml-2"
      }`}
    >
      <p className="text-sub2 text-primary-500 text-center">{tag}</p>
    </div>
  );
};
