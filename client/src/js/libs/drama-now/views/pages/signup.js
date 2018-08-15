define(function(){
  return {
    render: function(container, api, callbacks) {
      // Make API call
      container.innerHTML = '...';
      api.signup(function(response){ console.log(response)}, function(error){console.log(error)});
      //document.getElementById('got').onclick = callbacks.list;
    }
  };
});
