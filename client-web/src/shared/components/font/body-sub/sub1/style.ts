import {styled} from "styled-components";
import {FontProps} from "@shared/types";
import {theme} from "@app/styles";

export const Sub1 = styled.div<FontProps>`
    color: ${(props) => props.color || theme.colorSystem.black};
    font-size: ${theme.fontSystem.sub1.fontSize};
    font-weight: ${theme.fontSystem.sub1.fontWeight};
    line-height: ${theme.fontSystem.sub1.lineHeight};
    text-align: ${(props) => props.textAlign || "center"};
    white-space: pre-wrap;
`;