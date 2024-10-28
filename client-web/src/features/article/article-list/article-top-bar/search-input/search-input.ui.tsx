import React from "react";
import * as Styled from "./search-input.style";

export default function SearchInput(): React.ReactElement {
    return (
        <Styled.Container placeholder={"검색할 단어를 입력해주세요"}/>
    )
}