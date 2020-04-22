
  $(document).on('ready', function () {
    
  $("#user_search_form").on("submit", function(e){
    e.preventDefault()
    var url = $(this).attr("action")
    var formData = $(this).serialize();
    url = url + "?" + formData  
    $(".my_table").load(url  +" .my_table")
  })

  // function to unfollow a company from dashboard

   $('body').on("click", "#unfollow_company", function () {
      var company_id = $(this).data('company')
      $.ajax({
        type: "post",
        url: "/dashboard/unfollow_company",
        dataType: 'json',
        data: {'status': status, 'company_id': company_id},
        success: function (data) {
          if (data.status == 1) {
            $("#unfollow_company").closest("tr").remove();
          } else {
            alert("Some error while performing action")
          }
        }
      });
      return false
    });

   // function to remove bookmark from the company on dashboard
   $('body').on("click", "#remove_bookmark", function () {
      var company_id = $(this).data('company')
      $.ajax({
        type: "post",
        url: "/dashboard/remove_bookmark",
        dataType: 'json',
        data: {'status': status, 'company_id': company_id},
        success: function (data) {
          if (data.status == 1) {
            $("#remove_bookmark").closest("tr").remove();
          } else {
            alert("Some error while performing action")
          }
        }
      });
      return false
    });

    // function to unfollow a user from dashboard

    $('body').on("click", "#unfollow_user", function () {
      var follow_user_id = $(this).data('user');
      $.ajax({
        type: "post",
        url: "/dashboard/unfollow_user",
        dataType: 'json',
        data: { 'follow_user_id': follow_user_id},
        success: function (data) {
          if (data.status == 1) {
            $("#unfollow_user").closest("tr").remove();
          } else {
            alert("Some error while performing action")
          }
        }
      });
      return false
    });
  
  $(".my_table").dataTable()
  

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
        minlength: 8,
        equalTo : "#user_password"
      },
      "user[password_confirmation]": {
        required: true,
        minlength: 8,
        equalTo : "#user_password"
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
        minlength: "Enter at least 8 characters"
      },
      "user[password_confirmation]": {
        required: "Enter a Password",
        minlength: "Enter at least 8 characters"
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
  $("#edit_user_form").validate({
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
        // required: true,
        equalTo : "#user_password",
        minlength: 8
      },
      "user[password_confirmation]": {
        // required: true,
        equalTo : "#user_password",
        minlength: 8
      },
      "user[bio]": {
        // required: true,
        minlength: 12
      },
      "user[skills]": {
        // required: true,
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
        // required: "Enter a Password",
        minlength: "Enter at least 8 characters",
      },
      "user[password_confirmation]": {
        // required: "Enter a Password",
        minlength: "Enter at least 8 characters",
      },
      "user[bio]": {
        // required: "Enter a Bio",
        minlength: "Enter at least 10 characters"
      },
      "user[skills]": {
        // required: "Enter a skill",
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
