import {ReactElement, useEffect, useState} from "react";
import * as Styled from "./question.style.ts";
import {QuestionTopBar} from "@features/question/components";
import {RootLayout} from "@shared/layouts";
import {QuestionList} from "@features/question/question-list";
import {QuestionListLib} from "@features/question/question-list/question-list.lib.ts";
import QuestionListMock from "@features/question/question-list/question-list.mock.ts";


const Question = (): ReactElement => {

    const [questions, setQuestions] = useState<QuestionListLib[]>([]);

    useEffect(() => {
        setQuestions(QuestionListMock);
    }, []);

    return (
        <RootLayout>
            <Styled.PageContainer>
                <QuestionTopBar/>
                <Styled.ScrollableContainer>
                    <QuestionList questions={questions}/>
                </Styled.ScrollableContainer>
            </Styled.PageContainer>
        </RootLayout>
    )
}

export default Question;