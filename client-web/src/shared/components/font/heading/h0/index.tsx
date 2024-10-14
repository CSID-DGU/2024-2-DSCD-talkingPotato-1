import * as Styled from "./style";
import {FontProps} from "@shared/types";

export default function H0(props: FontProps) {
    return (
        <Styled.H0 color={props.color} textAlign={props.textAlign}>{props.text}</Styled.H0>
    )
}