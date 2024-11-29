import * as Styled from "./update-input-section.style.ts";
import {ChangeEvent, Dispatch, ReactElement, SetStateAction} from "react";
import {UpdateContentInput, UpdateTagInput, UpdateTitleInput} from "@features/article";

interface props {
    title: string;
    handleTitleChange: (e: ChangeEvent<HTMLInputElement>) => void;
    tagInput: string;
    handleTagInputChange: (e: ChangeEvent<HTMLInputElement>) => void;
    markdownValue: string | undefined;
    setMarkdownValue: Dispatch<SetStateAction<string | undefined>>;
}

export const UpdateInputSection = (props: props): ReactElement => {

    return (
        <Styled.Container>
            <UpdateTitleInput title={props.title} handleTitleChange={props.handleTitleChange}/>
            <UpdateTagInput tagInput={props.tagInput} handleTagChange={props.handleTagInputChange}/>
            <UpdateContentInput markdownValue={props.markdownValue} setMarkdownValue={props.setMarkdownValue}/>
        </Styled.Container>
    )
}

export default UpdateInputSection;