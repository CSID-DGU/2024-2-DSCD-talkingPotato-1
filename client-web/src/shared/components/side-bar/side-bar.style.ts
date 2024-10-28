import {styled} from "styled-components";
import {theme} from "@app/styles";

interface ContainerProps {
    isExpanded: boolean;
}

export const Container = styled.div<ContainerProps>`
    width: ${(props) => (props.isExpanded ? "250px" : "96px")};
    height: 100vh;
    background-color: ${theme.colorSystem.primary["500"]};

    padding: ${(props) => (props.isExpanded ? "16px 19.2px" : "16px 0")};

    flex: 0 0 ${(props) => (props.isExpanded ? "250px" : "96px")};;

    overflow: hidden;

    flex-direction: column;
    align-items: center;

    justify-content: ${(props) => (props.isExpanded ? "flex-start" : "center")};

    position: fixed;
    left: 0;

    transition: width 0.1s ease-in-out;
`