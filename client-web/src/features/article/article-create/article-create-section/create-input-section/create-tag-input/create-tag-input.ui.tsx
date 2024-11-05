import * as Styled from "./create-tag-input.style.ts";
import {ChangeEvent, ReactElement} from "react";
import {SizedBox, Sub2} from "@shared/components";
import {theme} from "@app/styles";

interface props {
    tagInput: string;
    handleTagChange: (e: ChangeEvent<HTMLInputElement>) => void;
}

export const CreateTagInput = (props: props): ReactElement => {

    return (
        <Styled.Container>
            <Styled.LabelWithLine>
                <Sub2 text={"태그"} color={theme.colorSystem.primary["500"]} whiteSpace={"nowrap"}/>
                <SizedBox width={"12px"}/>
                <SizedBox height={"1px"} width={"100%"} background={theme.colorSystem.primary["500"]}/>
            </Styled.LabelWithLine>
            <SizedBox height={"20px"}/>
            <Styled.Input placeholder={"태그를 입력하세요"} value={props.tagInput} onChange={props.handleTagChange}/>
        </Styled.Container>
    )
}

export default CreateTagInput;