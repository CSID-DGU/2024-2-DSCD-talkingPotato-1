import styled from "styled-components";
import {theme} from "@app/styles";

interface ContainerProps {
    isSelected: boolean;
}

export const Container = styled.div<ContainerProps>`
    display: flex;

    background-color: ${(props) => props.isSelected ? theme.colorSystem.white : "transparent"};

    padding: 16px 0;

    width: 60px;

    justify-content: center;

    border-radius: 16px;
`;