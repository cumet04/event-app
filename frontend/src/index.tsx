import React from 'react';
import ReactDOM from 'react-dom';

const appDom = document.getElementById('app') as HTMLElement;

ReactDOM.render(
  <React.StrictMode>
    <p>Hello, World!</p>
  </React.StrictMode>,
  appDom
);
