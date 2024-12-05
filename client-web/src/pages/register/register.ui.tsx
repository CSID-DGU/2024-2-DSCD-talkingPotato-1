import { ReactElement } from "react";
import { DefaultLayout } from "@shared/layouts/default-layout";
import { Register } from "@features/auth/register";

const RegisterPage = (): ReactElement => {
  return (
    <DefaultLayout>
      <Register />
    </DefaultLayout>
  );
};

export default RegisterPage;
