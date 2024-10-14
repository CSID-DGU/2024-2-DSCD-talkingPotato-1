import * as Styled from "./style";
import {FontProps} from "@shared/types";

export default function Sub1(props: FontProps) {
    return (
        <Styled.Sub1 color={props.color} textAlign={props.textAlign}>{props.text}</Styled.Sub1>
    )
}