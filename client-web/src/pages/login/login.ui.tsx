import { ReactElement } from "react";
import { DefaultLayout } from "@shared/layouts/default-layout";
import { Login } from "@features/auth/login";

const LoginPage = (): ReactElement => {
  return (
    <DefaultLayout>
      <Login />
    </DefaultLayout>
  );
};

export default LoginPage;
