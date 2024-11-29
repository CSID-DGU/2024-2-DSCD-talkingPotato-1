import * as Styled from "./markdown-viewer.style";
import MDEditor from "@uiw/react-md-editor";
import {ReactElement} from "react";

interface props {
    markdownValue: string;
}

export const MarkdownViewer = (props: props): ReactElement => {

    return (
        <Styled.Container>
            <MDEditor.Markdown source={props.markdownValue} style={{
                textAlign: "left",
                wordBreak: "break-word",
                lineHeight: "1.6",
                width: "100%",
                backgroundColor: "white",
                color: "black"
            }}/>
        </Styled.Container>
    )
}

export default MarkdownViewer;