import { create } from "zustand";
import { persist } from "zustand/middleware";

interface AccountState {
  aid: string | null;
  setAid: (aid: string) => void;
  clearAid: () => void;
}

export const useAccountStore = create<AccountState>()(
  persist(
    (set) => ({
      aid: null,
      setAid: (aid: string) => set({ aid }),
      clearAid: () => set({ aid: null }),
    }),
    {
      name: "account-storage",
    }
  )
);

export default useAccountStore;
