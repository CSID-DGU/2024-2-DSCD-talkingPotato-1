import React from "react";

interface props {
  children: React.ReactNode;
}

const DefaultLayout = (props: props) => {
  return (
    <div className="flex flex-col w-full h-full items-center justify-center">
      {props.children}
    </div>
  );
};

export default DefaultLayout;
