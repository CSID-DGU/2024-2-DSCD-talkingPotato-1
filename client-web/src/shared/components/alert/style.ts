import styled from "styled-components";
import {theme} from "@app/styles";

export const Overlay = styled.div`
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    z-index: 8000;
    background-color: rgba(0, 0, 0, 0.5);
    display: flex;
    justify-content: center;
    align-items: center;
`;

export const ButtonContainer = styled.div`
    width: 100%;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    gap: 1rem;

    margin-top: 2rem;
`;

export const Container = styled.div`
    width: 30rem;
    height: auto;
    min-height: 10rem;
    display: flex;
    flex-direction: column;
    justify-content: center;
    padding: 2rem;
    border-radius: 16px;
    background-color: ${theme.colorSystem.white};
    z-index: 8100;
    border: none;
`;

export const StyledButton = styled.button`
    width: 100%;
    border-radius: 20px;
    padding: 1rem 2rem;
    cursor: pointer;
    border: none;
    background-color: ${theme.colorSystem.secondary["500"]};
`;