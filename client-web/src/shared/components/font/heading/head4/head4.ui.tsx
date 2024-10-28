import * as Styled from "./head4.style.ts";
import {FontProps} from "@shared/types";

const Head4 = (props: FontProps) => {
    return (
        <Styled.H4 color={props.color} textAlign={props.textAlign}>{props.text}</Styled.H4>
    )
}

export default Head4;