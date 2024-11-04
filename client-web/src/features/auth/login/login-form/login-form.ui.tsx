import {ChangeEvent, ReactElement} from "react";
import * as Styled from "./login-form.style";
import {Head0, Head1, Head4, Head6, SizedBox} from "@shared/components";
import {theme} from "@app/styles";

interface props {
    serialId: string;
    password: string;
    handleSerialIdChange: (e: ChangeEvent<HTMLInputElement>) => void;
    handlePasswordChange: (e: ChangeEvent<HTMLInputElement>) => void;
}

const LoginForm = (props: props): ReactElement => {

    return (
        <Styled.Container>
            <Head0 text={"로그인"} color={theme.colorSystem.black} textAlign={"start"}/>
            <SizedBox height={"60px"}/>
            <Head6 text={"이메일"} color={theme.colorSystem.neutral["400"]} textAlign={"start"}/>
            <Styled.Input value={props.serialId} onChange={props.handleSerialIdChange} placeholder={"이메일을 입력해주세요."}/>
            <SizedBox height={"60px"}/>
            <Head6 text={"비밀번호"} color={theme.colorSystem.neutral["400"]} textAlign={"start"}/>
            <Styled.Input value={props.password} onChange={props.handlePasswordChange} placeholder={"비밀번호를 입력해주세요."}
                          type={"password"}/>
            <SizedBox height={"60px"}/>
            <Styled.LoginButton>
                <Head1 text={"로그인"} color={theme.colorSystem.white} cursor={"pointer"}/>
            </Styled.LoginButton>
            <Styled.BottomRow>
                <Head6 text={"비밀번호를 잃어버리셨나요?"} color={theme.colorSystem.neutral["500"]}/>
                <Head4 text={"비밀번호 재발급"} color={theme.colorSystem.neutral["300"]} cursor={"pointer"}/>
            </Styled.BottomRow>
        </Styled.Container>
    )
}

export default LoginForm;