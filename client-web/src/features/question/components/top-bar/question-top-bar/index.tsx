import React from "react";
import * as Styled from "./style.ts";
import {HeadExtra, SizedBox} from "@shared/components";
import SearchInput from "@features/question/components/top-bar/question-top-bar/search-input";
import SearchButton from "@features/question/components/top-bar/question-top-bar/search-button";
import {theme} from "@app/styles";

export default function QuestionTopBar(): React.ReactElement {
    return (
        <Styled.Column>
            <Styled.Container>
                <Styled.Row>
                    <HeadExtra text={"질문"} textAlign={"start"} color={theme.colorSystem.black}/>
                    <Styled.SearchSection>
                        <SearchInput/>
                        <SearchButton onClick={() => {
                        }}/>
                    </Styled.SearchSection>
                </Styled.Row>
            </Styled.Container>
            <SizedBox height={"1px"} width={"100%"} background={theme.colorSystem.neutral["500"]}/>
        </Styled.Column>
    )
}