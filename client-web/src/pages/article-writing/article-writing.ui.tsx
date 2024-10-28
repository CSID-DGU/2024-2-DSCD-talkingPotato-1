import {ReactElement} from "react";
import * as Styled from "./article-writing.style.ts";
import {DefaultLayout} from "@shared/layouts";
import {ArticleWritingTopBar} from "@features/article/components";

const ArticleWriting = (): ReactElement => {
    return (
        <DefaultLayout>
            <Styled.Container>
                <ArticleWritingTopBar/>
            </Styled.Container>
        </DefaultLayout>
    )
}

export default ArticleWriting;