import { Cookies } from "react-cookie";

export const useAuthenticate = (): boolean => {
  const cookies = new Cookies();
  const accessToken = cookies.get("accessToken");

  return accessToken ? true : false;
};

export default useAuthenticate();
