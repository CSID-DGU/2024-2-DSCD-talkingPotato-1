import { CONSTANTS } from "@app/constants/constants";
import { ChangeEvent, ReactElement, useState } from "react";
import { useNavigate } from "react-router-dom";

// Icons
import LoginIcon from "@shared/assets/icons/Title.svg?react";
import useLoginMutation from "./login.mutation";

/**
 * Public Component
 */
const Login = (): ReactElement => {
  const navigate = useNavigate();

  const handleRegisterButtonClick = () => {
    navigate(CONSTANTS.ROUTER.REGISTER);
  };

  return (
    <div className="flex flex-col w-[32%] h-[calc(100vh-100px)] items-center justify-center">
      <LoginIcon className="w-full mb-2" />
      <div className="flex flex-row items-end">
        <div className="flex flex-row flex-end g-3">
          <h6 className="text-h6 text-neutral-500">아이디가 없으신가요?</h6>
          <h4
            className="text-h4 text-primary-500 cursor-pointer"
            onClick={handleRegisterButtonClick}
          >
            회원가입
          </h4>
        </div>
      </div>
      <LoginForm />
    </div>
  );
};

export default Login;

/**
 * Private Component
 */
const LoginForm = (): ReactElement => {
  const [serialId, setSerialId] = useState<string>("");
  const [password, setPassword] = useState<string>("");

  const handleSerialIdChange = (e: ChangeEvent<HTMLInputElement>) => {
    setSerialId(e.target.value);
  };

  const handlePasswordChange = (e: ChangeEvent<HTMLInputElement>) => {
    setPassword(e.target.value);
  };

  const { mutate: login } = useLoginMutation();

  const handleLoginButtonClick = () => {
    login({ serialId, password });
  };

  return (
    <div className="flex flex-col w-full">
      <h1 className="text-h0 text-black text-start mb-15">로그인</h1>
      <h6 className="text-h6 text-neutral-400 text-start">이메일</h6>
      <input
        className="w-full p-20 mt-2 mb-15 text-sub2 text-neutral-700 rounded-xl border border-neutral-700"
        value={serialId}
        onChange={handleSerialIdChange}
        placeholder="이메일을 입력해주세요."
      />
      <h6 className="text-h6 text-neutral-400 text-start">비밀번호</h6>
      <input
        className="w-full p-20 mt-2 mb-15 text-sub2 text-neutral-700 rounded-xl border border-neutral-700"
        value={password}
        onChange={handlePasswordChange}
        placeholder="비밀번호를 입력해주세요."
        type="password"
      />
      <button
        className="flex flex-col items-center justify-center w-[60%] bg-primary-500 text-h1 text-white rounded-2xl py-20 cursor-pointer"
        onClick={handleLoginButtonClick}
      >
        <h1 className="text-h1 text-white">로그인</h1>
      </button>
    </div>
  );
};
