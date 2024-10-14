import React from 'react';

import * as Styled from "./style";
import {SideBar} from "@shared/components";

interface props {
    children: React.ReactNode;
}

export default function RootLayout(props: props) {

    return (
        <Styled.Container>
            <SideBar/>
            {props.children}
        </Styled.Container>
    )
}

