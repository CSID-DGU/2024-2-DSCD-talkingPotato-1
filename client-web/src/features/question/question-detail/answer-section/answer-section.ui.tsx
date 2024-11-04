import * as Styled from "./answer-section.style";
import {AnswerStatus, QuestionAnswerInterface} from "@features/question/question-detail/question-detail.lib.ts";
import {ReactElement} from "react";
import {theme} from "@app/styles";
import {Confirm, SizedBox, Sub2, Sub3} from "@shared/components";
import {convertDateToKoreanString, convertStringToDate} from "@shared/utils";
import {useConfirmMessage} from "@shared/lib";

interface props {
    answer: QuestionAnswerInterface;
}

const AnswerSection = (props: props): ReactElement => {

    const {
        isConfirmOpen,
        setIsConfirmOpen,
        confirmTitle,
        setConfirmTitle,
        confirmMessage,
        setConfirmMessage
    } = useConfirmMessage();

    const getAnswerStatus = (status: AnswerStatus): string => {
        switch (status) {
            case "answered_by_llm":
                return "AI 답변";
            case "answered_by_expert":
                return "전문가 답변";
        }
    }

    const getColorByStatus = (status: AnswerStatus): string => {
        switch (status) {
            case "answered_by_llm":
                return theme.colorSystem.blue["500"];
            case "answered_by_expert":
                return theme.colorSystem.primary["500"];
        }
    }

    const handleDelete = () => {
        setIsConfirmOpen(true);
        setConfirmTitle("해당 답변을 삭제하시겠습니까?");
        setConfirmMessage("해당 답변을 삭제할 경우, 질문한 사용자에게도 사라지게됩니다.\n\n주의해주세요!");
    }

    return (
        <Styled.Container>
            <Styled.Row>
                <Sub2 text={getAnswerStatus(props.answer.status)} color={getColorByStatus(props.answer.status)}
                      whiteSpace={"nowrap"}/>
                <SizedBox width={"12px"}/>
                <SizedBox width={"100%"} height={"1px"} background={getColorByStatus(props.answer.status)}/>
            </Styled.Row>
            <SizedBox height={"12px"}/>
            <Sub2 text={props.answer.content} color={theme.colorSystem.neutral["300"]} textAlign={"start"}/>
            <SizedBox height={"12px"}/>
            <Styled.BottomRow>
                <Sub3
                    text={`${convertDateToKoreanString(convertStringToDate(props.answer.createdAt))} | ${props.answer.creator}`}
                    textAlign={"start"} color={theme.colorSystem.neutral["500"]}/>
                {
                    props.answer.isMine && (
                        <Sub3 text={"삭제하기"} color={theme.colorSystem.red["500"]} cursor={"pointer"} onClick={handleDelete}/>
                    )
                }
            </Styled.BottomRow>
            {
                isConfirmOpen && (
                    <Confirm title={confirmTitle} content={confirmMessage} onConfirm={() => setIsConfirmOpen(false)}
                             onCancel={() => setIsConfirmOpen(false)}/>
                )
            }
        </Styled.Container>
    )
}

export default AnswerSection;