import {ReactElement} from "react";
import * as Styled from "./dashboard.style.ts";
import {useSideBarStore} from "@shared/store";
import {RootLayout} from "@shared/layouts";
import {DashboardTopBar} from "@features/dashboard/components";

const Dashboard = (): ReactElement => {
    const {isExpanded} = useSideBarStore();

    return (
        <RootLayout>
            <Styled.Container isExpanded={isExpanded}>
                <DashboardTopBar/>
            </Styled.Container>
        </RootLayout>
    )
}

export default Dashboard;