import { ReactElement } from "react";
import LogoutIcon from "@shared/assets/icons/Logout.svg?react";
import { useLogoutMutation } from "./logout.mutation";
import { useNavigate } from "react-router-dom";
import { CONSTANTS } from "@app/constants/constants";
import useAccountStore from "@shared/store/account";
import { Cookies } from "react-cookie";

const Logout = (): ReactElement => {
  const navigate = useNavigate();
  const { clearAid } = useAccountStore();
  const cookies = new Cookies();
  const { mutate: logout } = useLogoutMutation({
    onSuccess: () => {
      clearAid();
      cookies.remove("access_token");
      cookies.remove("account_id");
      cookies.remove("refresh_token");
      navigate(CONSTANTS.ROUTER.LOGIN);
    },
  });

  const handleLogout = () => {
    logout();
    navigate(CONSTANTS.ROUTER.LOGIN);
  };

  return (
    <div
      className="flex fixed bottom-10 items-center justify-center p-4 rounded-2xl cursor-pointer"
      onClick={handleLogout}
    >
      <LogoutIcon className="w-8 h-8 text-white" />
    </div>
  );
};

export default Logout;
