import * as Styled from './style';
import React from "react";
import {useSideBarStore} from "@shared/store";
import {ExpandHeader} from "@shared/components/side-bar/expand";
import {DisposeHeader} from "@shared/components/side-bar/dispose";


export default function SideBar(): React.ReactElement {

    const {isExpanded} = useSideBarStore();

    return (
        <Styled.Container isExpanded={isExpanded}>
            {
                isExpanded ? (
                    <ExpandHeader/>
                ) : (
                    <DisposeHeader/>
                )
            }
        </Styled.Container>
    )
}