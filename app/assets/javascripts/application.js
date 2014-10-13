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


  $("body").on('click', ".favoriter", function(event) {
    console.log("favoriter was called")
    var favoriteLink = $(event.target)
    var rantID = favoriteLink.attr('data-rant-id')
    var postFavoritePromise = $.post("/user/favorites", {rant_id: rantID})

    postFavoritePromise.success( function(favoriteValues) {
      favoriteLink.html(favoriteValues[1] + "Unfavorite")
      favoriteLink.attr('data-favorite-id', favoriteValues[0].id)
      favoriteLink.removeClass("favoriter")
      favoriteLink.addClass("unfavoriter")
    });
  });

  $('body').on('click',".unfavoriter", function(event) {
    console.log("unfavoriter was called")
    var unfavoriteLink = $(event.target)
    var unfavoriteID = unfavoriteLink.attr('data-favorite-id')
    var deleteUnfavoritePromise = $.ajax({url: "/user/favorites/" + unfavoriteID, type:"DELETE"})

    deleteUnfavoritePromise.success( function(timesFavorited) {
      console.log("unfavoriter was SUCCESSFUL")
      unfavoriteLink.html(timesFavorited["times_favorited"] + "Favorite")

      unfavoriteLink.attr('data-favorite-id', "")
      unfavoriteLink.removeClass("unfavoriter")
      unfavoriteLink.addClass('favoriter')

    });

  });
//
////  Sort by the number of rants
//
//  $('#rant-count').on('click', function() {
//    console.log("i clicked on the rant sorter")
//
//
//  })





});