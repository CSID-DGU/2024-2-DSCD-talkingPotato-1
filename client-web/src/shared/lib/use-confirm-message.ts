import {useState} from "react";

export const useConfirmMessage = () => {
    const [isConfirmOpen, setIsConfirmOpen] = useState(false);
    const [confirmMessage, setConfirmMessage] = useState("");
    const [confirmTitle, setConfirmTitle] = useState("");
    const [onConfirm, setOnConfirm] = useState(() => () => {
    });
    const [onCancel, setOnCancel] = useState(() => () => {
    });

    return {
        isConfirmOpen,
        confirmMessage,
        confirmTitle,
        setConfirmTitle,
        setIsConfirmOpen,
        setConfirmMessage,
        onConfirm,
        setOnConfirm,
        onCancel,
        setOnCancel
    };
}

export default useConfirmMessage;