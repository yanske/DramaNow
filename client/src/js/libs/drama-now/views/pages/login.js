define(function(){
  return {
    render: function(container, api, callbacks) {
      var input = '<input type="text" id="input" maxLength="6">';
      var enter = '<button id="enter">Enter</button>'
      container.innerHTML = input + enter;

      document.getElementById('enter').onclick = function(){
        const userKey = document.getElementById('input').value;
        var onSuccess = function(response) {
          chrome.storage.sync.set({key: userKey}, function() {
            callbacks.list;
          });
        };

        api.login(userKey, onSuccess, function(error){console.log(error)});
      };
    }
  };
});
