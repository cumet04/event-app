import React from 'react';
import ReactDOM from 'react-dom';
import {UsersService} from './api';

const appDom = document.getElementById('app') as HTMLElement;

// dummy code for test
(async () => {
  await UsersService.registerUser({
    requestBody: {
      user: {
        name: 'name',
        email: 'email',
        password: 'Password1',
      },
    },
  });
  await UsersService.login({
    requestBody: {
      user: {
        email: 'email',
        password: 'Password1',
      },
    },
  });
  const u = await UsersService.getCurrentUser();
  console.log(u.user);
})();

ReactDOM.render(
  <React.StrictMode>
    <p>Hello, World!</p>
  </React.StrictMode>,
  appDom
);
