// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .


$(document).ready( function() {

//  Highlight rant body when you mouse over it
  var rantLink = $(".rant-link")

  rantLink.on("mouseover", function() {
    $(this).toggleClass('mouseover-color')
  })


  rantLink.on("mouseleave", function() {
    $(this).toggleClass('mouseover-color')
  })

//--------------------------------------------

//  FAVORITE-UNFAVORITE A RANT

  $("body").on('click', ".favoriter", function(event) {
    event.preventDefault();
    var favoriteLink = $(event.target)
    var rantID = favoriteLink.attr('data-rant-id')
    var postFavoritePromise = $.post("/user/favorites", {rant_id: rantID})

    postFavoritePromise.success( function(favoriteValues) {

        if (favoriteValues[1] == 0) {
          var faveValue = ""
        }
        else {
          var faveValue = favoriteValues[1] + "-"
        }

      favoriteLink.html(faveValue + "Unfavorite")
      favoriteLink.attr('data-favorite-id', favoriteValues[0].id)
      favoriteLink.removeClass("favoriter")
      favoriteLink.addClass("unfavoriter")
    });
  });

  $('body').on('click',".unfavoriter", function(event) {
    event.preventDefault();

    var unfavoriteLink = $(event.target)
    var unfavoriteID = unfavoriteLink.attr('data-favorite-id')
    var deleteUnfavoritePromise = $.ajax({url: "/user/favorites/" + unfavoriteID, type:"DELETE"})

    deleteUnfavoritePromise.success( function(timesFavorited) {

        if (timesFavorited["times_favorited"] == 0) {
          var faveText = ""
        }
        else {
          var faveText = timesFavorited["times_favorited"] + "-"
        }

      unfavoriteLink.html(faveText + "Favorite")
      unfavoriteLink.attr('data-favorite-id', "")
      unfavoriteLink.removeClass("unfavoriter")
      unfavoriteLink.addClass('favoriter')

      if (location.pathname == "/user/favorites" ) {
        unfavoriteLink.parents(".favorites-block").hide()
      }

    });

  });

//--------------------------------------------

//  FOLLOW-UNFOLLOW A PERSON

  $("body").on('click', ".follower", function(event) {
    event.preventDefault();

    var followerLink = $(event.target)
    var ranterID = followerLink.attr('data-ranter-id')
    var postInterestingRanterPromise = $.post("/user/interesting_ranters/", {interesting_ranter_id: ranterID})

    postInterestingRanterPromise.success( function(interestingRanter) {
      var relatedFollowerLinks = $(".follower")
      relatedFollowerLinks.each( function() {
        var link = $(this)

        if (link.attr('data-ranter-id') == interestingRanter.followed_user_id) {
          link.html("Unfollow")
         link.attr('data-interesting-ranter-id', interestingRanter.id )
         link.removeClass("follower")
         link.addClass("unfollower")
        }
      })
    })
  })

  $("body").on('click', ".unfollower", function(event) {
    event.preventDefault();
    var unfollowerLink = $(event.target)
    var interestingRanterID = unfollowerLink.attr('data-interesting-ranter-id')
    var ranterID = unfollowerLink.attr('data-ranter-id')
    var deleteInterestingRanterPromise = $.ajax({url: "/user/interesting_ranters/" + ranterID, type: "DELETE"})

    deleteInterestingRanterPromise.success(function () {

      var relatedUnfollowerLinks = $(".unfollower")
      relatedUnfollowerLinks.each(function () {
        var link = $(this)

        if (link.attr('data-interesting-ranter-id') == interestingRanterID) {

          link.html("Follow")
          link.attr('data-interesting-ranter-id', "")
          link.removeClass("unfollower")
          link.addClass("follower")
        }

        if (location.pathname == "/user/interesting_ranters") {
          unfollowerLink.parents(".follow-block").hide()
        }
      })
    })
  })


//--------------------------------------------

//  SUBMIT A RANT

    $(".rant-form").on('click', ".rant-submitter", function(event) {
      event.preventDefault();
      $(".topic-errors").html("")
      $(".detail-errors").html("")

      var postRantPromise = $.post("/user/rants", {rant: {topic: rant_topic.value, details: rant_details.value}})
      postRantPromise.success( function(validationErrorMessages) {

        if (validationErrorMessages.errors) {
          $(".topic-errors").html(validationErrorMessages.errors.topic)
          $(".detail-errors").html(validationErrorMessages.errors.details)
        }
        else {
          location.reload();
        }

        })
    })


//  COLOR THE SELECTED SPAM/ALL BUTTON ON CLICK
  var search_value = $(".all-spam-block").attr('data-shown')
  var allButton = $("#all-filter")
  var spamButton = $("#spam-filter")

  if (search_value == 'true') {
    allButton.toggleClass("selected")
  }
  else {
    spamButton.toggleClass("selected")
  }
//-----------------------------------------




});