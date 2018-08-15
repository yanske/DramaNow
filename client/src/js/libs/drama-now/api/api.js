define(function(){
  const baseUrl = 'http://0.0.0.0:3000/';
  var httpRequest = function() {
    this.get = function(url, onSuccess, onError){
      var xmlHttp = new XMLHttpRequest();
      xmlHttp.onreadystatechange = function() {
        if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
          onSuccess(xmlHttp.responseText);
        } else {
          onError(xmlHttp.responseText);
        }
      }

      xmlHttp.open('GET', url, true);
      xmlHttp.send(null);
    },
    this.post = function(url, onSuccess, onError){

    }
  }

  return {
    signup: function(onSuccess, onError) {
      const requestUrl = baseUrl + 'users';
      var request = new httpRequest();
      request.post(url, onSuccess, onError);
    },
    login: function(key, onSuccess, onError){
      const requestUrl = baseUrl + 'users/valid?key=' + key;
      var request = new httpRequest();
      request.get(requestUrl, onSuccess, onError);
    }
  }
});
