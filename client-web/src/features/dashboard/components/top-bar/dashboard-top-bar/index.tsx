import React from "react";
import * as Styled from "./style";
import {HeadExtra, SizedBox} from "@shared/components";
import {theme} from "@app/styles";

export default function DashboardTopBar(): React.ReactElement {
    return (
        <Styled.Column>
            <Styled.Container>
                <HeadExtra text={"대시보드"} textAlign={"start"} color={theme.colorSystem.black}/>
            </Styled.Container>
            <SizedBox height={"1px"} width={"100%"} background={theme.colorSystem.neutral["500"]}/>
        </Styled.Column>
    )
}