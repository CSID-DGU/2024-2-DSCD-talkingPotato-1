import { ReactElement } from "react";
import { useValidateAuthenticationCodeMutation } from "./validate-authentication-code.mutation";

interface IValidateAuthenticationCodeProps {
  email: string;
  code: string;
}

const ValidateAuthenticationCode = (
  props: IValidateAuthenticationCodeProps
): ReactElement => {
  const { mutate: validateAuthenticationCode } =
    useValidateAuthenticationCodeMutation();

  const { email, code } = props;

  const handleValidateAuthenticationCode = () => {
    validateAuthenticationCode({
      email,
      code,
    });
  };

  return (
    <button
      className="flex flex-col items-center rounded-lg bg-primary-500 w-full py-4 px-5"
      onClick={handleValidateAuthenticationCode}
    >
      <h1 className="text-h1 text-white">인증코드 확인</h1>
    </button>
  );
};

export default ValidateAuthenticationCode;
