import * as Styled from "./sub2.style.ts";
import {FontProps} from "@shared/types";

const Sub2 = (props: FontProps) => {
    return (
        <Styled.Sub2 color={props.color} whiteSpace={props.whiteSpace}
                     textAlign={props.textAlign}>{props.text}</Styled.Sub2>
    )
}

export default Sub2;