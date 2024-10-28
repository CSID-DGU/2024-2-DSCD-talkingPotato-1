import styled from "styled-components";
import {theme} from "@app/styles";

interface ContainerProps {
    isSelected: boolean;
}

export const Container = styled.div<ContainerProps>`
    display: flex;

    background-color: ${(props) => props.isSelected ? theme.colorSystem.white : "transparent"};

    padding: 16px;

    width: 218px;

    justify-content: start;

    border-radius: 16px;

    cursor: pointer;
`;

export const Row = styled.div`
    display: flex;
    flex-direction: row;

    align-items: center;
`;