import * as Styled from "./article-detail-tag.style.ts";
import {ReactElement} from "react";
import {Sub2} from "@shared/components";
import {theme} from "@app/styles";

interface props {
    tag: string;
    isFirst: boolean;
}

export const ArticleDetailTag = (props: props): ReactElement => {
    return (
        <Styled.Container isFirst={props.isFirst}>
            <Sub2 text={props.tag} textAlign={"center"} color={theme.colorSystem.primary["500"]} cursor={"pointer"}/>
        </Styled.Container>
    )
}

export default ArticleDetailTag;