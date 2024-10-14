import * as Styled from './style.ts'
import {theme} from "@app/styles";
import {Head4} from "@shared/components";

interface props {
    title: string;
    onClick: () => void;
}

export default function Alert(props: props) {

    return (
        <Styled.Overlay onClick={props.onClick}>
            <Styled.Container onClick={(e) => e.stopPropagation()}>
                <Head4 text={props.title} color={theme.colorSystem.neutral["900"]}/>
                <Styled.ButtonContainer>
                    <Styled.StyledButton onClick={props.onClick}>
                        <Head4 text={"확인"} color={theme.colorSystem.white}/>
                    </Styled.StyledButton>
                </Styled.ButtonContainer>
            </Styled.Container>
        </Styled.Overlay>
    )
}