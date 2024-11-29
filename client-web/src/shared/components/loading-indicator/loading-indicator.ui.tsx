import { ReactElement } from "react";
import * as Styled from "./loading-indicator.style.ts";

export const LoadingIndicator = (): ReactElement => {
  return (
    <Styled.Container>
      <Styled.LoadingSpinner />
    </Styled.Container>
  );
};

export default LoadingIndicator;
