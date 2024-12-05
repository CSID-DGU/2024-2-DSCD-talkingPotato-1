import { ReactElement } from "react";
import { DefaultLayout } from "@shared/layouts/default-layout";
import { Waiting } from "@features/auth/waiting";

const WaitingPage = (): ReactElement => {
  return (
    <DefaultLayout>
      <Waiting />
    </DefaultLayout>
  );
};

export default WaitingPage;
