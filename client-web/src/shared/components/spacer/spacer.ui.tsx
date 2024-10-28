import * as Styled from "./spacer.style.ts";
import React from "react";

type Direction = "horizontal" | "vertical";

interface SpacerProps {
    flex: number;
    direction: Direction;
}

export default function Spacer(props: SpacerProps): React.ReactElement {
    return (
        <Styled.Spacer flex={props.flex} direction={props.direction}/>
    )
}