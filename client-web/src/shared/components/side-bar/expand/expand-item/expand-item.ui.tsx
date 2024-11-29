import React from "react";
import * as Styled from "./expand-item.style.ts";
import {useSideBarStore} from "@shared/store";
import {SideBarPage} from "@shared/types";
import {Head4, SizedBox, SvgIcon} from "@shared/components";
import {theme} from "@app/styles";

interface props {
    Icon: React.FunctionComponent<React.SVGProps<SVGSVGElement>>;
    onClick: () => void;
    width: string;
    height: string;
    type: SideBarPage;
    sizedBoxWidth?: string;
}

export default function ExpandItem(props: props): React.ReactElement {

    const {currentPage} = useSideBarStore();

    const text = props.type == "article" ? "칼럼" : "질문";

    return (
        <Styled.Container isSelected={currentPage == props.type} onClick={props.onClick}>
            <Styled.Row>
                <SvgIcon Icon={props.Icon}
                         color={currentPage == props.type ? theme.colorSystem.primary["500"] : theme.colorSystem.white}
                         height={props.height}
                         width={props.width} onClick={props.onClick}/>
                <SizedBox width={props.sizedBoxWidth}/>
                <Head4 text={text}
                       color={currentPage == props.type ? theme.colorSystem.primary["500"] : theme.colorSystem.white}/>
            </Styled.Row>
        </Styled.Container>
    )
}