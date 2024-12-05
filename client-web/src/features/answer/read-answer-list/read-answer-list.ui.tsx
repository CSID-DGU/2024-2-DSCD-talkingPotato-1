import { ReactElement, Fragment } from "react";
import { AnswerQuery } from "@entities/answer";
import { useSuspenseQuery } from "@tanstack/react-query";
import { ReadAnswer } from "@entities/answer/answer.types";
import { useDeleteAnswerMutation } from "../delete-answer";
import { useConfirmMessage } from "@shared/lib/confirm/use-confirm-message";
import { DateTimeUtil } from "@app/utils";
import Confirm from "@widgets/confirm/confirm.ui";
import useAccountStore from "@shared/store/account";

interface IReadAnswerListProps {
  questionId: number;
}

const ReadAnswerList = (props: IReadAnswerListProps): ReactElement => {
  const { questionId } = props;

  const { data: answerList } = useSuspenseQuery(
    AnswerQuery.readAnswerListQuery(questionId)
  );

  return (
    <div className="flex flex-col w-full h-full">
      {answerList.answers.map((answer, index) => (
        <Fragment key={index}>
          <Answer answer={answer} />
        </Fragment>
      ))}
    </div>
  );
};

export default ReadAnswerList;

interface IAnswerProps {
  answer: ReadAnswer;
}

const Answer = (props: IAnswerProps): ReactElement => {
  const { answer } = props;
  const { aid } = useAccountStore();

  const { mutate: deleteAnswer } = useDeleteAnswerMutation();

  const {
    isConfirmOpen,
    setIsConfirmOpen,
    confirmTitle,
    setConfirmTitle,
    confirmMessage,
    setConfirmMessage,
  } = useConfirmMessage();

  const getAnswerStatus = (nickname: string | null | undefined): string => {
    if (nickname === null || nickname === undefined) {
      return "AI 답변";
    }
    return "전문가 답변";
  };

  const getColorByStatus = (nickname: string | null | undefined): string => {
    if (nickname === null || nickname === undefined) {
      return "blue-500";
    }
    return "primary-500";
  };

  const handleDeleteAnswer = () => {
    setIsConfirmOpen(true);
    setConfirmTitle("해당 답변을 삭제하시겠습니까?");
    setConfirmMessage(
      "해당 답변을 삭제할 경우, 질문한 사용자에게도 사라지게됩니다.\n\n주의해주세요!"
    );
  };

  const handleOnConfirm = () => {
    deleteAnswer(answer.id);
    setIsConfirmOpen(false);
  };

  return (
    <div className="flex flex-col w-full py-4">
      <div className="flex flex-row w-full items-center mb-3">
        <p
          className={`text-sub2 whitespace-nowrap mr-3 text-${getColorByStatus(answer.nickname)}`}
        >
          {getAnswerStatus(answer.nickname)}
        </p>
        <div
          className={`w-full h-[1px] bg-${getColorByStatus(answer.nickname)}`}
        />
      </div>
      <p className={`text-sub2 text-neutral-300`}>{answer.content}</p>
      <div className="flex flex-row w-full items-center justify-between">
        <p className="text-sub3 text-start text-neutral-500 text-start">
          {DateTimeUtil.convertDateToKoreanString(
            DateTimeUtil.convertStringToDate(answer.createdAt)
          )}
        </p>
        {aid === answer.creatorId && (
          <div
            className="flex flex-column rounded-lg hover:bg-neutral-900 p-2 cursor-pointer"
            onClick={handleDeleteAnswer}
          >
            <p className="text-sub3 text-red-500">삭제하기</p>
          </div>
        )}
      </div>
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
