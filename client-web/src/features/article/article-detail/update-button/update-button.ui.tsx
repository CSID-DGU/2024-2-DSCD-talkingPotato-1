import {ReactElement} from "react";
import * as Styled from "./update-button.style";
import {Head1, SvgButton} from "@shared/components";
import {theme} from "@app/styles";

import WritingIcon from "@shared/assets/icons/Writing.svg";

interface props {
    onClick: () => void;
}

const UpdateButton = (props: props): ReactElement => {

    return (
        <Styled.Button onClick={props.onClick}>
            <Head1 text={"칼럼 수정하기"} color={theme.colorSystem.white} cursor={"pointer"}/>
            <SvgButton src={WritingIcon} width={"24px"} height={"24px"}/>
        </Styled.Button>
    )
}

export default UpdateButton;