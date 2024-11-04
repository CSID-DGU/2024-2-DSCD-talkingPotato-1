import * as Styled from "./login-header.style";
import {ReactElement} from "react";
import SvgLogo from "@shared/assets/icons/Title.svg";
import {Head4, Head6, Spacer} from "@shared/components";
import {theme} from "@app/styles";
import {useNavigate} from "react-router-dom";
import {CONSTANTS} from "@app/constants/constants.ts";

const LoginHeader = (): ReactElement => {

    const navigate = useNavigate();

    const handleRegister = () => {
        navigate(CONSTANTS.ROUTER.REGISTER);
    }

    return (
        <Styled.Container>
            <Styled.SvgLogo src={SvgLogo}/>
            <Styled.BottomRow>
                <Spacer flex={1} direction={"horizontal"}/>
                <Styled.InnerRow>
                    <Head6 text={"아이디가 없으신가요?"} color={theme.colorSystem.neutral["500"]}/>
                    <Head4 text={"회원가입"} color={theme.colorSystem.primary["500"]} cursor={"pointer"}
                           onClick={handleRegister}/>
                </Styled.InnerRow>
            </Styled.BottomRow>
        </Styled.Container>
    )
}

export default LoginHeader;