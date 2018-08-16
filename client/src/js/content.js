// Parse and record watching events every minute
require.config({ baseUrl: chrome.extension.getURL("/") });
require(["js/libs/drama-now/parser/parser", "js/libs/drama-now/api/api"], function(parser, api) {
  parser.parse();
});
