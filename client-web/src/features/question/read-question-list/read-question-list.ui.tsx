import { Fragment, ReactElement, Suspense, useState } from "react";
import SearchQuestion from "../search-question/search-question.ui";
import {
  ReadQuestion,
  ReadQuestionList as ReadQuestionListType,
} from "@entities/question/question.types";
import { useNavigate } from "react-router-dom";
import { CONSTANTS } from "@app/constants/constants";
import { DateTimeUtil } from "@app/utils";
import { LoadingIndicator } from "@widgets/loading-indicator";
import { useSuspenseQuery } from "@tanstack/react-query";
import QuestionQueries from "@entities/question/question.queries";

const ReadQuestionList = (): ReactElement => {
  const [searchTerm, setSearchTerm] = useState<string>("");

  const { data: questionList } = useSuspenseQuery(
    QuestionQueries.readQuestionListQuery(searchTerm)
  );

  return (
    <div className="flex flex-col w-full h-full">
      <SearchQuestion setSearchTerm={setSearchTerm} />
      <div className="flex flex-col flex-1 overflow-y-auto p-5 gap-2">
        <QuestionList questionList={questionList} />
      </div>
    </div>
  );
};

export default ReadQuestionList;

interface IQuestionListProps {
  questionList: ReadQuestionListType;
}

const QuestionList = (props: IQuestionListProps): ReactElement => {
  const { questionList } = props;

  return (
    <Suspense fallback={<LoadingIndicator />}>
      <QuestionListContent questionList={questionList} />
    </Suspense>
  );
};

const QuestionListContent = (props: IQuestionListProps): ReactElement => {
  const { questionList } = props;

  return (
    <div className="flex flex-col w-full h-auto items-center justify-center">
      {questionList.questions.map((question, index) => (
        <Fragment key={index}>
          <QuestionItem question={question} />
          {index < questionList.questions.length - 1 && (
            <div className="w-full h-px bg-neutral-700" />
          )}
        </Fragment>
      ))}
    </div>
  );
};

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
      className="flex flex-col py-12 px-3 w-4/5 gap-4 items-start cursor-pointer"
      onClick={handleItemClick}
    >
      <p className="text-sub2 text-neutral-300 text-start">
        {question.preview}
      </p>
      <div className="flex flex-row w-full justify-between">
        <div className="flex flex-row gap-3">
          <p className="text-sub3 text-neutral-500">
            {DateTimeUtil.convertDateToKoreanString(
              DateTimeUtil.convertStringToDate(question.createdAt)
            )}
          </p>
          <p className="text-sub3 text-neutral-500">|</p>
          <p className="text-sub3 text-neutral-500">
            {question.answerCnt}개의 답변
          </p>
          <p className="text-sub3 text-neutral-500">|</p>
          <p className="text-sub3 text-neutral-500">{question.nickname}</p>
        </div>
        <QuestionBadge status={getStatus(question.answerStatus)} />
      </div>
    </div>
  );
};

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
    <div className={`${getBackgroundColorByStatus(status)} rounded-lg px-1`}>
      <p className="text-sub3 text-white">{getContentByStatus(status)}</p>
    </div>
  );
};
