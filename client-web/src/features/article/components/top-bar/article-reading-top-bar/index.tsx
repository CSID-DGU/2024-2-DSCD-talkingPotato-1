import React from "react";
import * as Styled from "./style";

import Back from "@shared/assets/icons/Back.svg?react";
import {useConfirmMessage} from "@shared/lib";
import {Confirm, Head1, SizedBox, SvgIcon} from "@shared/components";
import {theme} from "@app/styles";

export default function ArticleReadingTopBar(): React.ReactElement {

    const {
        confirmMessage,
        confirmTitle,
        isConfirmOpen,
        setIsConfirmOpen,
        setConfirmMessage,
        setConfirmTitle,
    } = useConfirmMessage();

    const handleBack = () => {
        window.history.back();
    }

    const handleDelete = () => {
        console.log("delete");
        setConfirmTitle("해당 칼럼을 삭제 하시겠습니까?");
        setConfirmMessage("칼럼 삭제 시 댓글을 포함한 모든 내용이 사라지며 복구가 불가능합니다.\n\n주의해주세요.")
        setIsConfirmOpen(true);
    }

    const handleOnConfirm = () => {
        setIsConfirmOpen(false);
    }

    return (
        <Styled.Column>
            <Styled.Container>
                <Styled.Row>
                    <Styled.BackSection onClick={handleBack}>
                        <SvgIcon Icon={Back} color={theme.colorSystem.neutral["500"]} width={"27px"} height={"24px"}/>
                        <Head1 text={"뒤로가기"} color={theme.colorSystem.neutral["500"]} textAlign={"start"}
                               cursor={"pointer"}/>
                    </Styled.BackSection>
                    <Styled.ButtonWrapper onClick={handleDelete}>
                        <Head1 text={"삭제하기"} color={theme.colorSystem.red["500"]} textAlign={"end"} cursor={"pointer"}
                        />
                    </Styled.ButtonWrapper>
                </Styled.Row>
            </Styled.Container>
            <SizedBox height={"1px"} width={"100%"} background={theme.colorSystem.neutral["500"]}/>
            {
                isConfirmOpen && (
                    <Confirm title={confirmTitle} content={confirmMessage} onConfirm={handleOnConfirm}
                             onCancel={() => setIsConfirmOpen(false)}/>
                )
            }
        </Styled.Column>
    )
}