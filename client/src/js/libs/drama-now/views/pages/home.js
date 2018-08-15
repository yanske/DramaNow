define(function(){
  return {
    render: function(container, callbacks) {
      const logo = '<h1 class="logo">D</h1>';

      const signUp = '<button class="home" id="signup">Sign Up</button>';
      const login = '<button class="home" id="login">Log In</button>';
      const buttonRow = '<div class="home-row">' + signUp + login + '</div>';

      container.innerHTML = logo + buttonRow;

      //Set up callbacks
      document.getElementById('signup').onclick = callbacks.signup;
      document.getElementById('login').onclick = callbacks.login;
    }
  };
});
