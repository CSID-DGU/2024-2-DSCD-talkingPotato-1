import styled from "styled-components";
import {theme} from "@app/styles";

export const Container = styled.div`
    display: flex;
    flex-direction: column;

    width: 100%;
    height: auto;

    align-items: center;
    justify-content: center;
`;

export const Divider = styled.hr`
    width: 60%;
    border: none;
    border-top: 1px solid ${theme.colorSystem.neutral["700"]};
`;