import {ReactElement} from "react";
import {useNavigate} from "react-router-dom";
import {CONSTANTS} from "@app/constants/constants.ts";

import * as Styled from "./waiting-top-bar.style"
import Back from "@shared/assets/icons/Back.svg?react";
import {Head1, SizedBox, SvgIcon} from "@shared/components";
import {theme} from "@app/styles";

export const WaitingTopBar = (): ReactElement => {

    const navigate = useNavigate();

    const handleBack = () => {
        navigate(CONSTANTS.ROUTER.LOGIN);
    }

    return (
        <Styled.Column>
            <Styled.Container>
                <Styled.Row>
                    <Styled.BackSection onClick={handleBack}>
                        <SvgIcon Icon={Back} color={theme.colorSystem.neutral["500"]} width={"27px"} height={"24px"}/>
                        <Head1 text={"뒤로가기"} color={theme.colorSystem.neutral["500"]} textAlign={"start"}
                               cursor={"pointer"}/>
                    </Styled.BackSection>
                </Styled.Row>
            </Styled.Container>
            <SizedBox height={"1px"} width={"100%"} background={theme.colorSystem.neutral["700"]}/>
        </Styled.Column>
    )
}

export default WaitingTopBar;