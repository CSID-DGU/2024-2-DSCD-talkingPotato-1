import * as Styled from "./style";
import {FontProps} from "@shared/types";

export default function H4(props: FontProps) {
    return (
        <Styled.H4 color={props.color} textAlign={props.textAlign}>{props.text}</Styled.H4>
    )
}