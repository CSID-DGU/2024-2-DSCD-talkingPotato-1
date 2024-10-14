import React from "react";
import * as Styled from "./style";
import {useSideBarStore} from "@shared/store";
import {RootLayout} from "@shared/layouts";
import {QuestionTopBar} from "@features/question/components";


export default function Question(): React.ReactElement {

    const {isExpanded} = useSideBarStore();

    return (
        <RootLayout>
            <Styled.Container isExpanded={isExpanded}>
                <QuestionTopBar/>
            </Styled.Container>
        </RootLayout>
    )
}