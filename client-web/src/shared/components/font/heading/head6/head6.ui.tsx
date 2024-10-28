import * as Styled from "./head6.style.ts";
import {FontProps} from "@shared/types";

const Head6 = (props: FontProps) => {
    return (
        <Styled.H6 color={props.color} textAlign={props.textAlign}>{props.text}</Styled.H6>
    )
}

export default Head6;