import * as Styled from './style.ts'
import React from "react";
import {Head1, Head4, Sub2} from "@shared/components";
import {theme} from "@app/styles";

interface props {
    title: string;
    content: string;
    onConfirm: () => void;
    onCancel: () => void;
}

export default function Confirm(props: props): React.ReactElement {

    return (
        <Styled.Overlay onClick={props.onCancel}>
            <Styled.Container onClick={(e) => e.stopPropagation()}>
                <Head1 text={props.title} color={theme.colorSystem.black} textAlign={"start"}/>
                <Sub2 text={props.content} color={theme.colorSystem.neutral["300"]} textAlign={"start"}/>
                <Styled.ButtonContainer>
                    <Styled.StyledButton onClick={props.onCancel} backgroundColor={theme.colorSystem.white}
                                         border={true}>
                        <Head4 text={"취소"} color={theme.colorSystem.neutral["400"]}/>
                    </Styled.StyledButton>
                    <Styled.StyledButton onClick={props.onConfirm} backgroundColor={theme.colorSystem.red["600"]}>
                        <Head4 text={"확인"} color={theme.colorSystem.white}/>
                    </Styled.StyledButton>
                </Styled.ButtonContainer>
            </Styled.Container>
        </Styled.Overlay>
    )
}