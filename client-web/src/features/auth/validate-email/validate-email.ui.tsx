import { ReactElement } from "react";
import { useValidateEmailMutation } from "./validate-email.mutation";

interface IValidateEmailProps {
  email: string;
}

const ValidateEmail = (props: IValidateEmailProps): ReactElement => {
  const { email } = props;

  const { mutate: validateEmail } = useValidateEmailMutation();

  const handleValidateEmail = () => {
    validateEmail({ email });
  };

  return (
    <button
      className="flex flex-col items-center rounded-lg bg-primary-500 w-full py-4 px-5"
      onClick={handleValidateEmail}
    >
      <h1 className="text-h1 text-white">인증코드 받기</h1>
    </button>
  );
};

export default ValidateEmail;
