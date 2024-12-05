import { ChangeEvent, ReactElement, useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import { CONSTANTS } from "@app/constants/constants";
import { ValidateEmail } from "@features/auth/validate-email";
import { ValidateAuthenticationCode } from "@features/auth/validate-authentication-code";
import { useRegisterMutation } from "./register.mutation";

// Icons
import BackIcon from "@shared/assets/icons/Back.svg?react";

const Register = (): ReactElement => {
  return (
    <div>
      <RegisterTopBar />
      <RegisterForm />
    </div>
  );
};

/**
 * Private Component
 */
const RegisterTopBar = (): ReactElement => {
  const navigate = useNavigate();

  const handleBack = () => {
    navigate(CONSTANTS.ROUTER.LOGIN);
  };

  return (
    <div className="flex flex-col px-6 h-20 justify-center border-b border-neutral-700">
      <div className="flex flex-row items-center justify-between">
        <div
          className="flex flex-row items-center gap-3 cursor-pointer"
          onClick={handleBack}
        >
          <BackIcon className="w-6 h-6 text-neutral-500" />
          <h1 className="text-h1 text-neutral-500 text-start">뒤로가기</h1>
        </div>
      </div>
    </div>
  );
};

const RegisterForm = (): ReactElement => {
  const [name, setName] = useState<string>("");
  const [serialId, setSerialId] = useState<string>("");
  const [domain, setDomain] = useState<string>("");
  const [email, setEmail] = useState<string>("");
  const [verificationCode, setVerificationCode] = useState<string>("");
  const [password, setPassword] = useState<string>("");
  const [passwordConfirm, setPasswordConfirm] = useState<string>("");
  const [history, setHistory] = useState<string>("");
  //   const [temporaryToken, setTemporaryToken] = useState<string>("");

  const { mutate: register } = useRegisterMutation();

  const handleNameChange = (e: ChangeEvent<HTMLInputElement>) => {
    setName(e.target.value);
  };

  const handleSerialIdChange = (e: ChangeEvent<HTMLInputElement>) => {
    setSerialId(e.target.value);
  };

  const handleDomainChange = (e: ChangeEvent<HTMLInputElement>) => {
    setDomain(e.target.value);
  };

  const handleVerificationCodeChange = (e: ChangeEvent<HTMLInputElement>) => {
    setVerificationCode(e.target.value);
  };

  const handlePasswordChange = (e: ChangeEvent<HTMLInputElement>) => {
    setPassword(e.target.value);
  };

  const handlePasswordConfirmChange = (e: ChangeEvent<HTMLInputElement>) => {
    setPasswordConfirm(e.target.value);
  };

  const handleHistoryChange = (e: ChangeEvent<HTMLTextAreaElement>) => {
    setHistory(e.target.value);
  };

  const handleRegister = () => {
    register({
      nickname: name,
      career: history,
      password,
    });
  };

  useEffect(() => {
    setEmail(name + "@" + domain);
  }, [name, domain]);

  return (
    <div className="flex flex-col w-3/5">
      <h1 className="text-h1 text-black text-start mb-12">회원가입</h1>
      <h6 className="text-h6 text-neutral-500 text-start">이름</h6>
      <input
        className="w-full mt-2 rounded-lg border border-neutral-700 p-5 text-sub2 text-neutral-700 mb-8"
        value={name}
        onChange={handleNameChange}
        placeholder="이름을 입력해주세요."
      />
      <h6 className="text-h6 text-neutral-500 text-start">이메일</h6>
      <div className="flex flex-row gap-2 mb-8">
        <input
          className="w-full rounded-lg border border-neutral-700 p-5 text-sub2 text-neutral-700"
          value={serialId}
          onChange={handleSerialIdChange}
          placeholder="이메일을 입력해주세요."
        />
        <h6 className="text-h6 text-neutral-500 text-start">@</h6>
        <input
          className="w-full rounded-lg border border-neutral-700 p-5 text-sub2 text-neutral-700"
          value={domain}
          onChange={handleDomainChange}
          placeholder="도메인을 입력해주세요."
        />
        <ValidateEmail email={email} />
      </div>
      <h6 className="text-h6 text-neutral-500 text-start">인증번호</h6>
      <div className="flex flex-row gap-2 mb-8">
        <input
          className="w-full rounded-lg border border-neutral-700 p-5 text-sub2 text-neutral-700"
          value={verificationCode}
          onChange={handleVerificationCodeChange}
          placeholder="인증번호를 입력해주세요."
        />
        <ValidateAuthenticationCode email={email} code={verificationCode} />
      </div>
      <h6 className="text-h6 text-neutral-500 text-start">비밀번호</h6>
      <input
        className="w-full mt-2 rounded-lg border border-neutral-700 p-5 text-sub2 text-neutral-700 mb-8"
        value={password}
        onChange={handlePasswordChange}
        placeholder="비밀번호를 입력해주세요."
      />
      <h6 className="text-h6 text-neutral-500 text-start">비밀번호 확인</h6>
      <input
        className="w-full mt-2 rounded-lg border border-neutral-700 p-5 text-sub2 text-neutral-700 mb-8"
        value={passwordConfirm}
        onChange={handlePasswordConfirmChange}
        placeholder="비밀번호를 입력해주세요."
      />
      <h6 className="text-h6 text-neutral-500 text-start">경력</h6>
      <textarea
        className="w-full mt-2 rounded-lg border border-neutral-700 p-5 text-sub2 text-neutral-700 mb-8"
        value={history}
        onChange={handleHistoryChange}
        placeholder="경력을 입력해주세요."
      />
      <button
        className="flex flex-col items-center justify-center bg-primary-500 rounded-xl mt-8 cursor-pointer"
        onClick={handleRegister}
      >
        <h1 className="text-h1 text-white">가입하기</h1>
      </button>
    </div>
  );
};

export default Register;
