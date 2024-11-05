import * as Styled from "./sub3.style.ts";
import {FontProps} from "@shared/types";

const Sub3 = (props: FontProps) => {
    return (
        <Styled.Sub3 color={props.color} textAlign={props.textAlign} cursor={props.cursor}
                     onClick={props.onClick}>{props.text}</Styled.Sub3>
    )
}

export default Sub3;