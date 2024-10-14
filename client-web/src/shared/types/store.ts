import {SideBarPage} from "@shared/types/index.ts";

export interface SideBarState {
    isExpanded: boolean;
    currentPage: SideBarPage;
    toggleExpand: () => void;
    expand: () => void;
    collapse: () => void;
    updatePage: (page: SideBarPage) => void;
}