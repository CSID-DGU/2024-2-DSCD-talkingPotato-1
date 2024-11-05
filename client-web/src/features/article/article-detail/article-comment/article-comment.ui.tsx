import * as Styled from "./article-comment.style";
import {ReactElement} from "react";
import {ArticleCommentInterface} from "@features/article/article-detail/article-detail.lib.ts";
import {Head3, SizedBox, Sub2, Sub3} from "@shared/components";
import {theme} from "@app/styles";
import {convertDateToKoreanString, convertStringToDate} from "@shared/utils";

interface props {
    comment: ArticleCommentInterface;
}

export const ArticleComment = (props: props): ReactElement => {

    return (
        <Styled.Container>
            <Head3 text={props.comment.creator} textAlign={"start"} color={theme.colorSystem.black}/>
            <SizedBox height={"12px"}/>
            <Sub2 text={props.comment.content} textAlign={"start"} color={theme.colorSystem.black}/>
            <SizedBox height={"12px"}/>
            <Sub3 text={convertDateToKoreanString(convertStringToDate(props.comment.createdAt))} textAlign={"start"}
                  color={theme.colorSystem.neutral["500"]}/>
        </Styled.Container>
    )
}

export default ArticleComment;