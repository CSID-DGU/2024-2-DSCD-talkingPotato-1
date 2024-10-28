import {ArticleItemInterface} from "@features/article/article-list/article-item/article-item.lib.ts";
import {Fragment, ReactElement} from "react";
import * as Styled from "./article-list.style";
import ArticleItem from "@features/article/article-list/article-item/article-item.ui.tsx";

interface props {
    articles: ArticleItemInterface[];
}

const ArticleList = (props: props): ReactElement => {

    return (
        <Styled.Container>
            {
                props.articles.map((article, index) => (
                    <Fragment key={index}>
                        <ArticleItem article={article}/>
                        {index < props.articles.length - 1 && <Styled.Divider/>}
                    </Fragment>
                ))
            }
        </Styled.Container>
    )
}

export default ArticleList;