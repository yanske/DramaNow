define(function(require) {
  var container = document.getElementById('main-container');
  var api = require('../api/api');
  const callbacks = { home: initHome, login: initLogin, signup: initSignup, list: initList };

  function initHome() {
    var home = require('./pages/home');
    home.render(container, api, callbacks);
  }

  function initLogin() {
    var login = require('./pages/login');
    login.render(container, api, callbacks);
  }

  function initSignup() {
    var signup = require('./pages/signup');
    signup.render(container, api, callbacks);
  }

  function initList() {

  }
  
  initHome();
});
