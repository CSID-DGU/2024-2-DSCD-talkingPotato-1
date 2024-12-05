import { Fragment, ReactElement } from "react";
import { useSuspenseQuery } from "@tanstack/react-query";
import { CommentQuery } from "@entities/comment";
import { ReadComment } from "@entities/comment/comment.types";
import DateTimeUtil from "@app/utils/date-time-util";

interface IReadCommentProps {
  articleId: number;
}

const ReadCommentList = (props: IReadCommentProps): ReactElement => {
  const { articleId } = props;

  const { data: commentList } = useSuspenseQuery(
    CommentQuery.readCommentListQuery(articleId)
  );

  return (
    <div className="flex flex-col w-full mt-10">
      {commentList.comments.length > 0 && (
        <h1 className="text-h2 text-black">{`${commentList.comments.length}개의 댓글`}</h1>
      )}
      {commentList.comments.map((comment: ReadComment, index: number) => (
        <Fragment key={index}>
          <Comment comment={comment} />
          {index !== commentList.comments.length - 1 && (
            <hr className="w-full h-[1px] bg-neutral-700 my-5" />
          )}
        </Fragment>
      ))}
    </div>
  );
};

export default ReadCommentList;

interface ICommentProps {
  comment: ReadComment;
}

const Comment = (props: ICommentProps): ReactElement => {
  const { comment } = props;

  return (
    <div className="flex flex-col w-full py-3">
      <div className="flex flex-row justify-between items-baseline mb-3">
        <h3 className="text-h3 text-black text-start">{comment.nickname}</h3>
      </div>
      <p className="text-sub2 text-neutral-300 text-start mb-3">
        {comment.content}
      </p>
      <p className="text-sub3 text-neutral-500 text-start">
        {DateTimeUtil.convertDateToKoreanString(
          DateTimeUtil.convertStringToDate(comment.createdAt)
        )}
      </p>
    </div>
  );
};
