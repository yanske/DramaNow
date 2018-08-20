// On startup, load the new episodes
require(
  ["js/libs/drama-now/api/api"],
  function(api) {
    var intToTime = function(seconds) {
      var date = new Date(null);
      date.setSeconds(seconds); // specify value for SECONDS here
      return date.toISOString().substr(11, 8);
    }
    
    chrome.runtime.onMessage.addListener(function(request, sender, sendResponse) {
      if (request.topic == "watching-update") {
        api.watchingUpdate(request.user, request.payload, function(){}, function(){});
      } else if (request.topic == "show-click") {
        chrome.tabs.create({ url: request.link }, function(tab){
          var content = {
            code: ` alert("Begin watching at: ${intToTime(request.time)}");`
          };

          chrome.tabs.executeScript(tab.id, content);
        });
      }
    });
  }
);
