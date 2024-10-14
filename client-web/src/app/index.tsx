import {BrowserRouter} from "react-router-dom";
import {ThemeProvider} from "styled-components";
import {GlobalStyle} from "@app/styles/global.ts";
import {QueryClient, QueryClientProvider} from "@tanstack/react-query";
import {ErrorBoundary} from "@shared/components";
import theme from "@app/styles/theme.ts";
import Router from "./routers";

const queryClient = new QueryClient();

function App() {
    return (
        <QueryClientProvider client={queryClient}>
            <ThemeProvider theme={theme}>
                <GlobalStyle/>
                <ErrorBoundary>
                    <BrowserRouter>
                        <Router/>
                    </BrowserRouter>
                </ErrorBoundary>
            </ThemeProvider>
        </QueryClientProvider>
    )
}

export default App
