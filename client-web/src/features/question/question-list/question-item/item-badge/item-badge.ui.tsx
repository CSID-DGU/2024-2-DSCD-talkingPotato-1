import {AnswerStatus} from "@features/question/question-list/question-item/question-item.lib.ts";
import {ReactElement} from "react";
import {theme} from "@app/styles";

import * as Styled from "./item-badge.style";
import {Sub3} from "@shared/components";

interface props {
    status: AnswerStatus;
}

const ItemBadge = (props: props): ReactElement => {

    const getBackgroundColorByStatus = (status: AnswerStatus) => {
        switch (status) {
            case "pending":
                return theme.colorSystem.neutral["500"];
            case "answered_by_llm":
                return theme.colorSystem.blue["600"];
            case "answered_by_expert":
                return theme.colorSystem.primary["600"];
        }
    }

    const getContentByStatus = (status: AnswerStatus) => {
        switch (status) {
            case "pending":
                return "답변 대기 중";
            case "answered_by_llm":
                return "AI 첫 답변";
            case "answered_by_expert":
                return "전문가 첫 답변"
        }
    }

    return (
        <Styled.Container backgroundColor={getBackgroundColorByStatus(props.status)}>
            <Sub3 text={getContentByStatus(props.status)} color={theme.colorSystem.white}/>
        </Styled.Container>
    )
}

export default ItemBadge;