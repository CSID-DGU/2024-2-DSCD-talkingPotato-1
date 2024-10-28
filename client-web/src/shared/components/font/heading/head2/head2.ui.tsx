import * as Styled from "./head2.style.ts";
import {FontProps} from "@shared/types";

const Head2 = (props: FontProps) => {
    return (
        <Styled.H2 color={props.color} textAlign={props.textAlign}>{props.text}</Styled.H2>
    )
}

export default Head2;