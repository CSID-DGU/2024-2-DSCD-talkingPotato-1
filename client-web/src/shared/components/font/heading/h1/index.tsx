import * as Styled from "./style";
import {FontProps} from "@shared/types";

export default function H1(props: FontProps) {
    return (
        <Styled.H1 color={props.color} textAlign={props.textAlign} cursor={props.cursor}>{props.text}</Styled.H1>
    )
}