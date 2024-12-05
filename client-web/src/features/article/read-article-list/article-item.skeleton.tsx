import { ReactElement } from "react";

const ArticleItemSkeleton = (): ReactElement => {
  return (
    <div className="flex flex-col w-3/5 py-12 px-3 gap-3 animate-pulse">
      <div className="h-8 bg-neutral-800 rounded-lg w-4/5"></div>
      <div className="h-4 bg-neutral-800 rounded-lg w-3/5"></div>
      <div className="flex flex-row gap-2">
        <div className="h-6 bg-neutral-800 rounded-xl w-20"></div>
        <div className="h-6 bg-neutral-800 rounded-xl w-20"></div>
      </div>
      <div className="flex flex-row gap-2">
        <div className="h-4 bg-neutral-800 rounded-lg w-24"></div>
        <div className="h-4 bg-neutral-800 rounded-lg w-4">|</div>
        <div className="h-4 bg-neutral-800 rounded-lg w-20"></div>
        <div className="h-4 bg-neutral-800 rounded-lg w-4">|</div>
        <div className="h-4 bg-neutral-800 rounded-lg w-24"></div>
      </div>
    </div>
  );
};

export default ArticleItemSkeleton;
