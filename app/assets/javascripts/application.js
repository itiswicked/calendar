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
  var api_path = "/api" + default_path.substring(0, default_path.length - 5)
  $(element).html(
    "<form action='" + api_path + "'>" +
      "<div class='row'>" +
        "<div class='small-6 columns'>" +
          "<input type='text' value='" + quantity + "' id='resource-quantity-update"+ id +"' style='margin-bottom: 0;'>" +
        "</div>" +
        "<div class='small-6 columns'>" +
          "<input type='submit' value='Update' class='button tiny radius resource-update'>" +
        "</div>" +
      "</div>" +
    "</form>"
  );
};

var displayQuantityAndButtons = function(element, event_id, resource_id, quantity){
  $($(element).parents()[3]).html(
    "<span>" + quantity + "</span>" +
    "<div class='resource-buttons'>" +
      "<a class='button secondary tiny resource-edit' href='/events/" + event_id + "/resources/" + resource_id + "/edit'>Edit</a>" +
      "<a class='button alert tiny resource-delete' rel='nofollow' data-method='delete' href='/api/resources/'" + resource_id + "'>Delete</a>" +
    "</div>"
  );
}

$(document).ready(function(){
  $('a.button.alert.tiny.resource-delete').click(function(event){
    event.preventDefault();
    var anchor = $(this);
    var path = anchor.attr('href');

    $.ajax({
      method: 'DELETE',
      type: "json",
      url: path,
      success: function(){
        anchor.parents()[2].remove();
      }
    });
    return false;
  });

  $(document).on('click', 'a.button.secondary.tiny.resource-edit', function(event){
    event.preventDefault();
    var cell = $(this).parents()[1]
    var value = $($(this).parents()[1]).children().first().text()
    var path_for_submit = $(this).attr('href')
    var id = $(cell).attr("id")
    debugger;

    hideEditButtonAndQuant(this);
    displayEditForm(cell, path_for_submit, value, id);
  });

  $(document).on('click', 'input.button.tiny.radius.resource-update', function(event){
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
});
