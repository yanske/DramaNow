// Parse and record watching events every minute
require.config({ baseUrl: chrome.extension.getURL("/") });
require(
  ["js/libs/drama-now/parser/parser", "js/libs/drama-now/api/api"],
  function(parser, api) {
    var parseAndUpdate = function() {
      var result = parser.parse();
      api.watchingUpdate(result, function(){}, function(){});
    }

    window.onload = function() {
      // Op if logged in
      chrome.storage.sync.get(['key'], function(result) {
        if(result.key != null && parser.validSite()) {
          setInterval(parseAndUpdate, 10000);
        }
      });
    };
  }
);
