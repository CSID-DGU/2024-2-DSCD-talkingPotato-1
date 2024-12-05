import { ReactElement } from "react";
import { useValidateEmailMutation } from "./validate-email.mutation";

interface IValidateEmailProps {
  email: string;
  isEmailValid: boolean;
  isVerificationCodeSent: boolean;
  setIsVerificationCodeSent: (isVerificationCodeSent: boolean) => void;
}

const ValidateEmail = (props: IValidateEmailProps): ReactElement => {
  const {
    email,
    isEmailValid,
    isVerificationCodeSent,
    setIsVerificationCodeSent,
  } = props;

  const { mutate: validateEmail } = useValidateEmailMutation({
    onSuccess: () => {
      setIsVerificationCodeSent(true);
    },
  });

  const handleValidateEmail = () => {
    validateEmail({ email });
  };

  return (
    <button
      className={`flex flex-col w-fit items-center rounded-2xl bg-primary-500 w-full py-4 px-5 hover:bg-primary-400 cursor-pointer ${
        isEmailValid && !isVerificationCodeSent
          ? "opacity-100"
          : "opacity-50 pointer-events-none"
      }`}
      disabled={!isEmailValid || isVerificationCodeSent}
      onClick={handleValidateEmail}
    >
      <h1 className="text-h1 text-white whitespace-nowrap">인증코드 받기</h1>
    </button>
  );
};

export default ValidateEmail;
