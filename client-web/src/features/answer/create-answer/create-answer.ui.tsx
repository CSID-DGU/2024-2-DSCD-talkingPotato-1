import { ReactElement, useState } from "react";
import useCreateAnswerMutation from "./create-answer.mutation";

interface ICreateAnswerProps {
  questionId: number;
}

const CreateAnswer = (props: ICreateAnswerProps): ReactElement => {
  const { questionId } = props;
  const { mutate: createAnswer } = useCreateAnswerMutation();

  const [answer, setAnswer] = useState<string>("");

  const handleAnswerChange = (e: React.ChangeEvent<HTMLTextAreaElement>) => {
    setAnswer(e.target.value);
  };

  const handleCreateAnswerButtonClick = () => {
    createAnswer({
      questionId: questionId,
      answer: {
        content: answer,
      },
    });

    setAnswer("");
  };

  return (
    <div className="flex flex-col w-full h-full p-5">
      <textarea
        className="p-5 text-sub2 text-neutral-300 border border-neutral-700 rounded-xl resize-none mb-5 h-[200px]"
        placeholder="답변을 작성하세요."
        value={answer}
        onChange={handleAnswerChange}
      />
      <div className="flex flex-row w-full justify-end">
        <button
          className="w-24 h-12 rounded-xl border-none bg-secondary-500 cursor-pointer hover:bg-secondary-400"
          onClick={handleCreateAnswerButtonClick}
        >
          <h4 className="text-h4 text-white text-center">답변 작성</h4>
        </button>
      </div>
    </div>
  );
};

export default CreateAnswer;
