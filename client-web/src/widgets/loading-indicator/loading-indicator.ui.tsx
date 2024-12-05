import { ReactElement } from "react";

export const LoadingIndicator = (): ReactElement => {
  return (
    <div className="w-full h-full flex justify-center items-center">
      <div className="w-[50px] h-[50px] border-[5px] border-neutral-100 border-t-primary-500 rounded-full animate-spin" />
    </div>
  );
};

export default LoadingIndicator;
