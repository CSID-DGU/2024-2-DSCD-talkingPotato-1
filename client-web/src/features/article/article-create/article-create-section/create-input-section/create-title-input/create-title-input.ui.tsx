import * as Styled from "./create-title-input.style.ts";
import {ChangeEvent, ReactElement} from "react";
import {SizedBox, Sub2} from "@shared/components";
import {theme} from "@app/styles";

interface props {
    title: string;
    handleTitleChange: (e: ChangeEvent<HTMLInputElement>) => void;
}

export const CreateTitleInput = (props: props): ReactElement => {

    return (
        <Styled.Container>
            <Styled.LabelWithLine>
                <Sub2 text={"제목"} color={theme.colorSystem.primary["500"]} whiteSpace={"nowrap"}/>
                <SizedBox width={"12px"}/>
                <SizedBox height={"1px"} width={"100%"} background={theme.colorSystem.primary["500"]}/>
            </Styled.LabelWithLine>
            <SizedBox height={"20px"}/>
            <Styled.Input placeholder={"제목을 입력하세요"} value={props.title} onChange={props.handleTitleChange}/>
        </Styled.Container>
    )
}

export default CreateTitleInput;