import * as Styled from './round-button.style.ts';
import {ReactElement} from "react";
import {Head1} from "@shared/components";
import {theme} from "@app/styles";

interface props {
    backgroundColor?: string;
    onClick: () => void;
}

const RoundButton = (props: props): ReactElement => {
    return (
        <Styled.Container onClick={props.onClick} backgroundColor={props.backgroundColor}>
            <Head1 text={"로그인"} textAlign={"center"} color={theme.colorSystem.white}/>
        </Styled.Container>
    );
}

export default RoundButton;