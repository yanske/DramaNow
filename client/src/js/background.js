// On startup, load the new episodes
require(
  ["js/libs/drama-now/api/api"],
  function(api) {
    chrome.runtime.onMessage.addListener(function(request, sender, sendResponse) {
      if (request.topic == "watching-update") {
        api.watchingUpdate(request.user, request.payload, function(){}, function(){});
      } else if (request.topic == "show-click") {
        chrome.tabs.create({ url: request.link });
      }
    });
  }
);
