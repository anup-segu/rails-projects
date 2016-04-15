var FollowToggle = require("./follow_toggle");
var UserSearch = require("./users_search");


$(function(){
  $("button.follow-toggle").each(function(idx, el){
    new FollowToggle(el);
  });

  $("nav.users-search").each(function(idx, el){
    new UserSearch(el);
  });
});
