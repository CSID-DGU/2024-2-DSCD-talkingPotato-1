import React from "react";
import * as Styled from "./style";
import {useConfirmMessage} from "@shared/lib";
import {Confirm, HeadExtra, RectangleButton, SizedBox} from "@shared/components";
import {theme} from "@app/styles";

export default function ArticleWritingTopBar(): React.ReactElement {

    const {
        isConfirmOpen,
        confirmTitle,
        setIsConfirmOpen,
        setConfirmMessage,
        setConfirmTitle,
        confirmMessage
    } = useConfirmMessage();

    const onConfirm = () => {
        window.history.back();
    }

    const handleCancelButton = () => {
        setIsConfirmOpen(true);
        setConfirmTitle("작성중인 칼럼을 삭제하시겠습니까?");
        setConfirmMessage("작성중인 칼럼은 저장되지 않습니다.");
    }

    return (
        <Styled.Column>
            <Styled.Container>
                <Styled.Row>
                    <HeadExtra text={"칼럼 작성하기"} textAlign={"start"}/>
                    <Styled.SearchSection>
                        <RectangleButton content={"취소"} backgroundColor={theme.colorSystem.red["600"]}
                                         borderRadius={"12px"} width={"96px"} height={"48px"}
                                         onClick={handleCancelButton}/>
                        <SizedBox width={"12px"}/>
                        <RectangleButton content={"등록"} backgroundColor={theme.colorSystem.secondary["500"]}
                                         borderRadius={"12px"} width={"96px"} height={"48px"}/>
                    </Styled.SearchSection>
                </Styled.Row>
            </Styled.Container>
            <SizedBox height={"1px"} width={"100%"} background={theme.colorSystem.neutral["500"]}/>
            {
                isConfirmOpen && (
                    <Confirm title={confirmTitle} content={confirmMessage} onCancel={() => setIsConfirmOpen(false)}
                             onConfirm={onConfirm}/>
                )
            }
        </Styled.Column>
    )
}