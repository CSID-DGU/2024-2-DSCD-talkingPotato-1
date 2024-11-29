import {Dispatch, DragEvent, ReactElement, SetStateAction, useCallback} from "react";
import * as Styled from "./markdown-editor.style";
import MDEditor from "@uiw/react-md-editor";

interface props {
    markdownValue: string | undefined;
    setMarkdownValue: Dispatch<SetStateAction<string | undefined>>;
}

export const MarkdownEditor = (props: props): ReactElement => {

    const handleInputChange = (value: string | undefined) => {
        props.setMarkdownValue(value);
    }

    const handleFileUpload = useCallback(
        (file: File) => {
            if (file && file.type.startsWith("image/")) {

                try {
                    const imageUrl = "https://i.esdrop.com/d/f/hhaNifrpr0/ZAyfuiSMM9.png";
                    const imageMarkdown = `![](${imageUrl})`;

                    props.setMarkdownValue((prev) => (
                        prev ? `${prev}\n${imageMarkdown}` : imageMarkdown
                    ));
                } catch (error) {
                    console.error("Error uploading image", error);
                }
            }
        },
        [props]
    )

    const handleDrop = (event: DragEvent<HTMLDivElement>) => {
        event.preventDefault();

        const file = event.dataTransfer.files[0];

        if (file) {
            handleFileUpload(file);
        }
    }

    const handleDragOver = useCallback((event: DragEvent<HTMLDivElement>) => {
        event.preventDefault();
    }, [])

    return (
        <Styled.Container onDrop={handleDrop} onDragOver={handleDragOver}>
            <MDEditor
                value={props.markdownValue}
                onChange={handleInputChange}
                style={{borderRadius: "12px", padding: "20px", height: "100%", flex: 1}}
                hideToolbar={true}
                preview="edit"
                data-color-mode={"light"}
                visibleDragbar={false}
            />
        </Styled.Container>
    )
}