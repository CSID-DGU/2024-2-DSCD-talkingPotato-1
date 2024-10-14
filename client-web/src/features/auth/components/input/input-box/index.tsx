import React from "react";
import * as Styled from './style';
import EyeIcon from "@shared/assets/icons/eye_svgrepo.svg";
import {SvgButton} from "@shared/components";

interface props {
    placeholder: string;
    type: string;
    onChange: (e: React.ChangeEvent<HTMLInputElement>) => void;
    isPassword?: boolean;
}

export default function InputBox(props: props): React.ReactElement {
    return (
        <Styled.Container type={props.type} placeholder={props.placeholder} onChange={props.onChange}>
            {props.isPassword &&
                <SvgButton src={EyeIcon} width={"24px"} height={"24px"} onClick={() => console.log("click")}/>}
        </Styled.Container>
    );
}