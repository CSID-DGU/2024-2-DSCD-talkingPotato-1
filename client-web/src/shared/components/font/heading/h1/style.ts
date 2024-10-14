import {styled} from "styled-components";
import {FontProps} from "@shared/types";
import {theme} from "@app/styles";

export const H1 = styled.div<FontProps>`
    color: ${(props) => props.color || theme.colorSystem.black};
    font-size: ${theme.fontSystem.h1.fontSize};
    font-weight: ${theme.fontSystem.h1.fontWeight};
    line-height: ${theme.fontSystem.h1.lineHeight};
    text-align: ${(props) => props.textAlign || "center"};
    white-space: pre-wrap;

    cursor: ${(props) => props.cursor || "default"};
`;