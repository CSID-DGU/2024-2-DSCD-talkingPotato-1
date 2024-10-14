import React from "react";
import * as Styled from "./style";

interface props {
    Icon: React.FunctionComponent<React.SVGProps<SVGSVGElement>>;
    width?: string;
    height?: string;
    color?: string;
    onClick?: () => void;
}

export default function SvgIcon(props: props): React.ReactElement {
    return (
        <Styled.Container width={props.width} height={props.height} color={props.color} onClick={props.onClick}>
            <props.Icon/>
        </Styled.Container>
    )
}