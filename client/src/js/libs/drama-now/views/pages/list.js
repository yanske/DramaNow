define(function(require){
  return {
    render: function(container, api, callbacks, key) {
      var Show = require('../models/show');

      container.innerHTML = '<h1> LIST </h1>';
      api.watchList(key, function(response){
        var shows = []
        var rawShows = JSON.parse(response);
        for (var i = 0; i < rawShows.length; i++) {
          var newShow = new Show(i, rawShows[i]);
          shows.push(newShow);
          newShow.render(container);
        }
      }, function(err) {
        console.log(err);
      });
    }
  };
});
