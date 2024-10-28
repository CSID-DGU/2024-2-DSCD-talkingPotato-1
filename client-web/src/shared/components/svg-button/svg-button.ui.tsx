import * as Styled from './svg-button.style.ts';
import React from "react";

interface props {
    src: string;
    width?: string;
    height?: string;
    color?: string;
    top?: string;
    right?: string;
    bottom?: string;
    left?: string;
    position?: string;
    onClick?: () => void;
}

export default function SvgButton(props: props): React.ReactElement {
    return (
        <Styled.Container src={props.src} width={props.width} height={props.height} color={props.color} top={props.top}
                          right={props.right} bottom={props.bottom} left={props.left} onClick={props.onClick}/>
    )
}