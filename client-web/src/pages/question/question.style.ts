import {styled} from "styled-components";

interface ContainerProps {
    isExpanded: boolean;
}

export const Container = styled.div<ContainerProps>`
    display: flex;
    flex: 1;

    width: 100vw;
    height: 100vh;

    overflow-y: auto;
    margin-left: ${(props) => props.isExpanded ? "288.4px" : "96px"};

    flex-direction: column;
    align-items: center;
`;