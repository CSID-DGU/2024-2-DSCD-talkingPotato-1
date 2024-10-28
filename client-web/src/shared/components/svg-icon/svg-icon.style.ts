import styled from "styled-components";

interface ContainerProps {
    width?: string;
    height?: string;
    color?: string;
}

export const Container = styled.div<ContainerProps>`
    display: flex;
    justify-content: center;
    align-items: center;

    width: ${(props) => props.width || "24px"};
    height: ${(props) => props.height || "24px"};

    svg {
        width: 100%;
        height: 100%;
        fill: ${(props) => props.color || "black"};
    }

    path {
        fill: ${(props) => props.color || "black"};
    }

    cursor: pointer;
`;