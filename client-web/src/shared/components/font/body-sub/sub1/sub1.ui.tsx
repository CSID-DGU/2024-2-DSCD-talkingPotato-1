import * as Styled from "./sub1.style.ts";
import {FontProps} from "@shared/types";

const Sub1 = (props: FontProps) => {
    return (
        <Styled.Sub1 color={props.color} textAlign={props.textAlign}>{props.text}</Styled.Sub1>
    )
}

export default Sub1;