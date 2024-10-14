import React from "react";
import * as Styled from "./style";

export default function SearchInput(): React.ReactElement {
    return (
        <Styled.Container placeholder={"검색할 단어를 입력해주세요"}/>
    )
}