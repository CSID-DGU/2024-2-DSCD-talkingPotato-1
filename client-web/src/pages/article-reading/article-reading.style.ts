import {styled} from "styled-components";

export const PageContainer = styled.div`
    display: flex;
    flex-direction: column;
    width: 100%;
    height: 100vh;

    align-items: center;
`;

export const ScrollableContainer = styled.div`
    flex: 1;
    overflow-y: auto;
    display: flex;
    flex-direction: column;

    width: 50%;

    align-items: start;

    padding: 40px;
    gap: 10px;
`;