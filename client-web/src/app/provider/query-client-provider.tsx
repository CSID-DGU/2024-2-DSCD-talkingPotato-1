import { ReactNode } from "react";
import {
  Query,
  QueryClientProvider as TanStackQueryClientProvider,
} from "@tanstack/react-query";
import { ReactQueryDevtools } from "@tanstack/react-query-devtools";
import { queryClient } from "@shared/lib/react-query";
import { AxiosError } from "axios";

type TQueryClientProviderProps = {
  children: ReactNode;
};

export function QueryClientProvider(props: TQueryClientProviderProps) {
  const { children } = props;

  return (
    <TanStackQueryClientProvider client={queryClient}>
      {children}
      <ReactQueryDevtools
        initialIsOpen={false}
        buttonPosition="bottom-left"
        errorTypes={[
          {
            name: "Error",
            initializer: errorInitializer(new Error("Error")),
          },
          {
            name: "AxiosError",
            initializer: errorInitializer(new AxiosError("AxiosError")),
          },
        ]}
      />
    </TanStackQueryClientProvider>
  );
}

function errorInitializer(error: Error) {
  return (query: Query) => {
    query.reset();
    return error;
  };
}

export default QueryClientProvider;
