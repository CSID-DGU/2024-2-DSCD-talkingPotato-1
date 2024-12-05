import React from "react";
import { useSideBarStore } from "@shared/store";
import { Expand } from "@widgets/side-bar/expand";
import { Dispose } from "@widgets/side-bar/dispose";

export default function SideBar(): React.ReactElement {
  const { isExpanded } = useSideBarStore();

  return (
    <div
      className={`
            fixed 
            left-0
            h-screen
            overflow-hidden
            flex
            flex-col
            items-center
            transition-[width]
            duration-100
            ease-in-out
            bg-primary-500
            ${
              isExpanded
                ? "w-[250px] flex-[0_0_250px] p-4 px-[19.2px] justify-start"
                : "w-24 flex-[0_0_96px] p-4 justify-start"
            }
        `}
    >
      {isExpanded ? <Expand /> : <Dispose />}
    </div>
  );
}
