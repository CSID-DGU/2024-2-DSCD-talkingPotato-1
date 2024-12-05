import { ReactElement } from "react";

interface props {
  title: string;
  onClick: () => void;
}

const Alert = (props: props): ReactElement => {
  return (
    <div
      className="fixed top-0 left-0 w-full h-full z-[8000] bg-black/50 flex justify-center items-center"
      onClick={props.onClick}
    >
      <div
        className="w-96 min-h-[10rem] flex flex-col justify-center p-8 rounded-2xl bg-white z-[8100] border-none"
        onClick={(e: React.MouseEvent) => e.stopPropagation()}
      >
        <h4 className="text-h4 text-neutral-100">{props.title}</h4>
        <div className="w-full flex flex-col justify-center items-center gap-4 mt-8">
          <button
            className="w-full rounded-[20px] py-4 px-8 cursor-pointer border-none bg-secondary-500 hover:bg-secondary-400"
            onClick={props.onClick}
          >
            <span className="text-white">확인</span>
          </button>
        </div>
      </div>
    </div>
  );
};

export default Alert;
