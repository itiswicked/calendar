// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require_tree .

$(function(){ $(document).foundation(); });

var hideEditButtonAndQuant = function(element){
  $(element).parent().parent().children().remove();
};

var displayEditForm = function(element, default_path, quantity, id){
  var api_path = "/api" + default_path;
  $(element).html(
    "<form action='" + api_path + "'>" +
      "<div class='resource-update-quantity'>" +
        "<div class='resource-update-quantity-field-container'>" +
          "<input type='text' class='resource-update-quantity-field' value='" + quantity + "' id='resource-quantity-update"+ id +"'>" +
        "</div>" +
        "<div class='resource-update-quantity-field-submit-container'>" +
          "<a href='#'class='resource-update'>" +
            "<i class='material-icons'>done<i>" +
          "<a>" +
        "</div>" +
      "</div>" +
    "</form>"
  );
};

var displayQuantityAndButtons = function(element, event_id, resource_id, quantity){
  var editUrl = "/events/" + event_id + "/resources/" + resource_id
  var deleteUrl = "/api/resources/" + resource_id
  $($(element).parents()[3]).html(
    "<span>" + quantity + "</span>" +
    "<div class='resource-buttons'>" +
      "<a class='resource-edit' resource_id='"+ resource_id +"' href='"+ editUrl +"'>" +
        "<i class='material-icons'>create</i>" +
      "</a>" +
      "<a class='resource-delete' resource_id='"+ resource_id +"' rel='nofollow' data-method='delete' href='" + deleteUrl + "'>" +
        "<i class='material-icons delete'>clear</i>" +
      "</a>" +
    "</div>"
  );
}

var ResourceDeleteListener = function() {
  $(document).on('click', 'i.delete', function(event) {
    event.preventDefault();
    var anchor = $(this).parent();
    var url = anchor.attr('href');

    $.ajax({
      method: 'DELETE',
      type: "json",
      url: url,
      success: function(){
        anchor.parents()[2].remove();
      }
    });
    return false;
  });
}

var resourceEditListener = function() {
  $(document).on('click', 'a.resource-edit', function(event) {
    event.preventDefault();
    var cell = $(this).parents()[1];
    var value = $($(this).parents()[1]).children().first().text();
    var path_for_submit = $(this).attr('href');
    var id = $(cell).attr("id");

    hideEditButtonAndQuant(this);
    displayEditForm(cell, path_for_submit, value, id);
  });
}

var resourceUpdateListener = function() {
  $(document).on('click', 'a.resource-update', function(event) {
    event.preventDefault();
    var element = $(this);
    var url = $(element.parents()[2]).attr('action');
    var quantity = $($(element.parents()[1]).children()[0].children[0]).val();

    $.ajax({
      url: url,
      method: 'PATCH',
      data: { resource: { quantity: quantity } },
      success: function(response){
        displayQuantityAndButtons(
          element,
          response.event_id,
          response.id,
          response.quantity
        );
      }
    });
  });
}

var callAllListeners = function() {
  resourceEditListener();
  resourceUpdateListener();
  ResourceDeleteListener();
}

$(document).ready(function() {
  callAllListeners();
});
