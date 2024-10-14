import React, {useEffect, useState} from "react";
import * as Styled from './style';
import {useNavigate} from "react-router-dom";
import {useAlertMessage} from "@shared/lib";
import {CONSTANTS} from "@app/constants/constants.ts";
import {DefaultLayout} from "@shared/layouts";
import {Alert, RoundButton, SizedBox} from "@shared/components";
import {theme} from "@app/styles";
import {Input} from "@features/auth/components";

export default function Login(): React.ReactElement {

    const [email, setEmail] = useState<string>("");
    const [password, setPassword] = useState<string>("");
    const [isValid, setIsValid] = useState<boolean>(false);
    const {isAlertOpen, alertMessage, setIsAlertOpen, setAlertMessage} = useAlertMessage();

    const navigate = useNavigate();

    const handleEmail = (e: React.ChangeEvent<HTMLInputElement>) => {
        setEmail(e.target.value);
    }

    const handlePassword = (e: React.ChangeEvent<HTMLInputElement>) => {
        setPassword(e.target.value);
    }

    const handleLogin = () => {

        if (isValid) {
            navigate(CONSTANTS.ROUTER.DASHBOARD);
        } else {
            setIsAlertOpen(true);
            setAlertMessage("이메일과 비밀번호를 확인해주세요.");
        }
    }

    useEffect(() => {
        if (CONSTANTS.REGEX.EMAIL.test(email) && CONSTANTS.REGEX.PASSWORD.test(password)) {
            setIsValid(true);
        } else {
            setIsValid(false);
        }
    }, [email, password]);

    return (
        <DefaultLayout>
            <Styled.Container>
                <Styled.InputContainer>
                    <Input text={"이메일"} type={"email"} placeholder={"이메일을 입력해주세요."} onChange={handleEmail}/>
                    <SizedBox height={"48px"}/>
                    <Input text={"비밀번호"} type={"password"} placeholder={"비밀번호를 입력해주세요."} onChange={handlePassword}/>
                </Styled.InputContainer>
                <SizedBox height={"60px"}/>
                <RoundButton backgroundColor={theme.colorSystem.secondary["500"]} onClick={handleLogin}/>
                {
                    isAlertOpen && <Alert title={alertMessage} onClick={() => setIsAlertOpen(false)}/>
                }
            </Styled.Container>
        </DefaultLayout>
    )
}