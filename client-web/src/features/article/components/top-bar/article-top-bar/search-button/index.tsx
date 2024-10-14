import React from "react";
import * as Styled from "./style";
import {Head1} from "@shared/components";
import {theme} from "@app/styles";

interface props {
    onClick: () => void;
}

export default function SearchButton(props: props): React.ReactElement {
    return (
        <Styled.Container>
            <Head1 text={"검색하기"} color={theme.colorSystem.white} onClick={props.onClick}/>
        </Styled.Container>
    )
}