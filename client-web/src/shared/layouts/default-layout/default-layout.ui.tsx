import React from 'react';

import * as Styled from "./default-layout.style.ts";

interface props {
    children: React.ReactNode;
}

const DefaultLayout = (props: props) => {
    return (
        <Styled.Container>
            {props.children}
        </Styled.Container>
    )
}

export default DefaultLayout;