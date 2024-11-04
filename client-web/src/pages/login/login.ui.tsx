import {ChangeEvent, ReactElement, useState} from "react";
import * as Styled from './login.style.ts';
import {DefaultLayout} from "@shared/layouts";
import {LoginForm, LoginHeader} from "@features/auth";

/**
 * Todo: Password Visibility
 */

const Login = (): ReactElement => {

    const [serialId, setSerialId] = useState<string>("");
    const [password, setPassword] = useState<string>("");

    const handleSerialIdChange = (e: ChangeEvent<HTMLInputElement>) => {
        setSerialId(e.target.value);
    }

    const handlePasswordChange = (e: ChangeEvent<HTMLInputElement>) => {
        setPassword(e.target.value);
    }

    return (
        <DefaultLayout>
            <Styled.Container>
                <LoginHeader/>
                <LoginForm serialId={serialId} password={password} handleSerialIdChange={handleSerialIdChange}
                           handlePasswordChange={handlePasswordChange}/>
            </Styled.Container>
        </DefaultLayout>
    )
}

export default Login;