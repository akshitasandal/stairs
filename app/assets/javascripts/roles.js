/* Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
*/
// $(document).ready(function(){
//     var $select = $("#role_id").multiselect();//apply the plugin
        
//     $select.multiselect('disable'); //disable it initially

//         $('#user_id').change(function () {
//             var get_user_id = $(this).val();
//             $select.multiselect('deselect', ['1','2','3','4','5','6','7','8','9']);
//             $.ajax({
//                 url: '/dashboard/roles/' + get_user_id,
//                 type: 'get',
//                 //      data: { '_token': $('input[name=_token]').val()},
//                 success: function (response) {
//                     $select.multiselect('enable');
//                     //$('.current_role').text("Current Role: " + $.trim(response.roleName));
//                     $select.multiselect('select', response.role_id);
//                     $select.multiselect('deselect', response.notInArray);
//                     $select.multiselect('refresh');
                    
//                 }
//             });
//         });
	
// });