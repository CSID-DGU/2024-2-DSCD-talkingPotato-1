import { Fragment, ReactElement } from "react";
import { ReadQuestionList as ReadQuestionListType } from "@entities/question/question.types";
import QuestionItem from "./question-item.ui";
import QuestionItemSkeleton from "./question-item.skeleton";
import QuestionItemEmpty from "./question-item.empty";

interface IReadQuestionListProps {
  questionList: ReadQuestionListType;
  questionListLoading: boolean;
}

const ReadQuestionList = (props: IReadQuestionListProps): ReactElement => {
  const { questionList, questionListLoading } = props;

  // Skeleton UI
  if (questionListLoading) {
    return (
      <div className="flex flex-col w-full h-auto items-center justify-center ">
        {Array.from({ length: 5 }).map((_, index) => (
          <Fragment key={index}>
            <QuestionItemSkeleton />
            {index < 4 && <hr className="w-4/5 h-[1px] bg-neutral-700 my-10" />}
          </Fragment>
        ))}
      </div>
    );
  }

  // Empty UI
  if (questionList.questions.length === 0) {
    return <QuestionItemEmpty />;
  }

  // Question List UI
  return (
    <div className="flex flex-col w-full h-auto items-center justify-center">
      {questionList.questions.map((question, index) => (
        <Fragment key={index}>
          <QuestionItem question={question} />
          {index < questionList.questions.length - 1 && (
            <hr className="w-4/5 h-[1px] bg-neutral-700 my-10" />
          )}
        </Fragment>
      ))}
    </div>
  );
};

export default ReadQuestionList;
