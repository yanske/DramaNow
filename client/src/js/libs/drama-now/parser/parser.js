// Determine what site it is and call correct parser
define(function(require){
  var dramafever = require('./sites/dramafever');
  // var viki = ...
  
  // Determine which site
  const siteUrl = window.location.toString();
  function isDomain(domain) {
    var pat = '^https?://(?:[^/@:]*:[^/@]*@)?(?:[^/:]+\.)?' + domain + '(?=[/:]|$)';
    var re = new RegExp(pat, 'i');
    return re.test(siteUrl);
  }

  return {
    /* Expected Parse Info
     * {
     *    title: string (slug)
     *    site: string
     *    imgLink: string
     *    currentEpisode: int
     *    currentTime: int (seconds)
     *    currentEpisodeLength: int (seconds)
     *    latestEpisode: int
     * }
     */
    parse: function(){
      if (isDomain('dramafever.com')) {
        var results = dramafever.parse();
        results.site = 'dramafever';
        return results;
      } else {
        return null;
      }
    },

    // Returns true if on an accpeted site's episode page
    validSite: function(){
      if (isDomain('dramafever.com')) {
        return dramafever.validSite();
      } else {
        return false;
      }
    }
  };
});
