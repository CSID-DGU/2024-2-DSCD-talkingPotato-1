import MDEditor from "@uiw/react-md-editor";
import { ReactElement } from "react";

interface IMarkdownViewer {
  markdownValue: string;
}

export const MarkdownViewer = (props: IMarkdownViewer): ReactElement => {
  return (
    <div className="flex flex-col w-full h-auto flex-shrink-0 items-start overflow-visible p-2.5">
      <MDEditor.Markdown
        source={props.markdownValue}
        style={{
          textAlign: "left",
          wordBreak: "break-word",
          lineHeight: "1.6",
          width: "100%",
          backgroundColor: "white",
          color: "black",
        }}
        components={{
          h1: ({ children }) => (
            <h1 className="text-4xl font-bold my-4">{children}</h1>
          ),
          h2: ({ children }) => (
            <h2 className="text-3xl font-bold my-4">{children}</h2>
          ),
          h3: ({ children }) => (
            <h3 className="text-2xl font-bold my-3">{children}</h3>
          ),
          h4: ({ children }) => (
            <h4 className="text-xl font-bold my-3">{children}</h4>
          ),
          h5: ({ children }) => (
            <h5 className="text-lg font-bold my-2">{children}</h5>
          ),
          ul: ({ children }) => (
            <ul className="list-disc ml-6 my-2">{children}</ul>
          ),
          ol: ({ children }) => (
            <ol className="list-decimal ml-6 my-2">{children}</ol>
          ),
          li: ({ children }) => <li className="text-base my-1">{children}</li>,
          img: ({ src, alt }) => (
            <img
              src={src}
              alt={alt}
              className="w-full h-auto my-4 rounded-lg"
            />
          ),
          table: ({ children }) => (
            <table className="w-full my-4">{children}</table>
          ),
          blockquote: ({ children }) => (
            <blockquote className="border-l-4 border-black pl-4 my-4">
              {children}
            </blockquote>
          ),
          p: ({ children }) => <p className="my-4">{children}</p>,
        }}
      />
    </div>
  );
};

export default MarkdownViewer;
