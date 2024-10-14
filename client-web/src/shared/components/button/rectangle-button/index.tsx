import React from "react";
import * as Styled from "./style";
import {Head4} from "@shared/components";
import {theme} from "@app/styles";

interface props {
    content: string;
    backgroundColor: string;
    borderRadius?: string;
    padding?: string;
    width?: string;
    height?: string;
    onClick?: () => void;
}

export default function RectangleButton(props: props): React.ReactElement {
    return (
        <Styled.Container backgroundColor={props.backgroundColor} borderRadius={props.borderRadius}
                          padding={props.padding} width={props.width} height={props.height} onClick={props.onClick}>
            <Head4 text={props.content} color={theme.colorSystem.white} textAlign={"center"}/>
        </Styled.Container>
    )
}