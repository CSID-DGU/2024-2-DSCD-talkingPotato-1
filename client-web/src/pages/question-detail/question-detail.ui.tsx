import {ReactElement} from "react";
import * as Styled from "./question-detail.style.ts";
import {DefaultLayout} from "@shared/layouts";
import {QuestionReadingTopBar} from "@features/question/components";

const QuestionDetail = ():
    ReactElement => {
    return (
        <DefaultLayout>
            <Styled.Container>
                <QuestionReadingTopBar/>
            </Styled.Container>
        </DefaultLayout>
    )
}

export default QuestionDetail;