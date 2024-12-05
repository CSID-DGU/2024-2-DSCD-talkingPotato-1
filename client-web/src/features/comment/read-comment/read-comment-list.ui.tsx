import { Fragment, ReactElement } from "react";
import { useDeleteCommentMutation } from "../delete-comment";
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
    <div>
      {commentList.comments.map((comment: ReadComment, index: number) => (
        <Fragment key={index}>
          <div className="w-full border-b border-neutral-700" />
          <Comment comment={comment} />
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

  const { mutate: deleteComment } = useDeleteCommentMutation();

  const handleDeleteCommentButtonClick = () => {
    deleteComment(comment.id);
  };

  return (
    <div className="flex flex-col w-full py-3">
      <div className="flex flex-row justify-between items-baseline mb-3">
        <h3 className="text-h3 text-black text-start">{comment.nickname}</h3>
        <div
          className="flex flex-col p-2 hover:bg-neutral-700 rounded-lg cursor-pointer"
          onClick={handleDeleteCommentButtonClick}
        >
          <p className="text-sub2 text-red-500">삭제</p>
        </div>
      </div>
      <p className="text-sub2 text-neutral-700 text-start mb-3">
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
