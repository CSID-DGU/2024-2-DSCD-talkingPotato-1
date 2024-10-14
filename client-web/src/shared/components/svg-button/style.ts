import {styled} from "styled-components";

interface props {
    src: string;
    width?: string;
    height?: string;
    color?: string;
    top?: string;
    right?: string;
    bottom?: string;
    left?: string;
    position?: string;
    onClick?: () => void;
}

export const Container = styled.img<props>`
    background-image: url(${(props) => props.src});
    background-size: cover;
    width: ${(props) => props.width || "16px"};
    height: ${(props) => props.height || "16px"};
    background-color: ${(props) => props.color || "transparent"};
    top: ${(props) => props.top || "0"};
    right: ${(props) => props.right || "0"};
    bottom: ${(props) => props.bottom || "0"};
    left: ${(props) => props.left || "0"};
    border: none;

    cursor: pointer;
`;