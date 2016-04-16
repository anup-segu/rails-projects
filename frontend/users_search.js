var FollowToggle = require("./follow_toggle");

var UserSearch = function (el) {
  this.$el = $(el);
  this.$input = this.$el.find("input");
  this.$ul = this.$el.find("ul");
  this.$input.on("input", this.handleInput.bind(this));
};

UserSearch.prototype.handleInput = function(e) {
  console.log("hello");
  e.preventDefault();

  $.ajax({
    method: "GET",
    url: "/users/search",
    dataType: "json",
    data: {query: this.$input[0].value},
    success: function(resp) {
      this.renderResults(resp);
    }.bind(this)
  });
};

UserSearch.prototype.renderResults = function(resp) {
  this.$ul.empty();

  resp.forEach( function(result) {
    var $li = $("<li>");
    var $a = $("<a>")
      .attr("href","/users/"+result.id)
      .text(result.username);

    var $button = $("<button>");

    if (result.followed){
      var followState = "followed";
    } else {
      followState = "unfollowed";
    }

    var toggle = new FollowToggle($button,
      {userID: result.id, followState: followState });


    this.$ul.append($li.append($a, $button));
  }.bind(this));

};

module.exports = UserSearch;
