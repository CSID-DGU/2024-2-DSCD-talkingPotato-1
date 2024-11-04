import {ChangeEvent, ReactElement} from "react";
import * as Styled from "./register-form.style";
import {Head0, Head1, Head6, SizedBox} from "@shared/components";
import {theme} from "@app/styles";

interface props {
    name: string;
    handleNameChange: (e: ChangeEvent<HTMLInputElement>) => void;
    serialId: string;
    handleSerialIdChange: (e: ChangeEvent<HTMLInputElement>) => void;
    domain: string;
    handleDomainChange: (e: ChangeEvent<HTMLInputElement>) => void;
    verificationCode: string;
    handleVerificationCodeChange: (e: ChangeEvent<HTMLInputElement>) => void;
    password: string;
    handlePasswordChange: (e: ChangeEvent<HTMLInputElement>) => void;
    passwordConfirm: string;
    handlePasswordConfirmChange: (e: ChangeEvent<HTMLInputElement>) => void;
    history: string;
    handleHistoryChange: (e: ChangeEvent<HTMLTextAreaElement>) => void;
    handleRegister: () => void;
}

const RegisterForm = (props: props): ReactElement => {

    return (
        <Styled.Container>
            <Head0 text={"회원가입"} color={theme.colorSystem.black} textAlign={"start"}/>
            <SizedBox height={"60px"}/>
            <Head6 text={"이름"} color={theme.colorSystem.neutral["500"]} textAlign={"start"}/>
            <Styled.Input value={props.name} onChange={props.handleNameChange} placeholder={"이름을 입력해주세요."}/>
            <SizedBox height={"32px"}/>
            <Head6 text={"이메일"} color={theme.colorSystem.neutral["500"]} textAlign={"start"}/>
            <Styled.Row>
                <Styled.Input value={props.serialId} onChange={props.handleSerialIdChange}
                              placeholder={"이메일을 입력해주세요."}/>
                <Head6 text={"@"} color={theme.colorSystem.neutral["500"]}/>
                <Styled.Input value={props.domain} onChange={props.handleDomainChange} placeholder={"도메인을 입력해주세요"}/>
                <Styled.RectangleButton>
                    <Head1 text={"인증번호 받기"} color={theme.colorSystem.white} cursor={"pointer"}/>
                </Styled.RectangleButton>
            </Styled.Row>
            <SizedBox height={"32px"}/>
            <Head6 text={"인증번호"} color={theme.colorSystem.neutral["500"]} textAlign={"start"}/>
            <Styled.Row>
                <Styled.Input value={props.verificationCode} onChange={props.handleVerificationCodeChange}
                              placeholder={"인증번호를 입력해주세요."}/>
                <Styled.RectangleButton>
                    <Head1 text={"인증하기"} color={theme.colorSystem.white} cursor={"pointer"}/>
                </Styled.RectangleButton>
            </Styled.Row>
            <SizedBox height={"32px"}/>
            <Head6 text={"비밀번호"} color={theme.colorSystem.neutral["500"]} textAlign={"start"}/>
            <Styled.Input value={props.password} onChange={props.handlePasswordChange} placeholder={"비밀번호를 입력해주세요."}/>
            <SizedBox height={"32px"}/>
            <Head6 text={"비밀번호 확인"} color={theme.colorSystem.neutral["500"]} textAlign={"start"}/>
            <Styled.Input value={props.passwordConfirm} onChange={props.handlePasswordConfirmChange}
                          placeholder={"비밀번호를 입력해주세요."}/>
            <SizedBox height={"32px"}/>
            <Head6 text={"경력"} color={theme.colorSystem.neutral["500"]} textAlign={"start"}/>
            <Styled.TextArea placeholder={"경력을 입력해주세요"} value={props.history} onChange={props.handleHistoryChange}/>
            <Styled.RegisterButton onClick={props.handleRegister}>
                <Head1 text={"가입하기"} color={theme.colorSystem.white} cursor={"pointer"}/>
            </Styled.RegisterButton>
        </Styled.Container>
    );
}

export default RegisterForm;