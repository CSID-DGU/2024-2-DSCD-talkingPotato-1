import { ReactElement } from "react";

const QuestionItemEmpty = (): ReactElement => {
  return (
    <div className="flex flex-col w-full h-96 items-center justify-center">
      <div className="flex flex-col items-center justify-center p-8 bg-neutral-900 rounded-2xl">
        <p className="text-h3 text-neutral-300">아직 등록된 질문이 없습니다</p>
      </div>
    </div>
  );
};

export default QuestionItemEmpty;
