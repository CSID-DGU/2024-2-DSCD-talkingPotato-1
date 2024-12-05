import { ReactElement, useState } from "react";

interface ISearchArticleProps {
  setSearchTerm: (searchTerm: string) => void;
}

const SearchArticle = (props: ISearchArticleProps): ReactElement => {
  const { setSearchTerm } = props;
  const [queryTerm, setQueryTerm] = useState<string>("");

  const handleSearchInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setQueryTerm(e.target.value);
  };

  const handleSearchButtonClick = () => {
    setSearchTerm(queryTerm);
  };

  return (
    <div className="flex flex-col px-8 justify-center border-b border-neutral-700">
      <div className="flex flex-row items-center justify-between">
        <h1 className="text-h1 text-black text-start">칼럼</h1>
        <div className="flex flex-row gap-2 flex-end">
          <input
            className="w-2/5 py-5 px-8 rounded-xl border border-neutral-700"
            placeholder="검색할 단어를 입력해주세요"
            value={queryTerm}
            onChange={handleSearchInputChange}
          />
          <button
            className="w-1/5 py-5 px-8 rounded-xl bg-primary-500 text-white"
            onClick={handleSearchButtonClick}
          >
            검색
          </button>
        </div>
      </div>
    </div>
  );
};

export default SearchArticle;
