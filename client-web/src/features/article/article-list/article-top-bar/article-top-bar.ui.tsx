import React from "react";
import * as Styled from "./article-top-bar.style";
import {HeadExtra, SizedBox} from "@shared/components";
import {theme} from "@app/styles";
import {SearchInput} from "@features/article/article-list/article-top-bar/search-input";
import {SearchButton} from "@features/article/article-list/article-top-bar/search-button";

export default function ArticleTopBar(): React.ReactElement {
    return (
        <Styled.Column>
            <Styled.Container>
                <Styled.Row>
                    <HeadExtra text={"칼럼"} textAlign={"start"} color={theme.colorSystem.black}/>
                    <Styled.SearchSection>
                        <SearchInput/>
                        <SearchButton onClick={() => {
                        }}/>
                    </Styled.SearchSection>
                </Styled.Row>
            </Styled.Container>
            <SizedBox height={"1px"} width={"100%"} background={theme.colorSystem.neutral["700"]}/>
        </Styled.Column>
    )
}