import * as Styled from "./question-section.style";
import {QuestionDetailInterface} from "@features/question/question-detail/question-detail.lib.ts";
import {ReactElement} from "react";
import {Head3, SizedBox, Sub2, Sub3} from "@shared/components";
import {theme} from "@app/styles";
import {convertDateToKoreanString, convertStringToDate} from "@shared/utils";

interface props {
    question: QuestionDetailInterface;
}

const QuestionSection = (props: props): ReactElement => {

    return (
        <Styled.Container>
            <Head3 text={`이 질문에 ${props.question.answers.length}개의 답변이 있어요.`} textAlign={"start"}
                   color={theme.colorSystem.black}/>
            <SizedBox height={"20px"}/>
            <Sub2 text={props.question.content} textAlign={"start"} color={theme.colorSystem.black}/>
            <SizedBox height={"20px"}/>
            <Sub3
                text={`${convertDateToKoreanString(convertStringToDate(props.question.createdAt))} | ${props.question.creator}`}
                textAlign={"start"} color={theme.colorSystem.neutral["500"]}/>
        </Styled.Container>
    )
}

export default QuestionSection;