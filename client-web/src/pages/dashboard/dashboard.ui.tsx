import {ReactElement} from "react";
import * as Styled from "./dashboard.style.ts";
import {RootLayout} from "@shared/layouts";
import {DashboardTopBar} from "@features/dashboard/components";

const Dashboard = (): ReactElement => {

    return (
        <RootLayout>
            <Styled.PageContainer>
                <DashboardTopBar/>
                <Styled.ScrollableContainer/>
            </Styled.PageContainer>
        </RootLayout>
    )
}

export default Dashboard;