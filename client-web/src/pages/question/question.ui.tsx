import { ReactElement } from "react";
import { RootLayout } from "@shared/layouts/root-layout";
import { ReadQuestionList } from "@features/question/read-question-list";

const QuestionPage = (): ReactElement => {
  return (
    <RootLayout>
      <ReadQuestionList />
    </RootLayout>
  );
};

export default QuestionPage;
