define(function(){
  return {
    render: function(container, api, callbacks) {
      // Make API call
      container.innerHTML = '...';
      var onSuccess = function(userKey) {
        chrome.storage.sync.set({key: userKey}, function() {
          const key = '<h1>' + userKey + '</h1>';
          const button = '<button id="gotit">Got it!</button>'
          container.innerHTML = key + button;

          document.getElementById('gotit').onclick = callbacks.list;
        });
      };

      api.signup(onSuccess, function(error){ console.log("err" + error) });
    }
  };
});
