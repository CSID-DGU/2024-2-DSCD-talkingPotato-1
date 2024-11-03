import * as Styled from "./article-editing.style.ts";
import {ReactElement} from "react";
import {DefaultLayout} from "@shared/layouts";
import {ArticleUpdateTopBar} from "@features/article";

const ArticleEditing = (): ReactElement => {
    return (
        <DefaultLayout>
            <Styled.Container>
                <ArticleUpdateTopBar/>
            </Styled.Container>
        </DefaultLayout>
    )
}

export default ArticleEditing;