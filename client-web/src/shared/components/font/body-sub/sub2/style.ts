import {styled} from "styled-components";
import {FontProps} from "@shared/types";
import {theme} from "@app/styles";

export const Sub2 = styled.div<FontProps>`
    color: ${(props) => props.color || theme.colorSystem.black};
    font-size: ${theme.fontSystem.sub2.fontSize};
    font-weight: ${theme.fontSystem.sub2.fontWeight};
    line-height: ${theme.fontSystem.sub2.lineHeight};
    text-align: ${(props) => props.textAlign || "center"};
    white-space: ${(props) => props.whiteSpace || "pre-wrap"};
`;