import React from 'react';

import * as Styled from "./style";

interface props {
    children: React.ReactNode;
}

export default function DefaultLayout(props: props) {

    return (
        <Styled.Container>
            {props.children}
        </Styled.Container>
    )
}

