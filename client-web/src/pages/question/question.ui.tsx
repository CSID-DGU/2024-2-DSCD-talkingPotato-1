import { ReactElement, useState } from "react";
import { RootLayout } from "@shared/layouts/root-layout";
import { ReadQuestionList } from "@features/question/read-question-list";
import { useQuery } from "@tanstack/react-query";
import { QuestionQueries } from "@entities/question";
import SearchQuestion from "@features/question/search-question/search-question.ui";

const QuestionPage = (): ReactElement => {
  const [searchTerm, setSearchTerm] = useState<string>("");

  const { data: questionList, isLoading: questionListLoading } = useQuery(
    QuestionQueries.readQuestionListQuery(searchTerm)
  );

  return (
    <RootLayout>
      <SearchQuestion setSearchTerm={setSearchTerm} />
      <div className="flex flex-col flex-1 overflow-y-auto p-5 gap-2">
        <ReadQuestionList
          questionList={questionList!}
          questionListLoading={questionListLoading}
        />
      </div>
    </RootLayout>
  );
};

export default QuestionPage;
