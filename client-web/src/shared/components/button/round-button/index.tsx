import * as Styled from './style';
import {ReactElement} from "react";
import {Head1} from "@shared/components";
import {theme} from "@app/styles";

interface props {
    backgroundColor?: string;
    onClick: () => void;
}

export default function RoundButton(props: props): ReactElement {
    return (
        <Styled.Container onClick={props.onClick} backgroundColor={props.backgroundColor}>
            <Head1 text={"로그인"} textAlign={"center"} color={theme.colorSystem.white}/>
        </Styled.Container>
    );
}