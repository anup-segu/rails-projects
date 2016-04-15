var FollowToggle = function (el) {
  this.$el = $(el);
  this.userID = this.$el.attr("data-user-id");
  this.followState = this.$el.attr("data-initial-follow-state");
  this.render();

  var that = this;
  this.$el.on("click", function(){
    that.handleClick();
  });
};

FollowToggle.prototype.render = function () {
  if (this.followState === "unfollowed") {
    var buttonMessage = "Follow!";
  } else {
    buttonMessage = "Unfollow!";
  }

  this.$el.text(buttonMessage);
};

FollowToggle.prototype.handleClick = function (e) {
  var that = this;
  // var url = "/users/"+ this.userID +"/follow";
  // e.preventDefault();
  console.log("handled");
  if (this.followState === "unfollowed") {
    var method = "POST";
  } else {
    method = "DELETE";
  }

  $.ajax({
    method: method,
    url: "/users/"+ this.userID +"/follow",
    dataType: "json",
    success: function(message){
      this.toggleState();
      this.render();
    }.bind(this)
  });


};

FollowToggle.prototype.toggleState = function() {
  if (this.followState === "followed"){
    this.followState = "unfollowed";
  } else {
    this.followState = "followed";
  }
};

module.exports = FollowToggle;
