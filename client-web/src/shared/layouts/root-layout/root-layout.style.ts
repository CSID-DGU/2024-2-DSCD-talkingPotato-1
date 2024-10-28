import {styled} from "styled-components";

export const Container = styled.div`
    display: flex;
    flex-direction: row;

    width: 100vw;
    height: 100vh;
`;

interface ColumnProps {
    isExpanded: boolean;
}

export const Column = styled.div<ColumnProps>`
    display: flex;

    flex: 1;

    flex-direction: column;

    margin-left: ${(props) => props.isExpanded ? "288.4px" : "96px"};

    width: ${(props) =>
            props.isExpanded
                    ? "calc(100% - 288.4px)"
                    : "calc(100% - 96px)"};
    height: 100%;
`;