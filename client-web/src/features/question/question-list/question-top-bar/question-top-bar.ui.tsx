import React from "react";
import * as Styled from "./question-top-bar.style";
import {HeadExtra, SizedBox} from "@shared/components";
import {theme} from "@app/styles";
import SearchInput from "@features/question/question-list/question-top-bar/search-input";
import SearchButton from "@features/question/question-list/question-top-bar/search-button";

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
            <SizedBox height={"1px"} width={"100%"} background={theme.colorSystem.neutral["700"]}/>
        </Styled.Column>
    )
}