import {ReactElement} from "react";
import * as Styled from "./article-editing.style.ts";
import {DefaultLayout} from "@shared/layouts";
import {ArticleEditingTopBar} from "@features/article/components";

const ArticleEditing = (): ReactElement => {
    return (
        <DefaultLayout>
            <Styled.Container>
                <ArticleEditingTopBar/>
            </Styled.Container>
        </DefaultLayout>
    )
}

export default ArticleEditing;