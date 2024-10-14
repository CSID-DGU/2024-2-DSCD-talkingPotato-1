import React from "react";
import * as Styled from "./style";
import {DefaultLayout} from "@shared/layouts";
import {ArticleEditingTopBar} from "@features/article/components";

export default function ArticleEditing(): React.ReactElement {
    return (
        <DefaultLayout>
            <Styled.Container>
                <ArticleEditingTopBar/>
            </Styled.Container>
        </DefaultLayout>
    )
}