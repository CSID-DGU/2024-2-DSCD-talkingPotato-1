import styled from "styled-components";
import {theme} from "@app/styles";

export const Container = styled.div`
    display: flex;
    flex-direction: column;

    width: 100%;
`;

export const Input = styled.input`

    margin-top: 8px;

    padding: 20px;
    border-radius: 12px;
    border: 1.5px solid ${theme.colorSystem.neutral["700"]};

    font-size: ${theme.fontSystem.sub2.fontSize};
    font-weight: ${theme.fontSystem.sub2.fontWeight};
    font-family: ${theme.fontSystem.sub2.fontFamily};
    line-height: ${theme.fontSystem.sub2.lineHeight};
`;

export const LoginButton = styled.div`
    display: flex;
    justify-content: center;
    align-items: center;

    background-color: ${theme.colorSystem.primary["500"]};

    border-radius: 34px;
    padding: 20px 0;
    width: 60%;

    cursor: pointer;
`;

export const BottomRow = styled.div`
    display: flex;
    flex-direction: row;
    justify-content: flex-start;
    align-items: center;

    margin-top: 10px;
    gap: 8px;
    width: 100%;
`;