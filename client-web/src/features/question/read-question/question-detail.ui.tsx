import {QuestionDetailInterface} from "@features/question/question-detail/question-detail.lib.ts";
import {Fragment, ReactElement} from "react";
import * as Styled from "./question-detail.style";
import {QuestionSection} from "@features/question/question-detail/question-section";
import {SizedBox} from "@shared/components";
import AnswerSection from "@features/question/question-detail/answer-section/answer-section.ui.tsx";
import {QuestionAnswerInput} from "@features/question/question-detail/question-answer-input";

interface props {
    question: QuestionDetailInterface;
}

export const QuestionDetail = (props: props): ReactElement => {

    return (
        <Styled.Container>
            <Styled.Column>
                <QuestionSection question={props.question}/>
                <SizedBox height={"40px"}/>
                {
                    props.question.answers.map((answer, index) => (
                        <Fragment key={index}>
                            <AnswerSection answer={answer}/>
                        </Fragment>
                    ))
                }
            </Styled.Column>
            <QuestionAnswerInput/>
        </Styled.Container>
    )
}

export default QuestionDetail;