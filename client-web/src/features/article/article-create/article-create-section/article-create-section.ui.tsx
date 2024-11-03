import * as Styled from "./article-create-section.style";
import {ChangeEvent, Dispatch, ReactElement, SetStateAction} from "react";
import {ArticleInputSection, ArticlePreviewSection} from "@features/article";

interface props {
    title: string;
    handleTitleChange: (e: ChangeEvent<HTMLInputElement>) => void;
    tagInput: string;
    handleTagInputChange: (e: ChangeEvent<HTMLInputElement>) => void;
    markdownValue: string | undefined;
    setMarkdownValue: Dispatch<SetStateAction<string | undefined>>;
    tags: string[];
}

export const ArticleCreateSection = (props: props): ReactElement => {

    return (
        <Styled.Container>
            <ArticleInputSection title={props.title} handleTitleChange={props.handleTitleChange}
                                 tagInput={props.tagInput} handleTagInputChange={props.handleTagInputChange}
                                 markdownValue={props.markdownValue}
                                 setMarkdownValue={props.setMarkdownValue}/>
            <ArticlePreviewSection title={props.title} tags={props.tags} markdownValue={props.markdownValue!}/>
        </Styled.Container>
    )
}

export default ArticleCreateSection;