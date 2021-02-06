import React from 'react';
import ReactDOM from 'react-dom';
import {UsersService} from './api';

const appDom = document.getElementById('app') as HTMLElement;

UsersService.getCurrentUser().then(({user}) => {
  console.log(user.name);
});

ReactDOM.render(
  <React.StrictMode>
    <p>Hello, World!</p>
  </React.StrictMode>,
  appDom
);
