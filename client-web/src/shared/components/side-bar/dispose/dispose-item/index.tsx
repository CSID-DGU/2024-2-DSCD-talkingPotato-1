import React from "react";
import * as Styled from "./style.ts";
import {useSideBarStore} from "@shared/store";
import {SideBarPage} from "@shared/types";
import {SvgIcon} from "@shared/components";
import {theme} from "@app/styles";

interface props {
    Icon: React.FunctionComponent<React.SVGProps<SVGSVGElement>>;
    onClick: () => void
    width: string
    height: string
    type: SideBarPage
}

export default function DisposeItem(props: props): React.ReactElement {

    const {currentPage} = useSideBarStore();

    return (
        <Styled.Container isSelected={currentPage == props.type} onClick={props.onClick}>
            <SvgIcon Icon={props.Icon}
                     color={currentPage == props.type ? theme.colorSystem.primary["500"] : theme.colorSystem.white}
                     height={props.height}
                     width={props.width} onClick={props.onClick}/>
        </Styled.Container>
    )
}