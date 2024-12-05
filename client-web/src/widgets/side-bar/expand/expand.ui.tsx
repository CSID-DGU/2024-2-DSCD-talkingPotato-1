import { getPageRoute } from "@app/utils";
import { useSideBarStore } from "@shared/store";
import { SideBarPage } from "@shared/types";
import { ReactElement } from "react";
import { useNavigate } from "react-router-dom";

// Icons
import DisposeChevronIcon from "@shared/assets/icons/DisposeChevron.svg?react";
import ArticleIcon from "@shared/assets/icons/article.svg?react";
import QuestionIcon from "@shared/assets/icons/question.svg?react";

const Expand = (): ReactElement => {
  const { toggleExpand, updatePage } = useSideBarStore();
  const navigate = useNavigate();

  const handlePageUpdate = (page: SideBarPage) => {
    updatePage(page);
    navigate(getPageRoute(page));
  };

  return (
    <div className="flex flex-col items-center">
      <div className="flex flex-row justify-between items-center mb-15">
        <DisposeChevronIcon
          className="w-6 h-6 flex-end cursor-pointer"
          onClick={toggleExpand}
        />
      </div>
      <ExpandItem
        Icon={ArticleIcon}
        type="article"
        onClick={() => handlePageUpdate("article")}
        width="34.222223px"
        height="28px"
        className="mb-2"
      />
      <ExpandItem
        Icon={QuestionIcon}
        type="question"
        onClick={() => handlePageUpdate("question")}
        width="28.85px"
        height="28px"
      />
    </div>
  );
};

interface IExpandItemProps {
  Icon: React.FunctionComponent<React.SVGProps<SVGSVGElement>>;
  type: SideBarPage;
  onClick: () => void;
  width: string;
  height: string;
  className?: string;
}

const ExpandItem = (props: IExpandItemProps): ReactElement => {
  const { Icon, type, onClick, width, height, className } = props;
  const { currentPage } = useSideBarStore();

  const text = props.type == "article" ? "칼럼" : "질문";

  return (
    <div
      className={`flex w-[218px] justify-start p-4 rounded-2xl cursor-pointer ${currentPage === type ? "bg-white" : "bg-transparent"}`}
    >
      <div className="flex flex-row items-center">
        <Icon
          className={`w-[${width}] h-[${height}] ${currentPage === type ? "text-primary-500" : "text-white"} ${className}`}
          onClick={onClick}
        />
        <h4
          className={`text-h4 ${currentPage == type ? "text-primary-500" : "text-white"}`}
        >
          {text}
        </h4>
      </div>
    </div>
  );
};

export default Expand;
