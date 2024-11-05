import {ChangeEvent, ReactElement, useState} from "react";
import * as Styled from "./article-writing.style.ts";
import {DefaultLayout} from "@shared/layouts";
import {ArticleCreateSection, ArticleCreateTopBar} from "@features/article";

/**
 * Todo: Markdown Editor Height to Full Height
 * Todo: Entire Page None Scrollable
 */

const ArticleWriting = (): ReactElement => {

    const [title, setTitle] = useState<string>("");
    const [tagInput, setTagInput] = useState<string>("");
    const [tags, setTags] = useState<string[]>([]);
    const [markdownValue, setMarkdownValue] = useState<string | undefined>('');

    const handleTitleChange = (e: ChangeEvent<HTMLInputElement>) => {
        setTitle(e.target.value);
    }

    const handleTagChange = (e: ChangeEvent<HTMLInputElement>) => {
        setTagInput(e.target.value);

        const newTag = e.target.value
            .split("#")
            .map((tag) => tag.trim())
            .filter((tag) => tag !== "")

        setTags(newTag);
    }

    return (
        <DefaultLayout>
            <ArticleCreateTopBar/>
            <Styled.Container>
                <ArticleCreateSection title={title} handleTitleChange={handleTitleChange} tagInput={tagInput}
                                      handleTagInputChange={handleTagChange} markdownValue={markdownValue}
                                      setMarkdownValue={setMarkdownValue} tags={tags}/>
            </Styled.Container>
        </DefaultLayout>
    )
}

export default ArticleWriting;