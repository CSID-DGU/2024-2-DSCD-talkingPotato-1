import * as Styled from "./create-input-section.style.ts";
import {ChangeEvent, Dispatch, ReactElement, SetStateAction} from "react";
import {CreateContentInput, CreateTagInput, CreateTitleInput} from "@features/article";

interface props {
    title: string;
    handleTitleChange: (e: ChangeEvent<HTMLInputElement>) => void;
    tagInput: string;
    handleTagInputChange: (e: ChangeEvent<HTMLInputElement>) => void;
    markdownValue: string | undefined;
    setMarkdownValue: Dispatch<SetStateAction<string | undefined>>;
}

export const CreateInputSection = (props: props): ReactElement => {

    return (
        <Styled.Container>
            <CreateTitleInput title={props.title} handleTitleChange={props.handleTitleChange}/>
            <CreateTagInput tagInput={props.tagInput} handleTagChange={props.handleTagInputChange}/>
            <CreateContentInput markdownValue={props.markdownValue} setMarkdownValue={props.setMarkdownValue}/>
        </Styled.Container>
    )
}

export default CreateInputSection;