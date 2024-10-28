import {ReactElement} from "react";

import * as Styled from "./article-item.style.ts"
import {useNavigate} from "react-router-dom";
import {CONSTANTS} from "@app/constants/constants.ts";
import {Head1, Sub2, Sub3} from "@shared/components";
import {theme} from "@app/styles";
import {ItemTag} from "@features/article/article-list/article-item/item-tag";
import {ArticleItemInterface} from "@features/article/article-list/article-item/article-item.lib.ts";
import {convertDateToKoreanString, convertStringToDate} from "@shared/utils";

interface props {
    article: ArticleItemInterface;
}

const ArticleItem = (props: props): ReactElement => {

    const navigate = useNavigate();

    const handleClick = () => {
        navigate(CONSTANTS.ROUTER.ARTICLE_READ + `${props.article.id}`);
    }

    return (
        <Styled.Container onClick={handleClick}>
            <Head1 text={props.article.title} color={theme.colorSystem.black} textAlign={"start"}/>
            <Sub2 text={props.article.content} textAlign={"start"} color={theme.colorSystem.neutral["300"]}/>
            <Styled.Row>
                {
                    props.article.hashtags.map((tag, index) => (
                        <ItemTag key={index} tag={tag} isFirst={index === 0}/>
                    ))
                }
            </Styled.Row>
            <Styled.Row>
                <Sub3 text={convertDateToKoreanString(convertStringToDate(props.article.createdAt))} textAlign={"end"}
                      color={theme.colorSystem.neutral["500"]}/>
                <Sub3 text={"|"} textAlign={"center"} color={theme.colorSystem.neutral["500"]}/>
                <Sub3 text={`${props.article.comments}개의 댓글`} textAlign={"center"}
                      color={theme.colorSystem.neutral["500"]}/>
                <Sub3 text={"|"} textAlign={"center"} color={theme.colorSystem.neutral["500"]}/>
                <Sub3 text={props.article.creator} textAlign={"start"} color={theme.colorSystem.neutral["500"]}/>
            </Styled.Row>
        </Styled.Container>
    )
}

export default ArticleItem;