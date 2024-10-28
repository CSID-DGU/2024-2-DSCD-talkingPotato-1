import {ReactElement} from "react";
import * as Styled from "./create-button.style";
import {Head1, SvgButton} from "@shared/components";
import {theme} from "@app/styles";

import WritingIcon from "@shared/assets/icons/Writing.svg";

interface props {
    onClick: () => void;
}

const CreateButton = (props: props): ReactElement => {

    return (
        <Styled.Button onClick={props.onClick}>
            <Head1 text={"칼럼 작성하기"} color={theme.colorSystem.white} cursor={"pointer"}/>
            <SvgButton src={WritingIcon} width={"24px"} height={"24px"}/>
        </Styled.Button>
    )
}

export default CreateButton;