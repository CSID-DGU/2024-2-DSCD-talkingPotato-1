import React from "react";
import * as Styled from "./style";
import {DefaultLayout} from "@shared/layouts";
import {ArticleWritingTopBar} from "@features/article/components";

export default function ArticleWriting(): React.ReactElement {

    return (
        <DefaultLayout>
            <Styled.Container>
                <ArticleWritingTopBar/>
            </Styled.Container>
        </DefaultLayout>
    )
}