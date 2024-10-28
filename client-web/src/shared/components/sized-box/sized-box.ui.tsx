import * as Styled from './sized-box.style.ts'

interface props {
    width?: string;
    height?: string;
    background?: string;
}

const SizedBox = (props: props) => {

    return (
        <Styled.SizedBox height={props.height} width={props.width} background={props.background}/>
    );
}

export default SizedBox;