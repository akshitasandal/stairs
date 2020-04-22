 
$(document).on('ready', function () {
    var enableSubmit = function (ele) {
    $(ele).removeAttr("disabled");
  }
    //  $("#follow_user_button").click(function () {
    //   if ($(this).attr('disabled') == "disabled") {
    //     return false;
    //   }
    //   var that = this;
    //   $('#follow_user_button').attr("disabled", true);
    //   setTimeout(function () {
    //     enableSubmit(that)
    //   }, 3000);
    // });

    // $('body').on("click", "#follow_user_button", function () {
    //   var ele = $(this)
    //   var follow_user_id = $(this).data('user');
    //   var url = (ele.hasClass("follow")) ? "follow" : "unfollow"
    //   $.ajax({
    //     type: (ele.hasClass("follow")) ? "POST" : "PATCH",
    //     url: "/users/" + url,
    //     dataType: 'json',
    //     data: {'status': status, 'follow_user_id': follow_user_id},
    //     success: function (data) {
    //       if (data.status == 1) {
    //         var follow_text = (ele.hasClass("follow")) ? "unfollow" : "follow"
    //         ele.removeClass(url).addClass(follow_text)
    //         ele.text(follow_text)
    //       } else {
    //         alert("Some error while performing action")
    //       }
    //     }
    //   });
    //   return false
    // });

    // $('body').on("click", "#bookmark_button", function () {
    //   var ele = $(this)
    //   var company_id = $(this).data('company');
    //   var url = (ele.hasClass("bookmark")) ? "bookmark" : "bookmarked"
    //   $.ajax({
    //     type: (ele.hasClass("bookmark")) ? "POST" : "PATCH",
    //     url: "/" + url,
    //     dataType: 'json',
    //     data: {'status': status, 'company_id': company_id},
    //     success: function (data) {
    //       if (data.status == true) {
    //         var bookmark_text = (ele.hasClass("bookmark")) ? "bookmarked" : "bookmark"
    //         ele.removeClass(url).addClass(bookmark_text)
    //         ele.text(bookmark_text)
    //       } else {
    //         alert("Some error while performing action")
    //       }
    //     }
    //   });
    //   return false
    // })
    $(".card-class-bio").hide();
      $('.read-more-bio').on('click', function(e) {
        e.preventDefault()
        $(this).hide();
        $(".word-limit-overview-bio").hide()
        $(".card-class-bio").show();
        $(".read-less-bio").show()
      });
      
    $(".read-less-bio").hide()
      $('.read-less-bio').on('click', function(e) {
        e.preventDefault()
        $(this).hide();
        $(".card-class-bio").hide()
        $(".word-limit-overview-bio").show();
        $(".read-more-bio").show()
      });

  $("#new_user").validate({
    rules: {
      "user[first_name]": {
        required: true,
      },
      "user[last_name]": {
        required: true,
      },
      "user[email]": {
        required: true,
        email: true,
        remote: true,
          remote: {
            url: "/validate_useremail",
            type: "post",
            dataType:"json",
              dataFilter: function(data) {
                var json = JSON.parse(data);
                if(json.status == true) {
                  return true;
                } else {
                  return false;
                }
              }
          }
      },
      "user[password]": {
        required: true,
        minlength: 5
      },
      "user[password_confirmation]": {
        required: true,
        minlength: 5
      },
    },
    //For custom messages
    messages: {
      "user[first_name]": {
        required: "Enter a User First name",
      },
      "user[last_name]": {
        required: "Enter a User Last name",
      },
      "user[email]": {
        required: "Enter a  Email",
        email: "Enter a valid Email",
        remote: (" Email is already taken")
      },
      "user[password]": {
        required: "Enter a Password",
        minlength: "Enter at least 5 characters"
      },
      "user[password_confirmation]": {
        required: "Enter a Password",
        minlength: "Enter at least 5 characters"
      }
    },
      errorElement : 'div',
        errorPlacement: function(error, element) {
          var placement = $(element).data('error');
          if (placement) {
            $(placement).append(error)
          } else {
            error.insertAfter(element);
          }
        }

  });
  $(".edit_user").validate({
    rules: {
      "user[first_name]": {
        required: true,
      },
      "user[last_name]": {
        required: true,
      },
      "user[email]": {
        required: true,
        email: true
      },
      "user[password]": {
        required: true,
        minlength: 5
      },
      "user[password_confirmation]": {
        required: true,
        minlength: 5
      },
      "user[bio]": {
        required: true,
        minlength: 12
      },
      "user[skills]": {
        required: true,
        minlength: 5
      },
    },
    //For custom messages
    messages: {
      "user[first_name]": {
        required: "Enter a User First name",
      },
      "user[last_name]": {
        required: "Enter a User Last name",
      },
      "user[email]": {
        required: "Enter a  Email",
        email: "Enter a valid Email"
      },
      "user[password]": {
        required: "Enter a Password",
        minlength: "Enter at least 5 characters"
      },
      "user[password_confirmation]": {
        required: "Enter a Password",
        minlength: "Enter at least 5 characters"
      },
      "user[bio]": {
        required: "Enter a Bio",
        minlength: "Enter at least 10 characters"
      },
      "user[skills]": {
        required: "Enter a skill",
        minlength: "Enter at least 5 characters"
      }
    },
      errorElement : 'name',
        errorPlacement: function(error, element) {
          var placement = $(element).data('error');
          if (placement) {
            $(placement).append(error)
          } else {
            error.insertAfter(element);
          }
        }

  })
})
