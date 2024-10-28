import React from 'react';

import * as Styled from "./root-layout.style.ts";
import {SideBar} from "@shared/components";
import {useSideBarStore} from "@shared/store";

interface props {
    children: React.ReactNode;
}

export default function RootLayout(props: props) {

    const isExpanded = useSideBarStore(state => state.isExpanded);

    return (
        <Styled.Container>
            <SideBar/>
            <Styled.Column isExpanded={isExpanded}>
                {props.children}
            </Styled.Column>
        </Styled.Container>
    )
}

