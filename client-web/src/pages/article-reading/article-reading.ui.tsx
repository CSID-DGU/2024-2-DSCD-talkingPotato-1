import {ReactElement} from "react";
import * as Styled from "./article-reading.style.ts";
import {DefaultLayout} from "@shared/layouts";
import {ArticleReadingTopBar} from "@features/article/components";

const ArticleReading = (): ReactElement => {
    return (
        <DefaultLayout>
            <Styled.Container>
                <ArticleReadingTopBar/>
            </Styled.Container>
        </DefaultLayout>
    )
}

export default ArticleReading;