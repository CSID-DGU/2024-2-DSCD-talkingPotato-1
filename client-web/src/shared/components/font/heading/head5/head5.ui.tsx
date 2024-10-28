import * as Styled from "./head5.style.ts";
import {FontProps} from "@shared/types";

const Head5 = (props: FontProps) => {
    return (
        <Styled.H5 color={props.color} textAlign={props.textAlign}>{props.text}</Styled.H5>
    )
}

export default Head5;