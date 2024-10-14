import styled from "styled-components";

interface ContainerProps {
    backgroundColor: string;
    borderRadius?: string;
    padding?: string;
    width?: string;
    height?: string;
}

export const Container = styled.div<ContainerProps>`
    display: flex;
    flex-direction: column;

    background-color: ${(props) => props.backgroundColor};

    padding: ${(props) => props.padding ? props.padding : "0"};
    border-radius: ${(props) => props.borderRadius ? props.borderRadius : "0"};

    width: ${(props) => props.width ? props.width : "100%"};
    height: ${(props) => props.height ? props.height : "100%"};

    align-items: center;
    justify-content: center;

    cursor: pointer;
`;