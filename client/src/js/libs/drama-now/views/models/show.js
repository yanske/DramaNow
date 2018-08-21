define(function(){
  var intToTime = function(seconds) {
    var date = new Date(null);
    date.setSeconds(seconds); // specify value for SECONDS here
    return date.toISOString().substr(11, 8);
  }

  var Show = function(id, show_params) {
    this.id = id;
    this.title = show_params.title;
    this.episode = show_params.episode;
    this.link = show_params.link;
    this.img = show_params.img;
    this.timestamp = show_params.timestamp;

    this.render = function(container){
      var wrapper = document.createElement('DIV');
      wrapper.id = 'show-' + this.id;
      wrapper.className = 'wrapper';
      wrapper.onclick = function() {
        var message = { topic: "show-click", link: show_params.link };
        chrome.runtime.sendMessage(message, function(response) {});
      };

      var imgWrapper = document.createElement('DIV');
      imgWrapper.className = "img-wrapper";

      var thumbnail = document.createElement('IMG');
      thumbnail.src = this.img;
      thumbnail.style.height = 50;
      thumbnail.style.width = 50;
      imgWrapper.appendChild(thumbnail);

      var contentWrapper = document.createElement('DIV');
      contentWrapper.className = "content-wrapper";

      var header = document.createElement('H4');
      header.innerText = this.title;

      var episodeText = 'Episode ' + this.episode;
      if (this.timestamp > 0) {
        episodeText += ' - ' + intToTime(this.timestamp);
      }

      var episode = document.createTextNode(episodeText);
      contentWrapper.appendChild(header);
      contentWrapper.appendChild(episode);

      wrapper.appendChild(imgWrapper);
      wrapper.appendChild(contentWrapper);
      container.appendChild(wrapper);
    };
  };

  return Show;
});
