import * as Styled from "./head0.style.ts";
import {FontProps} from "@shared/types";

const Head0 = (props: FontProps) => {
    return (
        <Styled.H0 color={props.color} textAlign={props.textAlign}>{props.text}</Styled.H0>
    )
}

export default Head0;