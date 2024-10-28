import {ReactElement} from "react";
import * as Styled from "./question.style.ts";
import {QuestionTopBar} from "@features/question/components";
import {RootLayout} from "@shared/layouts";


const Question = (): ReactElement => {

    return (
        <RootLayout>
            <Styled.PageContainer>
                <QuestionTopBar/>
                <Styled.ScrollableContainer/>
            </Styled.PageContainer>
        </RootLayout>
    )
}

export default Question;