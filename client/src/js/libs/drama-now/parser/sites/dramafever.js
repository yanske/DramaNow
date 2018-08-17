define(function(){
  return {
    parse: function(){
      var result = {};
      const siteUrl = window.location.toString();

      //url: url
      result.url = siteUrl;

      //title: url
      var titlePattern = '/[A-Za-z0-9_-]+/$';
      var title = (new RegExp(titlePattern, 'i')).exec(siteUrl)[0].replace(/\//g,'');
      result.title = title;

      //thumbnail: watch-masthead__series-thumb
      var thumbnailElem = document.getElementsByClassName('watch-masthead__series-thumb');
      var thumbnail = thumbnailElem.length > 0 ? thumbnailElem[0].src : null;
      result.thumbnail = thumbnail;
      
      //currentEpisode: url
      var currentEpisodePattern = '[0-9]+/[A-Za-z0-9_-]+/$';
      var currentEpisodeRaw = (new RegExp(currentEpisodePattern, 'i')).exec(siteUrl)[0];
      var currentEpisode = Number(currentEpisodeRaw.substring(0, currentEpisodeRaw.indexOf('/')));
      result.currentEpisode = currentEpisode;

      //currentTime: vjs-progress-holder vjs-slider vjs-slider-horizontal
      //episodeLength: vjs-progress-holder vjs-slider vjs-slider-horizontal
      var timeElem = document.getElementsByClassName('vjs-progress-holder vjs-slider vjs-slider-horizontal');
      var timeBar = timeElem.length > 0 ? timeElem[0].getAttribute('aria-valuetext') : null; //0:00:00 of 1:23:33
      var stringTimeToInt = function(stringTime) {
        var hms = stringTime.split(':');
        var secondValue = 0;
        for (var i = 0; i < hms.length; i++) {
          secondValue += hms[i] * Math.pow(60, hms.length - i - 1);
        }
        return secondValue;
      }

      var currentTime = timeBar ? stringTimeToInt(timeBar.substring(0, timeBar.indexOf(' '))) : null;
      result.currentTime = currentTime;

      var episodeLength = timeBar ? stringTimeToInt(timeBar.substring(timeBar.lastIndexOf(' ') + 1)) : null;
      result.episodeLength = episodeLength;

      //latestEpisode: watch-view__section-title headline__section
      var latestEpisodeElem = document.getElementsByClassName('watch-view__section-title headline__section');
      var latestEpisodeHTML = latestEpisodeElem.length > 0 ? latestEpisodeElem[0].innerHTML : null;
      var latestEpisode = latestEpisodeHTML ? Number(latestEpisodeHTML.substring(0, latestEpisodeHTML.indexOf(' '))) : null;
      result.latestEpisode = latestEpisode;

      return result;
    },
    validSite: function(){
      /* Dramafever's episode structure:
       * https://www.dramafever.com/drama/[drama #]/[episode #]/[drama-slug]/
       */
      const siteUrl = window.location.toString();
      var pat = '^https?://www\\.dramafever\\.com/drama/[0-9]+/[0-9]+/[A-Za-z0-9_-]+/$';
      var re = new RegExp(pat, 'i');
      return re.test(siteUrl);
    }
  };
});
