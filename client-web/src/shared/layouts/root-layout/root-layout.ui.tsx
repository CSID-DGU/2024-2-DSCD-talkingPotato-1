import React from 'react';

import * as Styled from "./root-layout.style.ts";
import {SideBar} from "@shared/components";

interface props {
    children: React.ReactNode;
}

const RootLayout = (props: props) => {
    return (
        <Styled.Container>
            <SideBar/>
            {props.children}
        </Styled.Container>
    )
}

export default RootLayout;