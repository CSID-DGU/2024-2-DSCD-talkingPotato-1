import styled from "styled-components";
import {theme} from "@app/styles";

interface ContainerProps {
    isFirst: boolean;
}

export const Container = styled.div<ContainerProps>`
    display: flex;
    flex-direction: column;

    align-items: center;
    justify-content: center;

    padding: 0 20px;

    height: 24px;

    background-color: ${theme.colorSystem.secondary["900"]};

    border-radius: 12px;

    margin-left: ${(props) => props.isFirst ? "0px" : "12px"};
`;