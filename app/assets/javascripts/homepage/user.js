$(document).ready(function () {
  $('body').on("click", "#follow_user_button", function () {
      var ele = $(this)
      var follow_user_id = $(this).data('user');
      var url = (ele.hasClass("follow")) ? "follow" : "unfollow"
      $.ajax({
        type: (ele.hasClass("follow")) ? "POST" : "PATCH",
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').last().attr('content'))},
        url: "/users/" + url,
        dataType: 'json',
        data: {'status': status, 'follow_user_id': follow_user_id},
        success: function (data) {
          if (data.status == 1) {
            var follow_text = (ele.hasClass("follow")) ? "unfollow" : "follow"
            ele.removeClass(url).addClass(follow_text)
            ele.text(follow_text)
          } else {
            alert("Some error while performing action")
          }
        }
      });
      return false
    });
});