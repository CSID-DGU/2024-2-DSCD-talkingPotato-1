import * as Styled from "./article-editing.style.ts";
import {ChangeEvent, ReactElement, useEffect, useState} from "react";
import {DefaultLayout} from "@shared/layouts";
import {ArticleDetailMock, ArticleUpdateSection, ArticleUpdateTopBar} from "@features/article";
import {ArticleDetailInterface} from "@features/article/article-detail/article-detail.lib.ts";

/**
 * Todo: Markdown Editor Height to Full Height
 * Todo: Entire Page None Scrollable
 */

const ArticleEditing = (): ReactElement => {

    const [article, setArticle] = useState<ArticleDetailInterface>();

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

    useEffect(() => {
        if (article) {
            setTitle(article.title);
            setTags(article.hashtags);

            let tagInput = "#";

            tagInput += article.hashtags.join(" #");

            setTagInput(tagInput);

            setMarkdownValue(article.content);
        }
    }, [article]);

    useEffect(() => {
        setArticle(ArticleDetailMock);
    }, []);

    return (
        <DefaultLayout>
            <ArticleUpdateTopBar/>
            <Styled.Container>
                <ArticleUpdateSection title={title} handleTitleChange={handleTitleChange} tagInput={tagInput}
                                      handleTagInputChange={handleTagChange} markdownValue={markdownValue}
                                      setMarkdownValue={setMarkdownValue} tags={tags}/>
            </Styled.Container>
        </DefaultLayout>
    )
}

export default ArticleEditing;