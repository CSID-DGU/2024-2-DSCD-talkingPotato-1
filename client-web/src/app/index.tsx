import { BrowserRouter } from "react-router-dom";
import { QueryClientProvider, ErrorBoundary } from "@app/provider";
import Router from "./routers";
import "./styles/globals.css";
import "./styles/reset.css";

function App() {
  return (
    <QueryClientProvider>
      <ErrorBoundary>
        <BrowserRouter>
          <Router />
        </BrowserRouter>
      </ErrorBoundary>
    </QueryClientProvider>
  );
}

export default App;
