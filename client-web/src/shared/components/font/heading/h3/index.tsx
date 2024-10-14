import * as Styled from "./style";
import {FontProps} from "@shared/types";

export default function H3(props: FontProps) {
    return (
        <Styled.H3 color={props.color} textAlign={props.textAlign}>{props.text}</Styled.H3>
    )
}