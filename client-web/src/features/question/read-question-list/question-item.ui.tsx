import { ReactElement } from "react";
import { useNavigate } from "react-router-dom";
import { CONSTANTS } from "@app/constants/constants";
import { DateTimeUtil } from "@app/utils";
import { ReadQuestion } from "@entities/question/question.types";

interface IQuestionItemProps {
  question: ReadQuestion;
}

const QuestionItem = (props: IQuestionItemProps): ReactElement => {
  const { question } = props;
  const navigate = useNavigate();

  const handleItemClick = () => {
    navigate(CONSTANTS.ROUTER.QUESTION_DETAIL + question.id);
  };

  const getStatus = (status: string) => {
    switch (status) {
      case "NONE":
        return "NONE";
      case "AI":
        return "AI";
      case "EXPERT":
        return "EXPERT";
      default:
        throw new Error("Invalid status");
    }
  };

  return (
    <div
      className="flex flex-col py-12 px-3 w-2/5 gap-4 items-start cursor-pointer hover:bg-neutral-900 rounded-2xl"
      onClick={handleItemClick}
    >
      <p className="text-sub2 text-neutral-300 text-start">
        {question.preview}
      </p>
      <div className="flex flex-row w-full justify-between items-center">
        <div className="flex flex-row gap-3">
          <p className="text-sub3 text-neutral-500">
            {DateTimeUtil.convertDateToKoreanString(
              DateTimeUtil.convertStringToDate(question.createdAt)
            )}
          </p>
          <p className="text-sub3 text-neutral-500">|</p>
          <p className="text-sub3 text-neutral-500">
            {question.answerCount}개의 답변
          </p>
          <p className="text-sub3 text-neutral-500">|</p>
          <p className="text-sub3 text-neutral-500">{question.nickname}</p>
        </div>
        <QuestionBadge status={getStatus(question.answerStatus)} />
      </div>
    </div>
  );
};

export default QuestionItem;

interface IQuestionBadgeProps {
  status: string;
}

const QuestionBadge = (props: IQuestionBadgeProps): ReactElement => {
  const { status } = props;

  const getBackgroundColorByStatus = (status: string) => {
    switch (status) {
      case "NONE":
        return "bg-neutral-500  ";
      case "AI":
        return "bg-blue-600";
      case "EXPERT":
        return "bg-primary-600";
    }
  };

  const getContentByStatus = (status: string) => {
    switch (status) {
      case "NONE":
        return "답변 대기 중";
      case "AI":
        return "AI 첫 답변";
      case "EXPERT":
        return "전문가 첫 답변";
    }
  };

  return (
    <div
      className={`${getBackgroundColorByStatus(status)} rounded-full px-2 py-1`}
    >
      <p className="text-sub1 text-white">{getContentByStatus(status)}</p>
    </div>
  );
};
