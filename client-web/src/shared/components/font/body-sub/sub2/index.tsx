import * as Styled from "./style";
import {FontProps} from "@shared/types";

export default function Sub2(props: FontProps) {
    return (
        <Styled.Sub2 color={props.color} whiteSpace={props.whiteSpace}
                     textAlign={props.textAlign}>{props.text}</Styled.Sub2>
    )
}