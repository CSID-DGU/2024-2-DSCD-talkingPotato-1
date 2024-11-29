import * as Styled from "./article-comment-input.style";
import {ReactElement} from "react";
import {Head4, Spacer} from "@shared/components";
import {theme} from "@app/styles";

export const ArticleCommentInput = (): ReactElement => {

    return (
        <Styled.Container>
            <Styled.TextArea placeholder={"댓글을 작성하세요"}/>
            <Styled.Row>
                <Spacer flex={1} direction={"horizontal"}/>
                <Styled.Button>
                    <Head4 text={"댓글 작성"} color={theme.colorSystem.white}/>
                </Styled.Button>
            </Styled.Row>
        </Styled.Container>
    )
}

export default ArticleCommentInput;