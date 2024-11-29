import { ReactElement } from "react";
import { useConfirmMessage } from "@shared/lib";
import {
  Confirm,
  HeadExtra,
  RectangleButton,
  SizedBox,
} from "@shared/components";
import { theme } from "@app/styles";
import { useNavigate } from "react-router-dom";
import { CONSTANTS } from "@app/constants/constants.ts";
import * as Styled from "./article-create-top-bar.style";

interface IArticleCreateTopBarProps {
  handleCreateArticle: () => void;
}

export const ArticleCreateTopBar = (
  props: IArticleCreateTopBarProps
): ReactElement => {
  const navigate = useNavigate();

  const {
    isConfirmOpen,
    confirmTitle,
    setIsConfirmOpen,
    setConfirmMessage,
    setConfirmTitle,
    confirmMessage,
  } = useConfirmMessage();

  const onConfirm = () => {
    navigate(CONSTANTS.ROUTER.ARTICLE);
  };

  const handleCancelButton = () => {
    setIsConfirmOpen(true);
    setConfirmTitle("작성중인 칼럼을 삭제하시겠습니까?");
    setConfirmMessage("작성중인 칼럼은 저장되지 않습니다.");
  };

  return (
    <Styled.Column>
      <Styled.Container>
        <Styled.Row>
          <HeadExtra text={"칼럼 작성하기"} textAlign={"start"} />
          <Styled.SearchSection>
            <RectangleButton
              content={"취소"}
              backgroundColor={theme.colorSystem.red["600"]}
              borderRadius={"12px"}
              width={"96px"}
              height={"48px"}
              onClick={handleCancelButton}
            />
            <SizedBox width={"12px"} />
            <RectangleButton
              content={"등록"}
              backgroundColor={theme.colorSystem.secondary["500"]}
              borderRadius={"12px"}
              width={"96px"}
              height={"48px"}
              onClick={props.handleCreateArticle}
            />
          </Styled.SearchSection>
        </Styled.Row>
      </Styled.Container>
      <SizedBox
        height={"1px"}
        width={"100%"}
        background={theme.colorSystem.neutral["700"]}
      />
      {isConfirmOpen && (
        <Confirm
          title={confirmTitle}
          content={confirmMessage}
          onCancel={() => setIsConfirmOpen(false)}
          onConfirm={onConfirm}
        />
      )}
    </Styled.Column>
  );
};

export default ArticleCreateTopBar;
