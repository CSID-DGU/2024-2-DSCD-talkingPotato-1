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

export const TextArea = styled.textarea`
    margin-top: 8px;

    padding: 20px;
    border-radius: 12px;
    border: 1.5px solid ${theme.colorSystem.neutral["700"]};

    height: 120px;

    box-sizing: border-box;
    resize: none;

    font-size: ${theme.fontSystem.sub2.fontSize};
    font-weight: ${theme.fontSystem.sub2.fontWeight};
    font-family: ${theme.fontSystem.sub2.fontFamily};
    line-height: ${theme.fontSystem.sub2.lineHeight};
`;

export const Row = styled.div`
    display: flex;
    flex-direction: row;

    width: 100%;

    justify-content: space-between;
    align-items: center;
`;

export const RectangleButton = styled.div`
    display: flex;
    flex-direction: column;

    align-items: center;

    border-radius: 12px;
    padding: 15px 25px;

    width: 132px;

    background-color: ${theme.colorSystem.primary["500"]};

    cursor: pointer;
`;

export const RegisterButton = styled.div`
    display: flex;
    justify-content: center;
    align-items: center;

    background-color: ${theme.colorSystem.primary["500"]};

    border-radius: 34px;
    padding: 20px 0;
    width: 60%;

    margin-top: 32px;

    cursor: pointer;
`;
