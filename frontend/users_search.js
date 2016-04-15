var UserSearch = function (el) {
  this.$el = $(el);
  this.$input = this.$el.find("input");
  this.$ul = this.$el.find("ul");
  // this.handleInput.bind(this)''
  this.$input.on("input", this.handleInput.bind(this));
};

UserSearch.prototype.handleInput = function() {
  console.log("hello");
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
    $li.text(result.username);
    this.$ul.append($li);
  }.bind(this));

};

module.exports = UserSearch;
