import styled from "styled-components";
import {theme} from "@app/styles";

export const Container = styled.div`
    display: flex;
    flex-direction: column;

    width: 100%;
`;

export const Row = styled.div`
    display: flex;
    flex-direction: row;
`;

export const TextArea = styled.textarea`
    padding: 20px;

    height: 120px;

    font-weight: ${theme.fontSystem.sub2.fontWeight};
    font-size: ${theme.fontSystem.sub2.fontSize};
    line-height: ${theme.fontSystem.sub2.lineHeight};
    font-family: ${theme.fontSystem.sub2.fontFamily};

    box-sizing: border-box;
    border-radius: 12px;
    border: 1px solid ${theme.colorSystem.neutral["700"]};

    resize: none;

    margin-bottom: 20px;
`;

export const Button = styled.button`

    width: 96px;
    height: 48px;

    border-radius: 12px;
    border: none;

    background-color: ${theme.colorSystem.secondary["500"]};

    cursor: pointer;
`;