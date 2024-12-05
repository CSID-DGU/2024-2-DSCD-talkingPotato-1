import { ReactElement, useState } from "react";
import useCreateCommentMutation from "./create-comment.mutation";

interface ICreateCommentProps {
  articleId: number;
  className?: string;
}

const CreateComment = (props: ICreateCommentProps): ReactElement => {
  const { articleId, className } = props;

  const [content, setContent] = useState<string>("");
  const { mutate: createComment } = useCreateCommentMutation();

  const handleContentChange = (e: React.ChangeEvent<HTMLTextAreaElement>) => {
    setContent(e.target.value);
  };

  const handleCreateCommentButtonClick = () => {
    createComment({
      columnId: articleId,
      comment: {
        content: content,
      },
    });

    setContent("");
  };

  return (
    <div className={`flex flex-col w-full ${className}`}>
      <textarea
        className="p-4 h-30 text-sub2 text-neutral-700 border border-neutral-700 rounded-lg resize-none mb-5"
        placeholder="댓글을 작성하세요."
        value={content}
        onChange={handleContentChange}
      />
      <div className="flex flex-row w-full justify-end">
        <button
          className="w-24 h-12 rounded-lg bg-secondary-500"
          onClick={handleCreateCommentButtonClick}
        >
          <h4 className="text-sub2 text-white">댓글 작성</h4>
        </button>
      </div>
    </div>
  );
};

export default CreateComment;
