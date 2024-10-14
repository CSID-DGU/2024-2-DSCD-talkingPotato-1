import * as Styled from "./style";
import {FontProps} from "@shared/types";

export default function H2(props: FontProps) {
    return (
        <Styled.H2 color={props.color} textAlign={props.textAlign}>{props.text}</Styled.H2>
    )
}