import * as Styled from "./style";
import {FontProps} from "@shared/types";

export default function H6(props: FontProps) {
    return (
        <Styled.H6 color={props.color} textAlign={props.textAlign}>{props.text}</Styled.H6>
    )
}