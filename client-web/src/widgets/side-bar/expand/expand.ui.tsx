import { getPageRoute } from "@app/utils";
import { useSideBarStore } from "@shared/store";
import { SideBarPage } from "@shared/types";
import { ReactElement } from "react";
import { useNavigate } from "react-router-dom";

// Icons
import DisposeChevronIcon from "@shared/assets/icons/DisposeChevron.svg?react";
import ArticleIcon from "@shared/assets/icons/article.svg?react";
import QuestionIcon from "@shared/assets/icons/question.svg?react";
import { Logout } from "@features/auth/logout";

const Expand = (): ReactElement => {
  const { toggleExpand, updatePage } = useSideBarStore();
  const navigate = useNavigate();

  const handlePageUpdate = (page: SideBarPage) => {
    updatePage(page);
    navigate(getPageRoute(page));
  };

  return (
    <div className="flex flex-col items-center">
      <div className="flex flex-row justify-end items-center mb-32 w-full">
        <DisposeChevronIcon
          className="w-6 h-6 cursor-pointer"
          onClick={toggleExpand}
        />
      </div>
      <ExpandItem
        Icon={ArticleIcon}
        type="article"
        onClick={() => handlePageUpdate("article")}
        className="w-8 h-8 mr-4"
      />
      <ExpandItem
        Icon={QuestionIcon}
        type="question"
        onClick={() => handlePageUpdate("question")}
        className="w-8 h-8 mr-4"
      />
      <Logout />
    </div>
  );
};

interface IExpandItemProps {
  Icon: React.FunctionComponent<React.SVGProps<SVGSVGElement>>;
  type: SideBarPage;
  onClick: () => void;
  className?: string;
}

const ExpandItem = (props: IExpandItemProps): ReactElement => {
  const { Icon, type, onClick, className } = props;
  const { currentPage } = useSideBarStore();

  const text = props.type == "article" ? "칼럼" : "질문";

  return (
    <div
      className={`flex w-[218px] justify-start p-4 rounded-2xl cursor-pointer ${currentPage === type ? "bg-white" : "bg-transparent"} `}
      onClick={onClick}
    >
      <div className="flex flex-row items-center">
        <Icon
          className={`${currentPage === type ? "text-primary-500" : "text-white"} ${className}`}
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
