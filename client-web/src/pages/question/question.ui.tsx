import {ReactElement} from "react";
import * as Styled from "./question.style.ts";
import {useSideBarStore} from "@shared/store";
import {RootLayout} from "@shared/layouts";
import {QuestionTopBar} from "@features/question/components";


const Question = (): ReactElement => {

    const {isExpanded} = useSideBarStore();

    return (
        <RootLayout>
            <Styled.Container isExpanded={isExpanded}>
                <QuestionTopBar/>
            </Styled.Container>
        </RootLayout>
    )
}

export default Question;