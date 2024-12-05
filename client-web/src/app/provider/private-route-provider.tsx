import { Navigate, Outlet } from "react-router-dom";
import { CONSTANTS } from "@app/constants/constants.ts";
import { useAuthenticate } from "@shared/lib/auth";

function PrivateRoute() {
  return useAuthenticate ? (
    <Outlet />
  ) : (
    <Navigate to={CONSTANTS.ROUTER.LOGIN} />
  );
}

export default PrivateRoute;
