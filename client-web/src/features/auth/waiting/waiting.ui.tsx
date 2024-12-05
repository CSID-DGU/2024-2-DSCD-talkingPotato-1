import { ReactElement } from "react";

// Icons
import BackIcon from "@shared/assets/icons/Back.svg?react";
import WaitingLogoIcon from "@shared/assets/icons/Waiting.svg?react";
/**
 * Public Component
 */
const Waiting = (): ReactElement => {
  return (
    <div className="flex flex-col w-full">
      <WaitingTopBar />
      <div className="flex flex-col items-center justify-center w-full h-[calc(100vh-78px)]">
        <WaitingLogoIcon className="w-[60%] mb-0" />
      </div>
    </div>
  );
};

export default Waiting;

/**
 * Private Component
 */
const WaitingTopBar = (): ReactElement => {
  return (
    <div className="flex flex-col px-6 w-full h-[78px] justify-center border-b border-neutral-700">
      <div className="flex flex-row justify-between items-center">
        <div className="flex flex-row items-center g-3 cursor-pointer">
          <BackIcon className="w-6 h-6 cursor-pointer text-neutral-500" />
          <h1 className="text-h4 text-neutral-500 text-start cursor-pointer">
            뒤로가기
          </h1>
        </div>
      </div>
    </div>
  );
};
