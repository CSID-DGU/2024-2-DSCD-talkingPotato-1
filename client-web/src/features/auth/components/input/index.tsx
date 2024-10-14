import React from "react";
import * as Styled from "./style";
import InputBox from "./input-box";
import {Head6, SizedBox} from "@shared/components";
import {theme} from "@app/styles";

interface props {
    text: string;
    type: string;
    placeholder: string;
    onChange: (e: React.ChangeEvent<HTMLInputElement>) => void;
}

export default function Input(props: props): React.ReactElement {
    return (
        <Styled.InputWrapper>
            <Head6 text={props.text} textAlign={"start"} color={theme.colorSystem.neutral["500"]}/>
            <SizedBox height={"8px"}/>
            <InputBox type={props.type} placeholder={props.placeholder} onChange={props.onChange}/>
        </Styled.InputWrapper>
    )
}