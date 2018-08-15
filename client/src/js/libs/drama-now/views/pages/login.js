define(function(){
  return {
    render: function(container, callbacks) {
      var input = '<input type="text" id="input" maxLength="6">';
      var enter = '<button id="enter">Enter</button>'
      container.innerHTML = input + enter;
    }
  };
});
