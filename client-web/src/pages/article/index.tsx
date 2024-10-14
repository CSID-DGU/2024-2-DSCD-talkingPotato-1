import React from "react";
import * as Styled from "./style";
import {useSideBarStore} from "@shared/store";
import {RootLayout} from "@shared/layouts";
import {ArticleTopBar} from "@features/article/components";

export default function Article(): React.ReactElement {

    const {isExpanded} = useSideBarStore();

    return (
        <RootLayout>
            <Styled.Container isExpanded={isExpanded}>
                <ArticleTopBar/>
            </Styled.Container>
        </RootLayout>
    )
}