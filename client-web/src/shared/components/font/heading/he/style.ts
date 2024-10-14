import {styled} from "styled-components";
import {FontProps} from "@shared/types";
import {theme} from "@app/styles";

export const HE = styled.div<FontProps>`
    color: ${(props) => props.color || theme.colorSystem.black};
    font-size: ${theme.fontSystem.he.fontSize};
    font-weight: ${theme.fontSystem.he.fontWeight};
    line-height: ${theme.fontSystem.he.lineHeight};
    text-align: ${(props) => props.textAlign || "center"};
    white-space: pre-wrap;
`;