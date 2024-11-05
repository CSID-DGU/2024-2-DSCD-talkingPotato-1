import styled from "styled-components";

export const Container = styled.div`
    display: flex;
    flex-direction: column;

    padding: 0 24px;

    height: 78px;

    justify-content: center;
`;

export const Column = styled.div`
    display: flex;
    flex-direction: column;

    width: 100%;
`;


export const Row = styled.div`
    display: flex;
    flex-direction: row;

    align-items: center;
    justify-content: space-between;
`;

export const BackSection = styled.div`
    display: flex;
    flex-direction: row;

    align-items: center;
    gap: 12px;

    cursor: pointer;
`;

export const ButtonWrapper = styled.div`
    display: flex;
`;
