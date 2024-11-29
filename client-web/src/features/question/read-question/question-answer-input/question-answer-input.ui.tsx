import {ReactElement} from "react";
import * as Styled from "./question-answer-input.style";
import {Head4, Spacer} from "@shared/components";
import {theme} from "@app/styles";

const QuestionAnswerInput = (): ReactElement => {

    return (
        <Styled.Container>
            <Styled.TextArea placeholder={"답변을 작성하세요."}/>
            <Styled.Row>
                <Spacer flex={1} direction={"horizontal"}/>
                <Styled.Button>
                    <Head4 text={"답변 작성"} textAlign={"center"} color={theme.colorSystem.white}/>
                </Styled.Button>
            </Styled.Row>
        </Styled.Container>
    )
}

export default QuestionAnswerInput;