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
    <div className="flex flex-col items-center justify-center w-full h-full">
      <RegisterTopBar />
      <RegisterForm />
    </div>
  );
};

const RegisterTopBar = (): ReactElement => {
  const navigate = useNavigate();

  const handleBack = () => {
    navigate(CONSTANTS.ROUTER.LOGIN);
  };

  return (
    <div className="flex flex-col w-full px-6 h-20 justify-center border-b border-neutral-700">
      <div className="flex flex-row items-center justify-between">
        <div
          className="flex flex-row items-center gap-3 cursor-pointer hover:bg-neutral-900 rounded-xl p-2"
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
  const navigate = useNavigate();

  const [formData, setFormData] = useState({
    name: "",
    serialId: "",
    domain: "",
    email: "",
    verificationCode: "",
    password: "",
    passwordConfirm: "",
    history: "",
  });

  const [validationState, setValidationState] = useState({
    isEmailValid: false,
    isVerificationCodeSent: false,
    isVerified: false,
    isPasswordConfirm: false,
  });

  const [temporaryToken, setTemporaryToken] = useState("");

  const { mutate: register } = useRegisterMutation({
    onSuccess: () => {
      navigate(CONSTANTS.ROUTER.WAITING);
    },
  });

  const handleInputChange = (
    e: ChangeEvent<HTMLInputElement | HTMLTextAreaElement>
  ) => {
    const { name, value } = e.target;
    setFormData((prev) => ({
      ...prev,
      [name]: value,
    }));
  };

  const handleRegister = () => {
    const { isEmailValid, isVerified, isPasswordConfirm } = validationState;
    const { name } = formData;

    if (!isEmailValid || !isVerified || !isPasswordConfirm || !name) {
      return;
    }

    register({
      registerDto: {
        nickname: formData.name,
        career: formData.history,
        password: formData.password,
      },
      temporaryToken,
    });
  };

  useEffect(() => {
    setFormData((prev) => ({
      ...prev,
      email: `${formData.serialId}@${formData.domain}`,
    }));
  }, [formData.serialId, formData.domain]);

  useEffect(() => {
    setValidationState((prev) => ({
      ...prev,
      isEmailValid: CONSTANTS.REGEX.EMAIL.test(formData.email),
    }));
  }, [formData.email]);

  useEffect(() => {
    setValidationState((prev) => ({
      ...prev,
      isPasswordConfirm:
        CONSTANTS.REGEX.PASSWORD.test(formData.password) &&
        formData.password === formData.passwordConfirm,
    }));
  }, [formData.password, formData.passwordConfirm]);

  return (
    <div className="flex flex-col w-2/5">
      <h1 className="text-h1 text-black text-start mb-12">회원가입</h1>

      <h6 className="text-h6 text-neutral-500 text-start">이름</h6>
      <input
        name="name"
        className="w-full mt-2 rounded-2xl border border-neutral-700 p-5 text-sub2 text-neutral-300 mb-8"
        value={formData.name}
        onChange={handleInputChange}
        placeholder="이름을 입력해주세요."
      />

      <h6 className="text-h6 text-neutral-500 text-start">이메일</h6>
      <div className="flex flex-row gap-2 mt-2 mb-8 items-center">
        <input
          name="serialId"
          className="w-full rounded-2xl border border-neutral-700 p-5 text-sub2 text-neutral-300"
          value={formData.serialId}
          onChange={handleInputChange}
          placeholder="이메일을 입력해주세요."
        />
        <h6 className="text-h6 text-neutral-500 text-start">@</h6>
        <input
          name="domain"
          className="w-full rounded-2xl border border-neutral-700 p-5 text-sub2 text-neutral-300"
          value={formData.domain}
          onChange={handleInputChange}
          placeholder="도메인을 입력해주세요."
        />
        <ValidateEmail
          email={formData.email}
          isEmailValid={validationState.isEmailValid}
          isVerificationCodeSent={validationState.isVerificationCodeSent}
          setIsVerificationCodeSent={(value) =>
            setValidationState((prev) => ({
              ...prev,
              isVerificationCodeSent: value,
            }))
          }
        />
      </div>

      <h6 className="text-h6 text-neutral-500 text-start">인증번호</h6>
      <div className="flex flex-row gap-2 mt-2 mb-8 items-center">
        <input
          name="verificationCode"
          className="w-full rounded-2xl border border-neutral-700 p-5 text-sub2 text-neutral-300"
          value={formData.verificationCode}
          onChange={handleInputChange}
          type="text"
          pattern="[0-9]*"
          placeholder="인증번호를 입력해주세요."
          maxLength={6}
        />
        <ValidateAuthenticationCode
          email={formData.email}
          code={formData.verificationCode}
          setIsVerified={(value) =>
            setValidationState((prev) => ({ ...prev, isVerified: value }))
          }
          isVerificationCodeSent={validationState.isVerificationCodeSent}
          isVerified={validationState.isVerified}
          setTemporaryToken={setTemporaryToken}
        />
      </div>

      <h6 className="text-h6 text-neutral-500 text-start">비밀번호</h6>
      <input
        name="password"
        type="password"
        className="w-full mt-2 rounded-2xl border border-neutral-700 p-5 text-sub2 text-neutral-300 mb-8"
        value={formData.password}
        onChange={handleInputChange}
        placeholder="비밀번호를 입력해주세요."
      />

      <h6 className="text-h6 text-neutral-500 text-start">비밀번호 확인</h6>
      <input
        name="passwordConfirm"
        type="password"
        className="w-full mt-2 rounded-2xl border border-neutral-700 p-5 text-sub2 text-neutral-300 mb-8"
        value={formData.passwordConfirm}
        onChange={handleInputChange}
        placeholder="비밀번호를 입력해주세요."
      />

      <h6 className="text-h6 text-neutral-500 text-start">경력</h6>
      <textarea
        name="history"
        className="w-full h-60 mt-2 rounded-2xl border border-neutral-700 p-5 text-sub2 text-neutral-300 mb-8 resize-none"
        value={formData.history}
        onChange={handleInputChange}
        placeholder="경력을 입력해주세요."
      />

      <div className="flex justify-center">
        <button
          className="flex flex-col w-2/5 items-center justify-center bg-primary-500 rounded-full mt-8 py-5 cursor-pointer"
          onClick={handleRegister}
        >
          <h1 className="text-h1 text-white">가입하기</h1>
        </button>
      </div>
    </div>
  );
};

export default Register;
