import * as Styled from "./head2.style.ts";
import {FontProps} from "@shared/types";

const Head3 = (props: FontProps) => {
    return (
        <Styled.H3 color={props.color} textAlign={props.textAlign}>{props.text}</Styled.H3>
    )
}

export default Head3;