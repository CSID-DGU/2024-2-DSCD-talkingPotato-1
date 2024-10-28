import {ReactElement, useEffect, useState} from "react";
import * as Styled from "./article.style.ts";
import {RootLayout} from "@shared/layouts";
import {ArticleItemInterface} from "@features/article/article-list/article-item/article-item.lib.ts";
import {ArticleList, ArticleTopBar, CreateButton} from "@features/article";
import ArticleItemMock from "@features/article/article-list/article-item/article-item.mock.ts";
import {useNavigate} from "react-router-dom";
import {CONSTANTS} from "@app/constants/constants.ts";

const Article = (): ReactElement => {

    const navigate = useNavigate();
    const [articles, setArticles] = useState<ArticleItemInterface[]>([]);

    const handleArticleWrite = () => {
        navigate(CONSTANTS.ROUTER.ARTICLE_WRITE);
    }

    useEffect(() => {
        setArticles(ArticleItemMock);
    }, []);

    return (
        <RootLayout>
            <Styled.PageContainer>
                <ArticleTopBar/>
                <Styled.ScrollableContainer>
                    <ArticleList articles={articles}/>
                    <CreateButton onClick={handleArticleWrite}/>
                </Styled.ScrollableContainer>
            </Styled.PageContainer>
        </RootLayout>
    )
}

export default Article;