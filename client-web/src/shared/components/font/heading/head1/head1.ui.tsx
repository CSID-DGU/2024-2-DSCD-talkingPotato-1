import * as Styled from "./head1.style.ts";
import {FontProps} from "@shared/types";

const Head1 = (props: FontProps) => {
    return (
        <Styled.H1 color={props.color} textAlign={props.textAlign} cursor={props.cursor}>{props.text}</Styled.H1>
    )
}

export default Head1;