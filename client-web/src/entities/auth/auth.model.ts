import { StateCreator } from "zustand";
import { devtools, DevtoolsOptions } from "zustand/middleware";
import { create } from "zustand";
import { createSelectors } from "@shared/lib/zustand";

export type createAuthStore = ReturnType<typeof useAuthStore>;

export function useAuthStore(config: {
  initialState?: Partial<State>;
  devtoolOptions: DevtoolsOptions;
}) {
  const { initialState, devtoolOptions } = config;

  const slice = createAuthSlice(initialState);
  const withDevtools = devtools(slice, devtoolOptions);
  const store = create(withDevtools);
  const useAuthStore = createSelectors(store);

  return useAuthStore;
}

function createAuthSlice(initialState?: Partial<State>) {
  const authSlice: StateCreator<
    State & Actions,
    [["zustand/devtools", never]],
    [],
    State & Actions
  > = (set) => ({
    ...defaultState,
    ...initialState,

    updateAccountId: (accountId) =>
      set(() => ({
        accountId,
      })),
    deleteAccountId: () =>
      set(() => ({
        accountId: "",
      })),
  });

  return authSlice;
}

const defaultState: State = {
  accountId: "",
};

type State = {
  accountId: string;
};

type Actions = {
  updateAccountId: (accountId: string) => void;
  deleteAccountId: () => void;
};
