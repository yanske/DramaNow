define(function(){
  const baseUrl = 'http://0.0.0.0:3000/';
  const status = { ok: 200, created: 201 }
  var httpRequest = function() {
    this.get = function(url, onSuccess, onError){
      var xmlHttp = new XMLHttpRequest();
      xmlHttp.onreadystatechange = function() {
        if (xmlHttp.readyState == 4 && xmlHttp.status == status.ok) {
          onSuccess(xmlHttp.responseText);
        } else {
          onError(xmlHttp.responseText);
        }
      }

      xmlHttp.open('GET', url, true);
      xmlHttp.send(null);
    },
    this.post = function(url, onSuccess, onError){
      var xmlHttp = new XMLHttpRequest();
      xmlHttp.onreadystatechange = function() {
        if (xmlHttp.readyState == 4 && xmlHttp.status == status.created) {
          onSuccess(xmlHttp.responseText);
        } else {
          onError(xmlHttp.responseText);
        }
      }

      xmlHttp.open('POST', url, true);
      xmlHttp.send(null);
    }
  }

  return {
    signup: function(onSuccess, onError) {
      const requestUrl = baseUrl + 'users';
      var request = new httpRequest();
      request.post(requestUrl, onSuccess, onError);
    },
    login: function(key, onSuccess, onError){
      const requestUrl = baseUrl + 'users/valid?key=' + key;
      var request = new httpRequest();
      request.get(requestUrl, onSuccess, onError);
    },
    watchingUpdate: function(payload, onSuccess, onError) {
      console.log(payload);
      onSuccess();
    }
  }
});
