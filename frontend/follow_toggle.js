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
  switch (this.followState){
    case "unfollowed":
      var buttonMessage = "Follow!";
      this.$el.prop("disabled", false);
      break;
    case "followed":
      buttonMessage = "Unfollow!";
      this.$el.prop("disabled", false);
      break;
    case "following":
      buttonMessage = "Following Now!";
      this.$el.prop("disabled", true);
      break;
    case "unfollowing":
      buttonMessage = "GoodBye Forever!";
      this.$el.prop("disabled", true);
      break;
  }


  this.$el.text(buttonMessage);
};

FollowToggle.prototype.handleClick = function (e) {
  var that = this;

  if (this.followState === "unfollowed") {
    this.followState = "following";
    var method = "POST";
  } else if (this.followState === "followed") {
    this.followState = "unfollowing";
    method = "DELETE";
  }
  this.render();

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
