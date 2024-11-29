import { Dispatch, ReactElement, SetStateAction } from "react";
import * as Styled from "./create-content-input.style.ts";
import { SizedBox, Sub2 } from "@shared/components";
import { theme } from "@app/styles";
import { MarkdownEditor } from "@shared/components/markdown-editor/markdown-editor.ui.tsx";

interface props {
  markdownValue: string | undefined;
  setMarkdownValue: Dispatch<SetStateAction<string | undefined>>;
}

export const CreateContentInput = (props: props): ReactElement => {
  return (
    <Styled.Container>
      <Styled.LabelWithLine>
        <Sub2
          text={"내용"}
          color={theme.colorSystem.primary["500"]}
          whiteSpace={"nowrap"}
        />
        <SizedBox width={"12px"} />
        <SizedBox
          height={"1px"}
          width={"100%"}
          background={theme.colorSystem.primary["500"]}
        />
      </Styled.LabelWithLine>
      <SizedBox height={"20px"} />
      <MarkdownEditor
        markdownValue={props.markdownValue}
        setMarkdownValue={props.setMarkdownValue}
      />
    </Styled.Container>
  );
};

export default CreateContentInput;
