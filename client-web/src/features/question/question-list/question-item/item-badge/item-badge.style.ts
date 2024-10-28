import styled from "styled-components";

interface ContainerProps {
    backgroundColor: string;
}

export const Container = styled.div<ContainerProps>`
    padding: 0 4px;

    border-radius: 10px;

    background-color: ${(props) => props.backgroundColor};
`;