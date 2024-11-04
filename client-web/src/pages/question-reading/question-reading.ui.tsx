import {ReactElement, useEffect, useState} from "react";
import * as Styled from "./question-reading.style.ts";
import {DefaultLayout} from "@shared/layouts";
import {QuestionDetail, QuestionDetailTopBar} from "@features/question";
import {QuestionDetailInterface} from "@features/question/question-detail/question-detail.lib.ts";
import QuestionDetailMock from "@features/question/question-detail/question-detail.mock.ts";

const QuestionReading = ():
    ReactElement => {

    const [question, setQuestion] = useState<QuestionDetailInterface>();

    useEffect(() => {
        setQuestion(QuestionDetailMock);
    }, []);

    return (
        <DefaultLayout>
            <QuestionDetailTopBar/>
            <Styled.Container>
                {
                    question && <QuestionDetail question={question}/>
                }
            </Styled.Container>
        </DefaultLayout>
    )
}

export default QuestionReading;