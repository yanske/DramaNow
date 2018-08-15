define(function(require) {
  var container = document.getElementById('main-container');
  var callbacks = {home: initHome, login: initLogin, signup: initSignup, list: initList};

  function initHome() {
    var home = require('./pages/home');
    home.render(container, callbacks);
  }

  function initLogin() {
    var login = require('./pages/login');
    login.render(container, callbacks);
  }

  function initSignup() {
    var signup = require('./pages/signup');
    signup.render(container, callbacks);
  }

  function initList() {

  }
  
  initHome();
});
