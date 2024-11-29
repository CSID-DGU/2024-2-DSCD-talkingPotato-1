import {Fragment, ReactElement} from "react";
import * as Styled from "./article-detail.style.ts";
import {ArticleDetailHeader} from "@features/article/article-detail/article-detail-header/article-detail-header.ui.tsx";
import {ArticleDetailInterface} from "@features/article/article-detail/article-detail.lib.ts";
import {SizedBox} from "@shared/components";
import {theme} from "@app/styles";
import {ArticleComment, ArticleCommentInput, MarkdownViewer} from "@features/article";
import {UpdateButton} from "@features/article/article-detail/update-button";
import {useNavigate} from "react-router-dom";
import {CONSTANTS} from "@app/constants/constants.ts";

/**
 * Todo: Resolve SizedBox Height Issue
 */

interface props {
    article: ArticleDetailInterface;
}

export const ArticleDetail = (props: props): ReactElement => {

    const navigate = useNavigate();

    const onClickUpdate = () => {
        navigate(CONSTANTS.ROUTER.ARTICLE_EDIT + `${props.article.id}`);
    }

    return (
        <Styled.Container>
            <ArticleDetailHeader article={props.article}/>
            <SizedBox height={"1px"} width={"100%"} margin={"40px 0"}
                      background={theme.colorSystem.neutral["700"]}/>
            <MarkdownViewer markdownValue={props.article.content}/>
            <SizedBox width={"100%"} height={"1px"} background={theme.colorSystem.neutral["700"]}
                      margin={"40px 0"}/>
            <ArticleCommentInput/>
            <SizedBox height={"40px"}/>
            {
                props.article.comments.map((comment, index) => (
                    <Fragment key={index}>
                        <SizedBox height={"1px"} width={"100%"} background={theme.colorSystem.neutral["700"]}/>
                        <ArticleComment comment={comment}/>
                    </Fragment>
                ))
            }
            <UpdateButton onClick={onClickUpdate}/>
        </Styled.Container>
    )
}

export default ArticleDetail;