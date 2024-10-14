import {useState} from "react";

export const useAlertMessage = () => {

    const [isAlertOpen, setIsAlertOpen] = useState(false);
    const [alertMessage, setAlertMessage] = useState("");

    return {
        isAlertOpen, alertMessage, setIsAlertOpen, setAlertMessage
    }
}

export default useAlertMessage;