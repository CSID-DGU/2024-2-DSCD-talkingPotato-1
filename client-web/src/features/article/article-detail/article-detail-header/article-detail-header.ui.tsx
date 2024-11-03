import {Fragment, ReactElement} from "react";
import * as Styled from "./article-detail-header.style.ts";
import {ArticleDetailInterface} from "@features/article/article-detail/article-detail.lib.ts";
import Head0 from "@shared/components/font/heading/head0/head0.ui.tsx";
import {SizedBox, Spacer, Sub3} from "@shared/components";
import {convertDateToKoreanString, convertStringToDate} from "@shared/utils";
import {theme} from "@app/styles";
import {ArticleDetailTag} from "@features/article";

interface props {
    article: ArticleDetailInterface;
}

export const ArticleDetailHeader = (props: props): ReactElement => {

    return (
        <Styled.Container>
            <Head0 text={props.article.title} textAlign={"start"}/>
            <SizedBox height={"10px"}/>
            <Styled.TagWrapper>
                {
                    props.article.hashtags.length > 0 ? (
                        props.article.hashtags.map((tag, index) => (
                                <Fragment key={index}>
                                    <ArticleDetailTag tag={tag} isFirst={index === 0}/>
                                </Fragment>
                            )
                        )
                    ) : (
                        <SizedBox height={"25px"}/>
                    )
                }
            </Styled.TagWrapper>
            <SizedBox height={"10px"}/>
            <Styled.Row>
                <Spacer flex={1} direction={"horizontal"}/>
                <Sub3 text={convertDateToKoreanString(convertStringToDate(props.article.createdAt))} textAlign={"end"}
                      color={theme.colorSystem.neutral["500"]}/>
                <Sub3 text={"|"} textAlign={"center"} color={theme.colorSystem.neutral["500"]}/>
                <Sub3 text={`${props.article.comments.length}개의 댓글`} textAlign={"center"}
                      color={theme.colorSystem.neutral["500"]}/>
                <Sub3 text={"|"} textAlign={"center"} color={theme.colorSystem.neutral["500"]}/>
                <Sub3 text={props.article.creator} textAlign={"start"} color={theme.colorSystem.neutral["500"]}/>
            </Styled.Row>
        </Styled.Container>
    )
}

export default ArticleDetailHeader;