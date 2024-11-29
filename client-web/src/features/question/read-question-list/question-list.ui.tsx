import {QuestionListLib} from "@features/question/question-list/question-list.lib.ts";
import {Fragment, ReactElement} from "react";
import * as Styled from "./question-list.style";
import {QuestionItem} from "@features/question/question-list/question-item/question-item.ui.tsx";

interface props {
    questions: QuestionListLib[];
}

const QuestionList = (props: props): ReactElement => {

    return (
        <Styled.Container>
            {
                props.questions.map((question, index) => (
                    <Fragment key={index}>
                        <QuestionItem question={question}/>
                        {index < props.questions.length - 1 && <Styled.Divider/>}
                    </Fragment>
                ))
            }
        </Styled.Container>
    )
}

export default QuestionList;