// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready(function () {
  $(document).on('turbolinks:load', function () {
  $("#new_album").validate({
    rules: {
      "album[name]": {
        required: true,
      },
      "album[description]": {
        required: true,
        minlength: 5
      },
    },
    //For custom messages
    messages: {
      "album[name]": {
        required: "Enter a Album name",
      },
      "album[description]": {
        required: "Enter a User Description name",
        minlength: "Enter at least 5 characters"
      },
    },
    errorElement: 'div',
    errorPlacement: function (error, element) {
      var placement = $(element).data('error');
      if (placement) {
        $(placement).append(error)
      } else {
        error.insertAfter(element);
      }
    }

  });
  $(".edit_album").validate({
    rules: {
      "album[name]": {
        required: true,
      },
      "album[description]": {
        required: true,
        minlength: 5
      },
    },
    //For custom messages
    messages: {
      "album[name]": {
        required: "Enter a Album name",
      },
      "album[description]": {
        required: "Enter a User Description name",
        minlength: "Enter at least 5 characters"
      },
    },
    errorElement: 'div',
    errorPlacement: function (error, element) {
      var placement = $(element).data('error');
      if (placement) {
        $(placement).append(error)
      } else {
        error.insertAfter(element);
      }
    }

  });
  });
})
