import { CONSTANTS } from "@app/constants/constants";
import { Fragment, ReactElement, Suspense } from "react";
import { useNavigate } from "react-router-dom";
import { useDeleteArticleMutation } from "../delete-article";
import useConfirmMessage from "@shared/lib/confirm/use-confirm-message";

import { Confirm } from "@widgets/confirm";
import { useSuspenseQuery } from "@tanstack/react-query";
import { ArticleQueries } from "@entities/article";
import { DateTimeUtil } from "@app/utils";
import { MarkdownViewer } from "@widgets/markdown/markdown-viewer";
import { ReadCommentList } from "@features/comment/read-comment";

// Icons
import BackIcon from "@shared/assets/icons/back.svg?react";
import WritingIcon from "@shared/assets/icons/Writing.svg?react";
import useAccountStore from "@shared/store/account";
import { ReadArticleDetail } from "@entities/article/article.types";
import { LoadingIndicator } from "@widgets/loading-indicator";

interface IReadArticleProps {
  articleId: number;
}

const ReadArticle = (props: IReadArticleProps): ReactElement => {
  const { articleId } = props;

  return (
    <Suspense fallback={<LoadingIndicator />}>
      <ReadArticleContent articleId={articleId} />
    </Suspense>
  );
};

const ReadArticleContent = ({
  articleId,
}: {
  articleId: number;
}): ReactElement => {
  const { data: article } = useSuspenseQuery(
    ArticleQueries.readArticleDetailQuery(articleId)
  );

  return (
    <div className="flex flex-col w-full h-screen items-center">
      <TopBar articleId={articleId} creatorId={article.creatorId} />
      <div className="flex-1 overflow-y-auto flex flex-col w-1/2 p-10 gap-2 items-start">
        <ArticleDetail article={article} />
      </div>
    </div>
  );
};

export default ReadArticle;

interface ITopBarProps {
  articleId: number;
  creatorId: string;
}

const TopBar = (props: ITopBarProps): ReactElement => {
  const { articleId, creatorId } = props;
  const navigate = useNavigate();
  const { aid } = useAccountStore();

  const {
    confirmMessage,
    confirmTitle,
    isConfirmOpen,
    setIsConfirmOpen,
    setConfirmMessage,
    setConfirmTitle,
  } = useConfirmMessage();

  const handleBack = () => {
    navigate(CONSTANTS.ROUTER.ARTICLE);
  };

  const { mutate: deleteArticle } = useDeleteArticleMutation();

  const handleDelete = () => {
    setConfirmTitle("해당 칼럼을 삭제 하시겠습니까?");
    setConfirmMessage(
      "칼럼 삭제 시 댓글을 포함한 모든 내용이 사라지며 복구가 불가능합니다.\n\n주의해주세요."
    );
    setIsConfirmOpen(true);
  };

  const handleOnConfirm = () => {
    setIsConfirmOpen(false);
    deleteArticle(articleId);
    navigate(CONSTANTS.ROUTER.ARTICLE);
  };

  return (
    <div className="flex flex-row w-full border-b border-neutral-700 items-center justify-between pt-2 px-4">
      <div
        className="flex flex-row items-center gap-3 cursor-pointer hover:bg-neutral-900 rounded-lg p-2"
        onClick={handleBack}
      >
        <BackIcon className="w-6 h-6 text-neutral-500" />
        <h1 className="text-h1 text-neutral-500 text-start">뒤로가기</h1>
      </div>
      {aid === creatorId && (
        <div
          className="flex flex-end items-center cursor-pointer hover:bg-neutral-900 rounded-lg p-2"
          onClick={handleDelete}
        >
          <h1 className="text-h1 text-red-500 text-center cursor-pointer">
            삭제하기
          </h1>
        </div>
      )}
      {isConfirmOpen && (
        <Confirm
          title={confirmTitle}
          content={confirmMessage}
          onConfirm={handleOnConfirm}
          onCancel={() => setIsConfirmOpen(false)}
        />
      )}
    </div>
  );
};

interface IArticleDetailProps {
  article: ReadArticleDetail;
}

const ArticleDetail = (props: IArticleDetailProps): ReactElement => {
  const { article } = props;

  return (
    <div className="flex flex-col w-full h-full">
      <div className="flex flex-col w-full border-b border-neutral-700">
        <h1 className="text-h0 text-black text-start mb-2">{article.title}</h1>
        <div className="flex flex-row gap-3 mb-2">
          {article.tags.length > 0 ? (
            article.tags.map((tag: string, index: number) => (
              <Fragment key={index}>
                <Tag tag={tag} isFirst={index === 0} />
              </Fragment>
            ))
          ) : (
            <div className="h-6" />
          )}
        </div>
        <div className="flex flex-row w-full">
          <div className="flex flex-row w-full gap-3 flex-end">
            <p className="text-sub3 text-neutral-500">
              {DateTimeUtil.convertDateToKoreanString(
                DateTimeUtil.convertStringToDate(article.createdAt)
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
      </div>
      <hr className="w-full h-[1px] bg-neutral-700 my-10" />
      <MarkdownViewer markdownValue={article.content} />
      <ReadCommentList articleId={article.id} />
      <UpdateButton articleId={article.id} />
    </div>
  );
};

interface ITagProps {
  tag: string;
  isFirst: boolean;
}

const Tag = (props: ITagProps): ReactElement => {
  const { tag, isFirst } = props;

  return (
    <div
      className={`flex flex-col items-center justify-center px-5 h-6 bg-secondary-900 rounded-full ${isFirst ? "ml-0" : "ml-3"}`}
    >
      <p className="text-sub2 text-primary-500 text-center">{tag}</p>
    </div>
  );
};

interface IUpdateButtonProps {
  articleId: number;
}

const UpdateButton = (props: IUpdateButtonProps): ReactElement => {
  const { articleId } = props;

  const navigate = useNavigate();

  const handleUpdateButtonClick = () => {
    navigate(CONSTANTS.ROUTER.ARTICLE_EDIT + articleId);
  };

  return (
    <button
      className="flex py-4 px-5 rounded-full bg-primary-500 hover:bg-primary-400 gap-3 items-center fixed right-10 bottom-10 cursor-pointer"
      onClick={handleUpdateButtonClick}
    >
      <h1 className="text-h1 text-white">칼럼 수정하기</h1>
      <WritingIcon className="w-6 h-6 text-white" />
    </button>
  );
};
