import styled from "styled-components";

type Direction = 'vertical' | 'horizontal';

interface SpacerProps {
    flex: number;
    direction: Direction;
}

export const Spacer = styled.div<SpacerProps>`
    flex: ${(props) => props.flex};
    ${({direction}) => direction === 'vertical' ? 'height: 100%;' : 'width: 100%;'}
`;