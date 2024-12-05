import { ReactElement } from "react";

const QuestionItemSkeleton = (): ReactElement => {
  return (
    <div className="flex flex-col py-12 px-3 w-2/5 gap-4 items-start rounded-2xl">
      <div className="w-full h-6 bg-neutral-800 animate-pulse rounded-lg" />
      <div className="flex flex-row w-full justify-between items-center">
        <div className="flex flex-row gap-3">
          <div className="w-20 h-4 bg-neutral-800 animate-pulse rounded-lg" />
          <p className="text-sub3 text-neutral-500">|</p>
          <div className="w-24 h-4 bg-neutral-800 animate-pulse rounded-lg" />
          <p className="text-sub3 text-neutral-500">|</p>
          <div className="w-16 h-4 bg-neutral-800 animate-pulse rounded-lg" />
        </div>
        <div className="w-24 h-7 bg-neutral-800 animate-pulse rounded-full" />
      </div>
    </div>
  );
};

export default QuestionItemSkeleton;
