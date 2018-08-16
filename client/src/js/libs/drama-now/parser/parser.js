// Determine what site it is and call correct parser
define(function(require){
  var dramafever = require('./sites/dramafever');
  return {
    parse: function(){
      console.log("INNNNN");
      dramafever.parse();
    }
  };
});
