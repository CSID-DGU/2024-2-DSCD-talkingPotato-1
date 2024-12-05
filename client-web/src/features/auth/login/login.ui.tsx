import { CONSTANTS } from "@app/constants/constants";
import { ChangeEvent, ReactElement, useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import LoginIcon from "@shared/assets/icons/Title.svg?react";
import useLoginMutation from "./login.mutation";
import useAccountStore from "@shared/store/account";
import { Cookies } from "react-cookie";

const Login = (): ReactElement => {
  const navigate = useNavigate();

  const handleRegisterClick = () => {
    navigate(CONSTANTS.ROUTER.REGISTER);
  };

  return (
    <div className="flex flex-col w-[32%] min-h-[600px] h-[calc(100vh-100px)] items-center justify-center">
      <LoginIcon className="w-full h-auto mb-8" />
      <div className="flex w-full justify-end mb-12">
        <div className="flex items-center gap-2">
          <span className="text-neutral-500">아이디가 없으신가요?</span>
          <button
            className="text-primary-500 hover:text-primary-400 transition-colors"
            onClick={handleRegisterClick}
          >
            <h4 className="text-h4">회원가입</h4>
          </button>
        </div>
      </div>
      <LoginForm />
    </div>
  );
};

export default Login;

const LoginForm = (): ReactElement => {
  const [formData, setFormData] = useState({
    serialId: "",
    password: "",
  });
  const [isValid, setIsValid] = useState(false);

  const navigate = useNavigate();
  const { setAid } = useAccountStore();
  const cookies = new Cookies();

  const handleChange = (e: ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setFormData((prev) => ({
      ...prev,
      [name]: value,
    }));
  };

  const { mutate: login } = useLoginMutation({
    onSuccess: () => {
      setAid(cookies.get("account_id"));
      navigate(CONSTANTS.ROUTER.ARTICLE);
    },
  });

  const handleSubmit = () => {
    login(formData);
  };

  useEffect(() => {
    const { serialId, password } = formData;
    setIsValid(
      CONSTANTS.REGEX.EMAIL.test(serialId) &&
        CONSTANTS.REGEX.PASSWORD.test(password)
    );
  }, [formData]);

  return (
    <div className="flex flex-col w-full">
      <h1 className="text-h0 text-black mb-10">로그인</h1>

      <div className="space-y-6">
        <div className="flex flex-col gap-2">
          <label className="text-h6 text-neutral-400">이메일</label>
          <input
            name="serialId"
            className="w-full p-4 text-neutral-300 bg-transparent rounded-xl border border-neutral-700 focus:border-primary-500 transition-colors"
            value={formData.serialId}
            onChange={handleChange}
            placeholder="이메일을 입력해주세요."
          />
        </div>

        <div className="flex flex-col gap-2">
          <label className="text-h6 text-neutral-400">비밀번호</label>
          <input
            name="password"
            type="password"
            className="w-full p-4 text-neutral-300 bg-transparent rounded-xl border border-neutral-700 focus:border-primary-500 transition-colors"
            value={formData.password}
            onChange={handleChange}
            placeholder="비밀번호를 입력해주세요."
          />
        </div>
      </div>

      <div className="flex justify-center">
        <button
          className={`mt-12 w-[60%] py-4 rounded-full text-white text-h1
            ${
              isValid
                ? "bg-primary-500 hover:bg-primary-400 transition-colors"
                : "bg-primary-500/50 cursor-not-allowed"
            }`}
          disabled={!isValid}
          onClick={handleSubmit}
        >
          로그인
        </button>
      </div>
    </div>
  );
};
