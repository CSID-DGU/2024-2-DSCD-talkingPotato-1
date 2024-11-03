import * as Styled from "./article-input-section.style";
import {ChangeEvent, Dispatch, ReactElement, SetStateAction} from "react";
import {ArticleContentInput, ArticleTagInput, ArticleTitleInput} from "@features/article";

interface props {
    title: string;
    handleTitleChange: (e: ChangeEvent<HTMLInputElement>) => void;
    tagInput: string;
    handleTagInputChange: (e: ChangeEvent<HTMLInputElement>) => void;
    markdownValue: string | undefined;
    setMarkdownValue: Dispatch<SetStateAction<string | undefined>>;
}

export const ArticleInputSection = (props: props): ReactElement => {

    return (
        <Styled.Container>
            <ArticleTitleInput title={props.title} handleTitleChange={props.handleTitleChange}/>
            <ArticleTagInput tagInput={props.tagInput} handleTagChange={props.handleTagInputChange}/>
            <ArticleContentInput markdownValue={props.markdownValue} setMarkdownValue={props.setMarkdownValue}/>
        </Styled.Container>
    )
}

export default ArticleInputSection;