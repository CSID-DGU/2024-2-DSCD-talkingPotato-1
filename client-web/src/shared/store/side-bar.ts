import { create } from "zustand";
import { persist } from "zustand/middleware";
import { SideBarState } from "@shared/types";

export const useSideBarStore = create<SideBarState>()(
  persist(
    (set) => ({
      isExpanded: false,
      currentPage: "article",
      toggleExpand: () => set((state) => ({ isExpanded: !state.isExpanded })),
      expand: () => set({ isExpanded: true }),
      collapse: () => set({ isExpanded: false }),
      updatePage: (page) => set({ currentPage: page }),
    }),
    {
      name: "side-bar-storage",
    }
  )
);

export default useSideBarStore;
