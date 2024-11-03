import * as Styled from "./article.style.ts";
import {ReactElement, useEffect, useState} from "react";
import {useNavigate} from "react-router-dom";
import {ArticleItemInterface} from "@features/article/article-list/article-item/article-item.lib.ts";
import {CONSTANTS} from "@app/constants/constants.ts";
import {ArticleList, ArticleListMock, ArticleTopBar, CreateButton} from "@features/article";
import {RootLayout} from "@shared/layouts";

const Article = (): ReactElement => {

    const navigate = useNavigate();
    const [articles, setArticles] = useState<ArticleItemInterface[]>([]);

    const handleArticleWrite = () => {
        navigate(CONSTANTS.ROUTER.ARTICLE_WRITE);
    }

    useEffect(() => {
        setArticles(ArticleListMock);
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