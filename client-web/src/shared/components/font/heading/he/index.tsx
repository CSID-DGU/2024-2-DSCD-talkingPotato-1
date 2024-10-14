import * as Styled from "./style";
import {FontProps} from "@shared/types";

export default function HE(props: FontProps) {
    return (
        <Styled.HE color={props.color} textAlign={props.textAlign}>{props.text}</Styled.HE>
    )
}