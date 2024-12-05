import React from "react";
import { useSideBarStore } from "@shared/store";
import { SideBar } from "@widgets/side-bar";

interface props {
  children: React.ReactNode;
}

export default function RootLayout(props: props) {
  const isExpanded = useSideBarStore((state) => state.isExpanded);

  return (
    <div className="flex flex-row w-screen h-screen">
      <SideBar />
      <div
        className={`flex flex-1 flex-col ${isExpanded ? "ml-[288.4px] w-[calc(100%-288.4px)]" : "ml-24 w-[calc(100%-96px)]"}`}
      >
        {props.children}
      </div>
    </div>
  );
}
