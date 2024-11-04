import {ChangeEvent, ReactElement, useEffect, useState} from "react";
import {DefaultLayout} from "@shared/layouts";
import * as Styled from "./register.style";
import {RegisterTopBar} from "@features/auth/register";
import {RegisterForm} from "@features/auth";

/**
 * Todo: Register Form Password Visibility
 */

const Register = (): ReactElement => {

    const [name, setName] = useState<string>("");
    const [serialId, setSerialId] = useState<string>("");
    const [domain, setDomain] = useState<string>("");
    const [email, setEmail] = useState<string>("");
    const [verificationCode, setVerificationCode] = useState<string>("");
    const [temporaryToken, setTemporaryToken] = useState<string>("");
    const [password, setPassword] = useState<string>("");
    const [passwordConfirm, setPasswordConfirm] = useState<string>("");
    const [history, setHistory] = useState<string>("");

    const handleNameChange = (e: ChangeEvent<HTMLInputElement>) => {
        setName(e.target.value);
    }

    const handleSerialIdChange = (e: ChangeEvent<HTMLInputElement>) => {
        setSerialId(e.target.value);
    }

    const handleDomainChange = (e: ChangeEvent<HTMLInputElement>) => {
        setDomain(e.target.value);
    }

    const handleVerificationCodeChange = (e: ChangeEvent<HTMLInputElement>) => {
        setVerificationCode(e.target.value);
    }

    const handlePasswordChange = (e: ChangeEvent<HTMLInputElement>) => {
        setPassword(e.target.value);
    }

    const handlePasswordConfirmChange = (e: ChangeEvent<HTMLInputElement>) => {
        setPasswordConfirm(e.target.value);
    }

    const handleHistoryChange = (e: ChangeEvent<HTMLTextAreaElement>) => {
        setHistory(e.target.value);
    }

    useEffect(() => {
        setEmail(`${serialId}@${domain}`);
    }, [serialId, domain]);

    return (
        <DefaultLayout>
            <RegisterTopBar/>
            <Styled.Container>
                <RegisterForm
                    name={name}
                    handleNameChange={handleNameChange}
                    serialId={serialId}
                    handleSerialIdChange={handleSerialIdChange}
                    domain={domain}
                    handleDomainChange={handleDomainChange}
                    verificationCode={verificationCode}
                    handleVerificationCodeChange={handleVerificationCodeChange}
                    password={password}
                    handlePasswordChange={handlePasswordChange}
                    passwordConfirm={passwordConfirm}
                    handlePasswordConfirmChange={handlePasswordConfirmChange}
                    history={history}
                    handleHistoryChange={handleHistoryChange}
                    handleRegister={() => {
                    }}
                />
            </Styled.Container>
        </DefaultLayout>
    )
}

export default Register;