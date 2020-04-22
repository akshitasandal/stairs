/* Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
*/
$(document).ready(function(){
    // var $select = $("#role_id").multiselect();//apply the plugin
    $("#role_id").multiselect('disable'); //disable it initially
    $('#user_id').change(function () {
        var get_user_id = $(this).val();
        $("#role_id").multiselect('deselect', ['1','2','3','4','5','6','7','8','9']);
        $.ajax({

            url: '/dashboard/roles/' + get_user_id,
            type: 'get',
            //      data: { '_token': $('input[name=_token]').val()},
            success: function (response) {
                $("#role_id").multiselect('enable');
                //$('.current_role').text("Current Role: " + $.trim(response.roleName));
                $("#role_id").multiselect('select', response.role_id);
                $("#role_id").multiselect('deselect', response.notInArray);
                $("#role_id").multiselect('refresh');
                
            }
        });
    });
	$("#role_form").validate({
        rules: {
          "user_id": {
            required: true
          },
        },
        //For custom messages
        messages: {
          "user_id": {
            required: "You need to select a User"
          },
        },
	});
});