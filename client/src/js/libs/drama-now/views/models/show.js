define(function(){
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
      wrapper.onclick = function() {
        var message = { topic: "show-click", link: show_params.link, time: show_params.timestamp };
        chrome.runtime.sendMessage(message, function(response) {});
      };

      var thumbnail = document.createElement('IMG');
      thumbnail.src = this.img;
      thumbnail.style.height = 50;
      thumbnail.style.width = 50;
      wrapper.appendChild(thumbnail);

      var header = document.createElement('H2');
      header.innerText = this.title + ': ' + this.episode;
      wrapper.appendChild(header);
      
      container.appendChild(wrapper);
    };
  };

  return Show;
});
