import React from "react";
import ReactDOM from "react-dom";
import { VanetsProvider } from "./context/VanetsContext";
import "./index.css";
import App from "./App";

ReactDOM.render(
  <VanetsProvider>
    <React.StrictMode>
      <App />
    </React.StrictMode>
  </VanetsProvider>,
  document.getElementById("root")
);
