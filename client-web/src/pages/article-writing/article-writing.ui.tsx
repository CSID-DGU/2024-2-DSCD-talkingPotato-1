import {ReactElement} from "react";
import * as Styled from "./article-writing.style.ts";
import {DefaultLayout} from "@shared/layouts";
import {ArticleCreateTopBar} from "@features/article";

const ArticleWriting = (): ReactElement => {
    return (
        <DefaultLayout>
            <Styled.Container>
                <ArticleCreateTopBar/>
            </Styled.Container>
        </DefaultLayout>
    )
}

export default ArticleWriting;