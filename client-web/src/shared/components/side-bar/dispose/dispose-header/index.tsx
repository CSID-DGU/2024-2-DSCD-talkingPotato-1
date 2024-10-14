import React from "react";
import * as Styled from "./style.ts";

import {useNavigate} from "react-router-dom";
import {useSideBarStore} from "@shared/store";
import {SideBarPage} from "@shared/types";
import {getPageRoute} from "@shared/utils";
import {SizedBox, SvgButton} from "@shared/components";
import {DisposeItem} from "@shared/components/side-bar/dispose";

import ExpandChevron from "@shared/assets/icons/ExpandChevron.svg";
import Home from "@shared/assets/icons/Home.svg?react"
import Article from "@shared/assets/icons/Article.svg?react"
import Question from "@shared/assets/icons/Question.svg?react"

export default function DisposeHeader(): React.ReactElement {

    const {toggleExpand, updatePage} = useSideBarStore();
    const navigate = useNavigate();

    const handlePageUpdate = (page: SideBarPage) => {
        updatePage(page);
        navigate(getPageRoute(page));
    }

    return (
        <Styled.Container>
            <SvgButton src={ExpandChevron} width={"28px"} height={"28px"} onClick={toggleExpand}/>
            <SizedBox height={"128px"}/>
            <DisposeItem Icon={Home} type={"dashboard"} onClick={() => handlePageUpdate("dashboard")} width={"27.967px"}
                         height={"28px"}/>
            <SizedBox height={"8px"}/>
            <DisposeItem Icon={Article} type={"article"} onClick={() => handlePageUpdate("article")}
                         width={"34.222223px"}
                         height={"28px"}/>
            <SizedBox height={"8px"}/>
            <DisposeItem Icon={Question} type={"question"} onClick={() => handlePageUpdate("question")}
                         width={"28.85px"}
                         height={"28px"}/>
        </Styled.Container>
    )
}
