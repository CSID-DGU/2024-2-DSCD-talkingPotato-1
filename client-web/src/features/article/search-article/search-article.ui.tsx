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

  const handleKeyDown = (e: React.KeyboardEvent<HTMLInputElement>) => {
    if (e.key === "Enter") {
      handleSearchButtonClick();
    }
  };

  return (
    <div className="flex flex-col w-full items-center justify-center py-8 border-b border-neutral-700">
      <div className="flex flex-row items-center justify-center w-full max-w-3xl gap-4">
        <input
          className="flex-1 py-4 px-6 rounded-xl border border-neutral-700 bg-white focus:outline-none focus:ring-2 focus:ring-neutral-700 transition-all"
          placeholder="검색할 단어를 입력해주세요"
          value={queryTerm}
          onChange={handleSearchInputChange}
          onKeyDown={handleKeyDown}
        />
        <button
          className="px-8 py-4 rounded-xl bg-primary-500 text-white hover:bg-primary-400 transition-colors"
          onClick={handleSearchButtonClick}
        >
          <h4 className="text-h4 text-white">검색하기</h4>
        </button>
      </div>
    </div>
  );
};

export default SearchArticle;
