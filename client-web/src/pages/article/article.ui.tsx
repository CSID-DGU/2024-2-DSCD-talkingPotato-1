import {ReactElement} from "react";
import * as Styled from "./article.style.ts";
import {useSideBarStore} from "@shared/store";
import {RootLayout} from "@shared/layouts";
import {ArticleTopBar} from "@features/article/components";

const Article = (): ReactElement => {
    const {isExpanded} = useSideBarStore();

    return (
        <RootLayout>
            <Styled.Container isExpanded={isExpanded}>
                <ArticleTopBar/>
            </Styled.Container>
        </RootLayout>
    )
}

export default Article;