import { ReactElement } from "react";

interface props {
  title: string;
  content: string;
  onConfirm: () => void;
  onCancel: () => void;
}

const Confirm = (props: props): ReactElement => {
  return (
    <div
      className="fixed top-0 left-0 w-full h-full z-[8000] bg-black/50 flex justify-center items-center"
      onClick={props.onCancel}
    >
      <div
        className="w-96 min-h-[10rem] flex flex-col items-start justify-center p-8 rounded-2xl bg-white z-[8100] border-none gap-5"
        onClick={(e: React.MouseEvent) => e.stopPropagation()}
      >
        <h2 className="text-h2 text-neutral-100">{props.title}</h2>
        <p className="text-sub2 text-neutral-300">{props.content}</p>

        <div className="w-full flex flex-col justify-center items-center gap-4 mt-8">
          <button
            className="w-full rounded-xl py-4 px-8 cursor-pointer border border-neutral-700 bg-white hover:bg-neutral-900"
            onClick={props.onCancel}
          >
            <span className="text-neutral-400 cursor-pointer">취소</span>
          </button>
          <button
            className="w-full rounded-xl py-4 px-8 cursor-pointer border-none bg-red-600 hover:bg-red-500"
            onClick={props.onConfirm}
          >
            <span className="text-white cursor-pointer">확인</span>
          </button>
        </div>
      </div>
    </div>
  );
};

export default Confirm;
