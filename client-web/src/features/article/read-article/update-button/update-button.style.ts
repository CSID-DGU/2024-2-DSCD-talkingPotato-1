import {styled} from "styled-components";
import {theme} from "@app/styles";

export const Button = styled.div`
    display: flex;

    padding: 16px 20px;

    background-color: ${theme.colorSystem.primary["500"]};

    border-radius: 30px;

    gap: 12px;

    align-items: center;

    position: fixed;
    right: 40px;
    bottom: 40px;

    cursor: pointer;
`;