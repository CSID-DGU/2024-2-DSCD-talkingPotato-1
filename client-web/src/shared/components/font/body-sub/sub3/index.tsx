import * as Styled from "./style";
import {FontProps} from "@shared/types";

export default function Sub3(props: FontProps) {
    return (
        <Styled.Sub3 color={props.color} textAlign={props.textAlign}>{props.text}</Styled.Sub3>
    )
}