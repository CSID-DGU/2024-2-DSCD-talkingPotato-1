import * as Styled from "./style";
import {FontProps} from "@shared/types";

export default function H5(props: FontProps) {
    return (
        <Styled.H5 color={props.color} textAlign={props.textAlign}>{props.text}</Styled.H5>
    )
}