import {ReactElement} from "react";
import * as Styled from "./waiting.style";
import {DefaultLayout} from "@shared/layouts";
import {WaitingTopBar} from "@features/auth";
import WaitingLogo from "@shared/assets/icons/Waiting.svg";

const Waiting = (): ReactElement => {
    return (
        <DefaultLayout>
            <WaitingTopBar/>
            <Styled.Container>
                <Styled.SvgLogo src={WaitingLogo}/>
            </Styled.Container>
        </DefaultLayout>
    )
}

export default Waiting;