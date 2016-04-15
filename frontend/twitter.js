var FollowToggle = require("./follow_toggle");

$(function(){
  $("button.follow-toggle").each(function(idx, el){
    new FollowToggle(el);
  });

});
