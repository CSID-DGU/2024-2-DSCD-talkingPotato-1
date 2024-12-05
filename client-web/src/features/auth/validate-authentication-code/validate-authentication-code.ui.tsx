import { ReactElement } from "react";
import { useValidateAuthenticationCodeMutation } from "./validate-authentication-code.mutation";
import { Cookies } from "react-cookie";

interface IValidateAuthenticationCodeProps {
  email: string;
  code: string;
  isVerificationCodeSent: boolean;
  isVerified: boolean;
  setIsVerified: (isVerified: boolean) => void;
  setTemporaryToken: (temporaryToken: string) => void;
}

const ValidateAuthenticationCode = (
  props: IValidateAuthenticationCodeProps
): ReactElement => {
  const {
    email,
    code,
    isVerificationCodeSent,
    isVerified,
    setIsVerified,
    setTemporaryToken,
  } = props;

  const cookies = new Cookies();

  const { mutate: validateAuthenticationCode } =
    useValidateAuthenticationCodeMutation({
      onSuccess: () => {
        setIsVerified(true);
        setTemporaryToken(cookies.get("temporary_token"));
      },
    });

  const handleValidateAuthenticationCode = () => {
    validateAuthenticationCode({
      email,
      code,
    });
  };

  return (
    <button
      className={`flex flex-col w-fit items-center rounded-2xl bg-primary-500 w-full py-4 px-5 hover:bg-primary-400 cursor-pointer ${
        isVerificationCodeSent && !isVerified
          ? "opacity-100"
          : "opacity-50 pointer-events-none"
      }`}
      disabled={!isVerificationCodeSent || isVerified}
      onClick={handleValidateAuthenticationCode}
    >
      <h1 className="text-h1 text-white whitespace-nowrap">인증코드 확인</h1>
    </button>
  );
};

export default ValidateAuthenticationCode;
