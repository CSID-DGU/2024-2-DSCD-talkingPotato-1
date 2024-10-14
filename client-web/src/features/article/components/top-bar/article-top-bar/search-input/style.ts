import styled from "styled-components";
import theme from "@styles/theme.ts";

export const Container = styled.input`
    padding: 20px 32px;

    width: 704px;

    border-radius: 15px;
    border: 1.5px solid ${theme.colorSystem.neutral["700"]};
`;