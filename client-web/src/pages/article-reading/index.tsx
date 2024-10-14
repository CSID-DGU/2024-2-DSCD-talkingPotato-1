import React from "react";
import * as Styled from "./style";
import {DefaultLayout} from "@shared/layouts";
import {ArticleReadingTopBar} from "@features/article/components";

export default function ArticleReading(): React.ReactElement {
    return (
        <DefaultLayout>
            <Styled.Container>
                <ArticleReadingTopBar/>
            </Styled.Container>
        </DefaultLayout>
    )
}