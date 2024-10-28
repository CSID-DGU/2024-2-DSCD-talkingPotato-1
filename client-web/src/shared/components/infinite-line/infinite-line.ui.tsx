import {SizedBox} from "@shared/components";

interface props {
    width?: string;
    color?: string;
}

const InfiniteLine = (props: props) => {
    return (
        <SizedBox height={"1px"} width={props.width} background={props.color}/>
    );
}

export default InfiniteLine;