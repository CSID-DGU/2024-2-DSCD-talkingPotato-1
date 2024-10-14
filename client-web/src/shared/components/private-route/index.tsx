import {Navigate, Outlet} from "react-router-dom";
import {CONSTANTS} from "@app/constants/constants.ts";
import {useAuthenticate} from "@features/auth/hooks/useAuthenticate.ts";

export default function PrivateRoute() {
    return useAuthenticate() ? <Outlet/> : <Navigate to={CONSTANTS.ROUTER.LOGIN}/>
}