import { ReactElement } from "react";
import { useNavigate } from "react-router-dom";
import { getPageRoute } from "@app/utils";
import { useSideBarStore } from "@shared/store";
import { SideBarPage } from "@shared/types";
import { Logout } from "@features/auth/logout";

// Icons
import ExpandChevronIcon from "@shared/assets/icons/ExpandChevron.svg?react";
import ArticleIcon from "@shared/assets/icons/Article.svg?react";
import QuestionIcon from "@shared/assets/icons/Question.svg?react";

/**
 * Public Component
 */
const Dispose = (): ReactElement => {
  const { toggleExpand, updatePage } = useSideBarStore();
  const navigate = useNavigate();

  const handlePageUpdate = (page: SideBarPage) => {
    updatePage(page);
    navigate(getPageRoute(page));
  };

  return (
    <div className="flex flex-col items-center">
      <ExpandChevronIcon
        className="w-6 h-6 cursor-pointer mb-32"
        onClick={toggleExpand}
      />
      <DisposeItem
        className="mb-2"
        Icon={ArticleIcon}
        type="article"
        onClick={() => handlePageUpdate("article")}
        width="34.222223px"
        height="28px"
      />
      <DisposeItem
        Icon={QuestionIcon}
        type="question"
        onClick={() => handlePageUpdate("question")}
        width="28.85px"
        height="28px"
      />
      <Logout />
    </div>
  );
};

/**
 * Private Component
 */

interface IDisposeItemProps {
  className?: string;
  Icon: React.FunctionComponent<React.SVGProps<SVGSVGElement>>;
  type: SideBarPage;
  onClick: () => void;
  width: string;
  height: string;
}

const DisposeItem = (props: IDisposeItemProps): ReactElement => {
  const { className, Icon, type, onClick, width, height } = props;

  const { currentPage } = useSideBarStore();

  return (
    <div
      className={`flex justify-center w-[60px] py-4 rounded-2xl cursor-pointer ${
        currentPage === type ? "bg-white " : "bg-transparent"
      } ${className}`}
    >
      <Icon
        width={width}
        height={height}
        className={currentPage === type ? "text-primary-500" : "text-white"}
        onClick={onClick}
      />
    </div>
  );
};

export default Dispose;
