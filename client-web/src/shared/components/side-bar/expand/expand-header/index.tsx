import React from "react";
import * as Styled from "./style.ts";
import DisposeChevron from "@shared/assets/icons/DisposeChevron.svg";
import Setting from "@shared/assets/icons/Setting.svg";

import Home from "@shared/assets/icons/Home.svg?react"
import Article from "@shared/assets/icons/Article.svg?react"
import Question from "@shared/assets/icons/Question.svg?react"
import {useNavigate} from "react-router-dom";
import {useSideBarStore} from "@shared/store";
import {SideBarPage} from "@shared/types";
import {getPageRoute} from "@shared/utils";
import {Head3, Head6, SizedBox, Spacer, SvgButton} from "@shared/components";
import {theme} from "@app/styles";
import {ExpandItem} from "@shared/components/side-bar/expand";

export default function ExpandHeader(): React.ReactElement {

    const {toggleExpand, updatePage} = useSideBarStore();

    const navigate = useNavigate();

    const handlePageUpdate = (page: SideBarPage) => {
        updatePage(page);
        navigate(getPageRoute(page));
    }

    return (
        <Styled.Container>
            <Styled.Row>
                <Spacer flex={1} direction={"horizontal"}/>
                <SvgButton src={DisposeChevron} width={"28px"} height={"28px"} onClick={toggleExpand}/>
            </Styled.Row>
            <SizedBox height={"20px"}/>
            <Styled.Row>
                <Styled.Column>
                    <Head6 text={"환영합니다,"} color={theme.colorSystem.white} textAlign={"start"}/>
                    <Head3 text={"전문가님"} color={theme.colorSystem.white} textAlign={"start"}/>
                </Styled.Column>
                <SvgButton src={Setting} width={"60px"} height={"60px"}/>
            </Styled.Row>
            <SizedBox height={"60px"}/>
            <ExpandItem Icon={Home} type={"dashboard"} sizedBoxWidth={"20.03px"}
                        onClick={() => handlePageUpdate("dashboard")}
                        width={"27.967px"}
                        height={"28px"}/>
            <SizedBox height={"8px"}/>
            <ExpandItem Icon={Article} type={"article"} sizedBoxWidth={"13.78px"}
                        onClick={() => handlePageUpdate("article")}
                        width={"34.222223px"}
                        height={"28px"}/>
            <SizedBox height={"8px"}/>
            <ExpandItem Icon={Question} type={"question"} sizedBoxWidth={"19.15px"}
                        onClick={() => handlePageUpdate("question")} width={"28.85px"}
                        height={"28px"}/>
        </Styled.Container>
    )
}