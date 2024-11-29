import styled, { keyframes } from "styled-components";
import { theme } from "@app/styles";

export const spin = keyframes`
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
`;

export const LoadingSpinner = styled.div`
  width: 50px;
  height: 50px;
  border: 5px solid ${theme.colorSystem.neutral["100"]};
  border-top: 5px solid ${theme.colorSystem.primary[500]};
  border-radius: 50%;
  animation: ${spin} 1s linear infinite;
`;

export const Container = styled.div`
  width: 100%;
  height: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
`;
