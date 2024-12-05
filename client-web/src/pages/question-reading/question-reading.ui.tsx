import { ReactElement } from "react";
import { DefaultLayout } from "@shared/layouts/default-layout";
import { ReadQuestion } from "@features/question";
import { useParams } from "react-router-dom";

const QuestionReadingPage = (): ReactElement => {
  const questionId = useParams().id;

  return (
    <DefaultLayout>
      <ReadQuestion questionId={parseInt(questionId!)} />
    </DefaultLayout>
  );
};

export default QuestionReadingPage;
