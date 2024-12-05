import { ReactElement, useState } from "react";

interface ISearchQuestionProps {
  setSearchTerm: (searchTerm: string) => void;
}

const SearchQuestion = (props: ISearchQuestionProps): ReactElement => {
  const { setSearchTerm } = props;

  const [queryTerm, setQueryTerm] = useState<string>("");

  const handleChangeQueryTerm = (e: React.ChangeEvent<HTMLInputElement>) => {
    setQueryTerm(e.target.value);
  };

  const handleSearchQuestion = () => {
    setSearchTerm(queryTerm);

    setQueryTerm("");
  };

  return (
    <div className="flex flex-row w-full justify-between items-center p-5 border-b border-neutral-700">
      <h1 className="text-h0 text-black text-start">질문</h1>
      <div className="flex flex-row items-center gap-10">
        <input
          className="w-2/5 py-5 px-8 border border-neutral-700 rounded-lg"
          placeholder="검색할 단어를 입력해주세요"
          value={queryTerm}
          onChange={handleChangeQueryTerm}
        />
        <button
          className="py-5 px-8 bg-primary-500 text-white rounded-lg hover:bg-primary-600 cursor-pointer"
          onClick={handleSearchQuestion}
        >
          검색하기
        </button>
      </div>
    </div>
  );
};

export default SearchQuestion;
