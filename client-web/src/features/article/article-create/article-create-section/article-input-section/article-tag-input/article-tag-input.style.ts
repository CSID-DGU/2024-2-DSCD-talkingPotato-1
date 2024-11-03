import {styled} from "styled-components";
import {theme} from "@app/styles";


export const Container = styled.div`
    display: flex;
    flex-direction: column;

    margin-bottom: 40px;
`;

export const LabelWithLine = styled.div`
    display: flex;
    flex-direction: row;
    align-items: center;
    width: 100%;
    margin-bottom: 12px;
`;

export const Input = styled.input`
    width: 100%;
    padding: 16px;
    border-radius: 12px;
    border: 1px solid ${theme.colorSystem.neutral["700"]};
    box-sizing: border-box;
`;