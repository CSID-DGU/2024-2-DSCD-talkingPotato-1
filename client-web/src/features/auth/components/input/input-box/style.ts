import styled from "styled-components";

export const Container = styled.input`
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;

    padding: 20px;

    width: 100%;

    border: 1.5px solid ${({theme}) => theme.colorSystem.neutral["300"]};
    border-radius: 12px;
`;