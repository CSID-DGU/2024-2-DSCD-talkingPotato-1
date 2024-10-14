import React from "react";
import * as Styled from "./style";
import {useSideBarStore} from "@shared/store";
import {RootLayout} from "@shared/layouts";
import {DashboardTopBar} from "@features/dashboard/components";

export default function Dashboard(): React.ReactElement {

    const {isExpanded} = useSideBarStore();

    return (
        <RootLayout>
            <Styled.Container isExpanded={isExpanded}>
                <DashboardTopBar/>
            </Styled.Container>
        </RootLayout>
    )
}