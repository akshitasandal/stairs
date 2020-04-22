$(document).ready(function () {
	$("#new_post_category").validate({
		rules: {
      "post_category[name]": {
        required: true,
      },
    },
    //For custom messages
    messages: {
      "post_category[name]": {
        required: "Enter a Post Category name",
      },
    },
	});

  $(".my_table").dataTable()
});