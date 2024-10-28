import * as Styled from "./head-e.style.ts";
import {FontProps} from "@shared/types";

const HeadExtra = (props: FontProps) => {
    return (
        <Styled.HE color={props.color} textAlign={props.textAlign}>{props.text}</Styled.HE>
    )
}

export default HeadExtra;