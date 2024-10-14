import {create} from 'zustand';
import {SideBarState} from "@shared/types";

export const useSideBarStore = create<SideBarState>((set) => ({
    isExpanded: false,
    currentPage: 'dashboard',
    toggleExpand: () => set((state) => ({isExpanded: !state.isExpanded})),
    expand: () => set({isExpanded: true}),
    collapse: () => set({isExpanded: false}),
    updatePage: (page) => set({currentPage: page}),
}));

export default useSideBarStore;