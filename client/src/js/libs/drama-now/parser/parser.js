// Determine what site it is and call correct parser
define(function(require){
  var dramafever = require('./sites/dramafever');
  // Determine which site
  return {
    parse: function(){
      return dramafever.parse();
    },
    validSite: function(){
      return dramafever.validSite();
    }
  };
});
