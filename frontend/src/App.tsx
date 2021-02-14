import React from 'react';
import {Route, BrowserRouter, Switch} from 'react-router-dom';
import {Top, Signup, Login} from '@/pages';
import {TheHeader} from '@/components/TheHeader';

const Routes = [
  {
    path: '/',
    title: undefined,
    component: Top,
  },
  {
    path: '/signup',
    title: 'Create account',
    component: Signup,
  },
  {
    path: '/login',
    title: 'Login',
    component: Login,
  },
];

export const App = () => {
  return (
    <BrowserRouter>
      <Switch>
        {Routes.map(route => (
          <Route
            exact
            key={route.path}
            path={route.path}
            component={() => (
              <>
                <TheHeader isLogin={false} title={route.title} />
                <route.component />
              </>
            )}
          />
        ))}
      </Switch>
    </BrowserRouter>
  );
};
