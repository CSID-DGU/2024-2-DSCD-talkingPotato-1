import {styled} from "styled-components";

interface props {
    backgroundColor?: string;
}

export const Container = styled.div<props>`

    padding: 20px 0;

    border-radius: 34px;

    width: 60%;

    align-items: center;
    justify-content: center;

    background-color: ${(props) => props.backgroundColor || "transparent"};

    cursor: pointer;
`;