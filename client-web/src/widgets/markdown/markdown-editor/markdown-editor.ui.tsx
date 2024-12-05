import {
  Dispatch,
  DragEvent,
  ReactElement,
  SetStateAction,
  useCallback,
} from "react";
import MDEditor from "@uiw/react-md-editor";
import { MarkdownEditorUtil } from "./markdown-editor.lib";

interface props {
  markdownValue: string | undefined;
  setMarkdownValue: Dispatch<SetStateAction<string | undefined>>;
}

export const MarkdownEditor = (props: props): ReactElement => {
  const handleInputChange = (value: string | undefined) => {
    props.setMarkdownValue(value);
  };

  const handleFileUpload = useCallback(
    async (file: File) => {
      if (file && file.type.startsWith("image/")) {
        try {
          const imageUrl = await MarkdownEditorUtil.uploadImage(file);
          const imageMarkdown = `![](${imageUrl})`;

          props.setMarkdownValue((prev) =>
            prev ? `${prev}\n${imageMarkdown}` : imageMarkdown
          );
        } catch (error) {
          console.error("Error uploading image", error);
        }
      }
    },
    [props]
  );

  const handleDrop = (event: DragEvent<HTMLDivElement>) => {
    event.preventDefault();

    const file = event.dataTransfer.files[0];

    if (file) {
      handleFileUpload(file);
    }
  };

  const handleDragOver = useCallback((event: DragEvent<HTMLDivElement>) => {
    event.preventDefault();
  }, []);

  return (
    <div
      className="flex flex-col w-full h-full flex-1"
      onDrop={handleDrop}
      onDragOver={handleDragOver}
    >
      <MDEditor
        value={props.markdownValue}
        onChange={handleInputChange}
        style={{
          borderRadius: "12px",
          padding: "20px",
          height: "100%",
          minHeight: "500px",
          flex: 1,
        }}
        hideToolbar={true}
        preview="edit"
        data-color-mode={"light"}
        visibleDragbar={false}
      />
    </div>
  );
};
