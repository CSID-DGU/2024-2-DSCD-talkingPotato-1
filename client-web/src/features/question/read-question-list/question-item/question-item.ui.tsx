import {QuestionListLib} from "@features/question/question-list/question-list.lib.ts";
import {ReactElement} from "react";
import * as Styled from "./question-item.style";
import {Spacer, Sub2, Sub3} from "@shared/components";
import {theme} from "@app/styles";
import {convertDateToKoreanString, convertStringToDate} from "@shared/utils";
import {ItemBadge} from "@features/question/question-list/question-item/item-badge";
import {AnswerStatus} from "@features/question/question-list/question-item/question-item.lib.ts";
import {useNavigate} from "react-router-dom";
import {CONSTANTS} from "@app/constants/constants.ts";

interface props {
    question: QuestionListLib;
}

export const QuestionItem = (props: props): ReactElement => {

    const navigate = useNavigate();

    const getStatus = (status: string): AnswerStatus | never => {
        switch (status) {
            case "pending":
                return "pending";
            case "answered_by_llm":
                return "answered_by_llm";
            case "answered_by_expert":
                return "answered_by_expert";
            default:
                throw new Error("Invalid status");
        }
    }

    const handleOnClick = () => {
        navigate(CONSTANTS.ROUTER.QUESTION_DETAIL + props.question.id);
    }

    return (
        <Styled.Container onClick={handleOnClick}>
            <Sub2 text={props.question.content} textAlign={"start"} color={theme.colorSystem.neutral["300"]}/>
            <Styled.Row>
                <Sub3 text={convertDateToKoreanString(convertStringToDate(props.question.createdAt))}
                      color={theme.colorSystem.neutral["500"]} textAlign={"end"}/>
                <Sub3 text={'|'} color={theme.colorSystem.neutral["500"]} textAlign={"center"}/>
                <Sub3 text={props.question.answers + '개의 답변'} color={theme.colorSystem.neutral["500"]}
                      textAlign={"start"}/>
                <Sub3 text={'|'} color={theme.colorSystem.neutral["500"]} textAlign={"center"}/>
                <Sub3 text={props.question.creator} color={theme.colorSystem.neutral["500"]} textAlign={"start"}/>
                <Spacer flex={1} direction={"horizontal"}/>
                <ItemBadge status={getStatus(props.question.status)}/>
            </Styled.Row>
        </Styled.Container>
    )

}
