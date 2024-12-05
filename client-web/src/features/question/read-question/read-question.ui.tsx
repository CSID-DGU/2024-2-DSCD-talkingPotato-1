import { ReactElement, Suspense } from "react";

// Icons
import BackIcon from "@shared/assets/icons/Back.svg?react";
import { ReadAnswerList } from "@features/answer/read-answer-list";
import { CreateAnswer } from "@features/answer/create-answer";
import { ReadQuestionDetail } from "@entities/question/question.types";
import { useSuspenseQuery } from "@tanstack/react-query";
import { QuestionQueries } from "@entities/question";
import { DateTimeUtil } from "@app/utils";
import { useNavigate } from "react-router-dom";
import { CONSTANTS } from "@app/constants/constants";

interface IReadQuestionProps {
  questionId: number;
}

const ReadQuestion = (props: IReadQuestionProps): ReactElement => {
  const { questionId } = props;

  return (
    <div className="flex flex-col w-full h-full p-5">
      <ReadQuestionContent questionId={questionId} />
    </div>
  );
};

export default ReadQuestion;

const ReadQuestionContent = (props: IReadQuestionProps): ReactElement => {
  const { questionId } = props;

  return (
    <Suspense fallback={<ReadQuestionContentSkeleton />}>
      <ReadQuestionContentInner questionId={questionId} />
    </Suspense>
  );
};

const ReadQuestionContentInner = (props: IReadQuestionProps): ReactElement => {
  const { questionId } = props;

  const { data: questionDetail } = useSuspenseQuery(
    QuestionQueries.readQuestionDetailQuery(questionId)
  );

  return (
    <div className="flex flex-col w-full h-auto items-center justify-center">
      <TopBar />
      <div className="flex flex-row w-full h-full gap-10">
        <div className="flex flex-col w-full h-full py-10">
          <Question question={questionDetail} />
          <ReadAnswerList questionId={questionId} />
        </div>
        <CreateAnswer questionId={questionId} />
      </div>
    </div>
  );
};

const ReadQuestionContentSkeleton = (): ReactElement => {
  return (
    <div className="flex flex-col w-full h-auto items-center justify-center">
      <TopBar />
      <div className="flex flex-row w-full h-full gap-10">
        <div className="flex flex-col w-full h-full py-10">
          <div className="w-full h-40 bg-neutral-800 animate-pulse rounded-lg" />
        </div>
      </div>
    </div>
  );
};

const TopBar = (): ReactElement => {
  const navigate = useNavigate();

  const handleBack = () => {
    navigate(CONSTANTS.ROUTER.QUESTION);
  };

  return (
    <div className="flex flex-row w-full border-b border-neutral-700">
      <div
        className="flex flex-row items-center justify-center gap-2 p-2 hover:bg-neutral-900 rounded-lg cursor-pointer"
        onClick={handleBack}
      >
        <BackIcon className="w-6 h-6 text-neutral-500" />
        <h1 className="text-h1 text-neutral-500 text-start">뒤로가기</h1>
      </div>
    </div>
  );
};

interface IQuestionProps {
  question: ReadQuestionDetail;
}

const Question = (props: IQuestionProps): ReactElement => {
  const { question } = props;

  return (
    <div className="flex flex-col w-full py-5">
      <h3 className="text-h3 text-start text-black mb-5">
        {`이 질문에 ${question.answerCount}개의 답변이 있어요.`}
      </h3>
      <p className="text-sub2 text-black text-start mb-5">{question.content}</p>
      <p className="text-sub3 text-neutral-500 text-start">
        {`${DateTimeUtil.convertDateToKoreanString(
          DateTimeUtil.convertStringToDate(question.createdAt)
        )} | ${question.nickname}`}
      </p>
    </div>
  );
};
