define(function(){
  return {
    parse: function(){
      
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
