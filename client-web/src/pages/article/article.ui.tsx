import {ReactElement, useEffect, useState} from "react";
import * as Styled from "./article.style.ts";
import {RootLayout} from "@shared/layouts";
import {ArticleItemInterface} from "@features/article/article-list/article-item/article-item.lib.ts";
import {ArticleList, ArticleTopBar} from "@features/article";
import ArticleItemMock from "@features/article/article-list/article-item/article-item.mock.ts";

const Article = (): ReactElement => {

    const [articles, setArticles] = useState<ArticleItemInterface[]>([]);

    useEffect(() => {
        setArticles(ArticleItemMock);
    }, []);

    return (
        <RootLayout>
            <Styled.PageContainer>
                <ArticleTopBar/>
                <Styled.ScrollableContainer>
                    <ArticleList articles={articles}/>
                </Styled.ScrollableContainer>
            </Styled.PageContainer>
        </RootLayout>
    )
}

export default Article;