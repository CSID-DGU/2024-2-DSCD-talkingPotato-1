import React from "react";
import * as Styled from "./style";
import {DefaultLayout} from "@shared/layouts";
import {QuestionReadingTopBar} from "@features/question/components";


export default function QuestionDetail(): React.ReactElement {
    return (
        <DefaultLayout>
            <Styled.Container>
                <QuestionReadingTopBar/>
            </Styled.Container>
        </DefaultLayout>
    )
}