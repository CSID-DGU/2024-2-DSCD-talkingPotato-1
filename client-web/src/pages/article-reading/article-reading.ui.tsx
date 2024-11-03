import * as Styled from "./article-reading.style.ts";
import {ReactElement, useEffect, useState} from "react";
import {ArticleDetailInterface} from "@features/article/article-detail/article-detail.lib.ts";
import {ArticleDetail, ArticleDetailMock, ArticleReadingTopBar} from "@features/article";
import {DefaultLayout} from "@shared/layouts";

const ArticleReading = (): ReactElement => {

    const [article, setArticle] = useState<ArticleDetailInterface>();

    useEffect(() => {
        setArticle(ArticleDetailMock);
    }, []);

    return (
        <DefaultLayout>
            <Styled.PageContainer>
                <ArticleReadingTopBar/>
                {
                    article && (
                        <Styled.ScrollableContainer>
                            <ArticleDetail article={article}/>
                        </Styled.ScrollableContainer>
                    )
                }
            </Styled.PageContainer>
        </DefaultLayout>
    )
}

export default ArticleReading;