import {styled} from "styled-components";
import {FontProps} from "@shared/types";
import {theme} from "@app/styles";

export const H6 = styled.div<FontProps>`
    color: ${(props) => props.color || theme.colorSystem.black};
    font-size: ${theme.fontSystem.h6.fontSize};
    font-weight: ${theme.fontSystem.h6.fontWeight};
    line-height: ${theme.fontSystem.h6.lineHeight};
    text-align: ${(props) => props.textAlign || "center"};
    white-space: pre-wrap;
`;