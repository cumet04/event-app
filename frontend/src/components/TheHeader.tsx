import React from 'react';
import {Link} from 'react-router-dom';

export const TheHeader: React.FC<{title?: string; isLogin: boolean}> = ({
  title,
  isLogin,
}) => {
  return (
    <header className="hero is-primary">
      <div className="hero-head">
        <nav className="navbar">
          <div className="container">
            <div className="navbar-brand">
              <div className="navbar-item">
                <Link to="/">
                  <p className="title">Event App</p>
                </Link>
              </div>
            </div>
            {isLogin ? <MemberMenu /> : <AnonymousMenu />}
          </div>
        </nav>
      </div>
      {title && (
        <div className="hero-body">
          <div className="container has-text-centered">
            <p className="title">{title}</p>
          </div>
        </div>
      )}
    </header>
  );
};

const MemberMenu: React.FC = () => {
  return (
    <div className="navbar-menu navbar-end">
      <Link to="#" className="navbar-item">
        Logout
      </Link>
    </div>
  );
};

const AnonymousMenu: React.FC = () => {
  return (
    <div className="navbar-menu navbar-end">
      <Link to="/signup" className="navbar-item">
        Signup
      </Link>
      <Link to="/login" className="navbar-item">
        Login
      </Link>
    </div>
  );
};
