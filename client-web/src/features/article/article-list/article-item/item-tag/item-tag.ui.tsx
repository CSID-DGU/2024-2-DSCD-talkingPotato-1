import {ReactElement} from "react";
import * as Styled from "./item-tag.style";
import {Sub2} from "@shared/components";
import {theme} from "@app/styles";

interface props {
    tag: string;
    isFirst: boolean;
}

const ItemTag = (props: props): ReactElement => {
    return (
        <Styled.Container isFirst={props.isFirst}>
            <Sub2 text={props.tag} textAlign={"center"} color={theme.colorSystem.primary["500"]}/>
        </Styled.Container>
    )
}

export default ItemTag;