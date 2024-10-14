import * as Styled from './style.ts'

interface props {
    width?: string;
    height?: string;
    background?: string;
}

export default function SizedBox(props: props) {

    return (
        <Styled.SizedBox height={props.height} width={props.width} background={props.background}/>
    );
}