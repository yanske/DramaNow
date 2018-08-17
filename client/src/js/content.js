// Parse and record watching events every minute
require.config({ baseUrl: chrome.extension.getURL("/") });
require(
  ["js/libs/drama-now/parser/parser"],
  function(parser) {
    window.onload = function() {
      // Op if logged in
      chrome.storage.sync.get(['key'], function(result) {
        if(result.key != null && parser.validSite()) {
          setInterval(function() {
            var message = {topic: "watching-update", user: result.key, payload: parser.parse()};
            chrome.runtime.sendMessage(message, function(response) {});
          }, 10000);
        }
      });
    };
  }
);
