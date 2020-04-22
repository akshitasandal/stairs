// // Place all the behaviors and hooks related to the matching controller here.
// // All this logic will automatically be available in application.js.
// // You can use CoffeeScript in this file: http://coffeescript.org/

// // function to add ckeditor
$(document).ready(function () {
	 initPage();
	 field_id = ""
	 	// $('.companies-filter-content').hide()
	 	// $('.users-filter-content').hide()
		
	 	$("body").on("click", "#search-all", function () {
			var url = "/posts"
			$(".all-filter-content").load(url + " .all-filter-content", {search: $("#SearchSearch").val()});
		});

		$("body").on("click", "#search-blog-post", function () {
			var url = "/posts"
			$(".blog-post-filter-content").load(url + " .blog-post-filter-content", {search: $("#SearchSearch").val()});

		});
		
		$("body").on("click", "#search-companies", function () {
			var url = "/posts"
			$('.blog-post-filter-content').hide()
			$(".users-filter-content").hide()
			$('.companies-filter-content').show()
			$(".companies-filter-content").load(url + " .companies-filter-content", {search: $("#SearchSearch").val()});

		});

		$("body").on("click", "#search-users", function () {
			$('.blog-post-filter-content').hide()
			$('.companies-filter-content').hide()
			$(".users-filter-content").show()
			var url = "/posts"
			$(".users-filter-content").load(url + " .users-filter-content", {search: $("#SearchSearch").val()});

		});

	 	// $("#search-blog-post").click(function (){
	 	// 	debugger
	 	// 	// var search_input = $("#SearchSearch").val().split(" ").join("-")
	 	// 	// alert(search_input	)
	 	// 	$("#SearchForm").submit()

 		//  // 	if (search_input) {
		 //  //       city = "location" 
		 //  //       functional_area = "category"
		 //  //       sort_search = "sort"
		 //  //       var url = "/view/"+ functional_area +"-in-"+city 
		 //  //       window.location = "http://"+window.location.host+url
		 //  //   }

		 //  	window.location = "http://"+window.location.host + "/search-all"

	 	// });
	 //  $("#SearchForm input").keyup(function() {
	 //  	// debugger
	 // //  	$(".search-post-div").hide()
		// // $.ajax({
	 // //       url: window.location.origin + '/search',
	 // //       type: 'post',
	 // //       dataType: "json",
	 // //       data: $("#SearchForm").serialize(),
	 // //       dataFilter: function (data) {
		// // 		var json = JSON.parse(data);
		// // 		if (json.status == true) {
		// // 			console.log(json.blog_post)
		// // 			$('.search-post-div').before("<%= j render 'show_blog_post' %>");
		// // 			// $(".search-post-div").html(data)
		// // 		} else {
		// // 			return false;
		// // 		}
		// // 	}
  // //  		});
		// var url = '/posts'
		// $(".my-div-content").load(url + " .my-div-content", {blog_post:$("#SearchForm").serialize()});

 	// });
    // if ($('.pagination').length )  {
    //   	$(window).scroll(function () {
	   //      var url = $('.pagination .next_page a').attr('href');
	   //      if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 10) {
	   //        $('.pagination').text("Please Wait...");
	   //        return $.getScript(url);
	   //      }
    //   	});
    //   //return $(window).scroll();
    // }
 });

function initPage() {

 		if ($("#blog_post_body").length) {
			editor = CKEDITOR.replace( "blog_post_body", {
				removePlugins: ('resize','wsc','scayt'),
				removeButtons: ('Subscript,Superscript,NumberedList,BulletedList,RemoveFormat,Indent,Blocks.Bidi,Forms,Checkbox,Radio,Insert,Links,Cut,Copy,Paste,Undo,Redo,Anchor,Strike,Elements,Save,NewPage,Preview,Templates,Print,Paste,Find,Replace,SelectAll,SpellChecker,PasteFromWord,Form,TextField,Textarea,Selectionfield,Button,ImageButton,HiddenField,Select,Source,PasteText,Outdent,Blockquote,CreateDiv,BidiLtr,BidiRtl,Language,Link,Unlink,Anchor,Image,Flash,Table,HorizontalRule,Smiley,SpecialChar,PageBreak,Iframe,Styles,Font,FontSize,TextColor,BGColor,ShowBlocks,Maximize,About'),
				enterMode: CKEDITOR.ENTER_BR,
				allowedContent:true,
				forcePasteAsPlainText:true,
				extraAllowedContent:'*[*]{*}',
				entities: false,
				basicEntities: false,
				forceSimpleAmpersand: true,
				autoGrow_onStartup: true,
				height: '200px',
			});


		editor.addCommand("mySimpleCommand", {
  		exec: function(edt) {
      $("#blog_post_image").click();
  		}
		});
		editor.ui.addButton('SuperButton', {
	    label: "Add Photos",
	    command: 'mySimpleCommand',
	    toolbar: 'insert',
	    icon: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRiQLfOve0LtgZiIR-FLeQDLCVP6p6PDNZFfy3zo7xhszBrcDbmQw'
	  });
		}
		$("#blog_post_image").change(function(){
			$("#blog_post_form_upload").trigger('submit.rails');
		});

		$("#blog_post_form_upload").bind("ajax:error", function(e, data){
			console.log(data)
		})

		$.fn.insertAtCaret = function (myValue) {
			myValue = myValue.trim();
			CKEDITOR.instances[$(this).attr("id")].insertHtml(myValue);
			console.log(myValue);
		};
		var img_ids_array = []
		$("#blog_post_form_upload").bind("ajax:success", function(event,data,status,xhr){
			img ="<div><a href='"+data.img_url+"' data-lightbox='blog_image'><img src='"+data.med_img_url+"' /></a></div>";
			CKEDITOR.instances["blog_post_body"].insertHtml(img);
			var img_arr = data["image_id"]
			img_ids_array.push(img_arr)
			return $("#image_ids").val(img_ids_array)
		});
			// var abc = []
			// var img_arr = data["image_id"]
			// img_ids_array.forEach(function(item) {
	  //   	if (item != 0 && item != img_arr){
	  //   			var new_img = item
	  //   			abc.push(new_img)
	  //   			return $("#image_ids").val(abc)
	  //   	}
			// });
// validations
		$.validator.addMethod('validatePostBody', function(value,element, param){
	 		return validate_post_body(); // return bool here if valid or not.
			}, 'Your error message!');

			// $.validator.addMethod('validateAddPhotos', function(value, element,param){
		// 	return validate_add_photos();
		// }, 'Your error message!');



		$(".form_blog_post").validate({
			ignore: [],
			rules: {
				"blog_post[title]": {
					required: true,
					minlength: 10,
					maxlength: 150
				},
				 // "blog_post[slug]": {
     //      required: true,
     //      remote: true,
     //      remote: {
     //        url: "/validate_blog_post_slug",
     //        type: "post",
     //        dataType: "json",
     //        data:{id:$("#blog_post_slug").val(), slug:function(){
     //        	return $.trim($('#blog_post_slug').val().replace(/[^a-z0-9\s]/gi, '').replace(/[_\s]/g, '').toLowerCase())
     //        	}
     //      	},
     //        dataFilter: function (data) {
     //          var json = JSON.parse(data);
     //          if (json.status == true) {
     //            return true;
     //          } else {
     //            return false;
     //          }
     //        }
     //      }
     //    },

				"blog_post[body]": {
					validatePostBody: true,
				},
				"blog_post[post_category_id]": {
					required: true
				},

				"blog_post[featured_image]":{
		     	accept: "image/*"
				},

			},
	    //For custom messages
	    messages: {
	    	"blog_post[title]": {
	    		required: "Enter a title for Post",
	    		minlength: "Enter at least 10 characters",
	    		maxlength: "The characters should be less than 150"
	    	},
	    	// "blog_post[slug]": {
	    	// 	required: "Enter slug here.",
	    	// 	maxlength: "The characters should be less than 150.",
	    	// 	remote: "Slug is alredy taken"

	    	// },

	    	"blog_post[body]": {
	    		 validatePostBody: "Enter 150 characters",
	    	},

	    	"blog_post[post_category_id]": {
	    		required: "You must have to select a category.",
	    	},

	    	"blog_post[featured_image]":{
	    		accept:'Please upload an image',

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
	    },
	    errorPlacement: function(error, blog_post_body) {
	   		error.appendTo(blog_post_body.parent());
	 		},

	  });
	  $("#blog_post_form_upload").validate({
	  	ignore: [],
			rules: {
					"blog_post_image[:blog_post]":{
	    		validatePostBody:"image/*"
	    	},
			},
			messages: {
					"blog_post_image[:blog_post]":{
	    		validatePostBody:'Please Upload an image '
	    	},
	    },

	  });

	  $('#blog_post_title').on("blur", function() {
			var remove_special_char = $(this).val().trim().replace(/[^a-z0-9\s]/gi, '')
			$(this).val(remove_special_char)
	  });

		// $('#blog_post_title').one('blur',function(){
		// 	var title=$(this).val();
		// 	if(title){
		// 		var title_text=$(this).val().trim();
		// 		title_text=title_text.toLowerCase();
		// 		title_text=title_text.replace(/[^a-z0-9\s]/gi, '').trim().replace(/\s+/g, '-');
		// 		$('#blog_post_slug').val(title_text);
		// 	}
		// });

		// $('#blog_post_slug').on("change", function() {
		// 	var slug_val = $("#blog_post_slug").val().trim().toLowerCase().replace(/[^a-z0-9\s-]/gi, '').trim().replace(/\s+/g, '-').replace(/-{2,}/g,'-').replace(/^-+|-+$/g, "");
		// 		$('#blog_post_slug').val(slug_val);
		// });

    var post_tags = $("#blog_post_tags").val();
    if (post_tags){
    	var chip_tags = [];
	    var chip_tags_array = post_tags.split(',')
	    for(i=0; i < chip_tags_array.length; i++) {
	      chip_tags.push({tag: chip_tags_array[i]
	      });
	   	}
   	}

		$('.tag-chips').material_chip({
			data: chip_tags,
			placeholder: "Enter Tags",
			secondaryPlaceholder: "Enter tags",
		});
		$(".tag-chips").children().attr("id", "tag-chips_id")

		$('.tag-chips').on('chip.add', function(e, chip){
			var tags = $(".tag-chips").material_chip('data');
			var tag = []
			for (i=0; i<tags.length; i++) {
				tag.push(tags[i]['tag'])
			}
			$("#blog_post_tags").val(tag.join(","))
		});

		$('.tag-chips').on('chip.delete', function(e, chip){
	    blog_post_tags = $("#blog_post_tags").val()
	    tag_name = chip.tag
	    var count = 0
	    var abc = []
	    blog_post_tags.split(",").forEach(function(item) {
	    	if (item != 0 && item != tag_name){
	    			var new_string = item
	    			abc.push(new_string)
	    			return $("#blog_post_tags").val(abc.join(","))
	    	}
			});
    	$("#blog_post_tags").val(abc.join(","))
  	});

		$(".tag-chips").keypress(function(){
			if (field_id == ""){
					field_id = $(".tag-chips").children().attr("id")
			}
			if( event.keyCode == 32 || event.keyCode == 44 ){
				if ($("#"+field_id).val() != "" ){
 					$(".tag-chips").prepend('<div class="chip">'+ $("#"+field_id).val()+'<i class="material-icons close">close</i></div>')
					$(".tag-chips").material_chip('data').push({tag:$("#"+field_id).val()});
					var val = $("#blog_post_tags").val() + "," + $("#"+field_id).val()
					var new_val = val.replace(/(^,)|(,$)/g, "")
					$("#blog_post_tags").val(new_val)
					$("#"+field_id).val("")
				}
				return false;
			}
		});

    $(".tag-chips").keydown(function(){
    	if (field_id == ""){
				field_id = $(".tag-chips").children().attr("id")
			}
			if( event.keyCode == 9 ){
				if ($("#"+field_id).val() != "" ){
					$(".tag-chips").prepend('<div class="chip">'+ $("#"+field_id).val()+'<i class="material-icons close">close</i></div>')
					$(".tag-chips").material_chip('data').push({tag:$("#"+field_id).val()});
					var val = $("#blog_post_tags").val() + "," + $("#"+field_id).val()
					var new_val = val.replace(/(^,)|(,$)/g, "")
					$("#blog_post_tags").val(new_val)
					$("#"+field_id).val("")
				}
				return false;
			}
    });

   	$(".company-overview").on("click", function() {
   		$(".user-companies-div").hide()
   	})

   	$(".company-details").on("click", function() {
   		$(".user-companies-div").hide()
   	})
   	$(".company-location").on("click", function(){
   		$(".user-companies-div").hide()
   	})

		//$("#blog_post_keywords").hide();
		function validate_post_body(){
			CKEDITOR.instances["blog_post_body"].updateElement();
			var editorcontent=$('#blog_post_body').val().trim().replace(/<[^>]*>/gi, '');
			editorcontent = $.trim(editorcontent);
			if(!editorcontent || editorcontent.length<150) {
				return false
			} else {
				return true
			}
		}
		// function validate_add_photos(){
		// 	CKEDITOR.instances["blog_post_body"].updateElement();
		// 	var ext = $('#post_image').val().split('.').pop().toLowerCase();
		// 	if($.inArray(ext, ['gif','png','jpg','jpeg']) == -1)
		// 		{
		// 			
		// 			console.log("fsefsfsdf")

		// 		}
		// }

		$('#blog_post_title').on('keyup',function(){
			$('#blog_post_title').val($('#blog_post_title').val().replace(/[^a-z0-9\s]/gi, '').replace(/\s+/g, ' '));
		});

		$('#remove_featured_image').on('click',function(){
			var data_id=$("#blog_post_title").val().trim().toLowerCase().replace(/[^a-z0-9\s]/gi, '').trim().replace(/\s+/g, '-');
			$.ajax({
				type:'get',
				dataType: "json",
				url:'/remove_featured_image/'+data_id,
				dataFilter:function(result){
					var json = JSON.parse(result);
              if (json.status == true) {
                $("#featured_image_id").remove();
                $('#remove_featured_image').hide();
              } else {
                return false;
              }
				}
			})
		});




}
