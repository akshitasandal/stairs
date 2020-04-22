// // Place all the behaviors and hooks related to the matching controller here.
// // All this logic will automatically be available in application.js.
// // You can use CoffeeScript in this file: http://coffeescript.org/

// // function to add ckeditor
$(document).ready(function () {
	$(document).ajaxStart(function () {
		$('#img-loader').show(); // show the gif image when ajax starts
	}).ajaxStop(function () {
		$('#img-loader').hide(); // hide the gif image when ajax completes
	});
	initPage();
	field_id = ""
});

function initPage() {
	$('.summernote').summernote({
		height: 200,
		focus: false,
		minHeight: null, // set minimum height of editor
		maxHeight: null,
		airMode: false,
		fontNames: ['Roboto', 'Calibri', 'Times New Roman', 'Arial'],
		fontNamesIgnoreCheck: ['Roboto', 'Calibri'],
		dialogsInBody: true,
		dialogsFade: true,
		disableDragAndDrop: false,
		cleaner: {
			action: 'both', // both|button|paste 'button' only cleans via toolbar button, 'paste' only clean when pasting content, both does both options.
			newline: '<br>', // Summernote's default is to use '<p><br></p>'
			notStyle: 'position:absolute;top:0;left:0;right:0', // Position of Notification
			icon: '<i class="note-icon">[Your Button]</i>',
			keepHtml: true, // Remove all Html formats
			keepOnlyTags: ['<p>', '<br>', '<ul>', '<li>', '<b>', '<strong>', '<i>', '<a>'], // If keepHtml is true, remove all tags except these
			keepClasses: false, // Remove Classes
			badTags: ['style', 'script', 'applet', 'embed', 'noframes', 'noscript', 'html'], // Remove full tags with contents
			badAttributes: ['style', 'start'], // Remove attributes from remaining tags
			limitChars: false, // 0/false|# 0/false disables option
			limitDisplay: 'both', // text|html|both
			limitStop: false // true/false
		},
		popover: {
			air: [
				['color', ['color']],
				['font', ['bold', 'underline', 'clear']]
			]
		},
		print: {
			//'stylesheetUrl': 'url_of_stylesheet_for_printing'
		},
		toolbar: [
			["style", ["style"]],
			["style", ["bold", "italic", "underline", "clear"]],
			["fontsize", ["fontsize"]],
			['font', ['strikethrough', 'superscript', 'subscript']],
			["color", ["color"]],
			["para", ["ul", "ol", "paragraph"]],
			["height", ["height"]],
			['insert', ['picture', 'hr']],
			['view', ['fullscreen', 'codeview']], // no insert buttons
			["table", ["table"]],
			// ["help", ["help"]],

		],

	});

	$('.note-popover').css({
		'display': 'none'
	});

	// summernote.focus
	$('.summernote').on('summernote.focus', function() {
		console.log('Editable area is focused');
		$('.summernote').css('box-shadow', '0 5px 11px 0 rgba(0,0,0,.18), 0 4px 15px 0 rgba(0,0,0,.15)');
	});

	// summernote.blur backup textarea
	$('.summernote').on('summernote.blur', function() {
		console.log('Editable area loses focus');
		$('.summernote').css('box-shadow', 'none');
		var $courrierMedical = $('.summernote').summernote('code');
	});

	$(".note-btn.btn.btn-light.btn-sm").on("click", function () {
		$(".modal.fade").remove()
		$(".modal-backdrop.fade.in").remove()
	})

	$(".note-icon-picture").click(function () {
		$("#blog_post_image").click();
		$("modal-backdrop.fade.in").addClass("modal-backdrop fade")
	})
	$("#blog_post_image").change(function () {
		$("#blog_post_form_upload").trigger('submit.rails');
	});
	$("#blog_post_form_upload").bind("ajax:error", function (e, data) {
		console.log(data)
	})

	$.fn.insertAtCaret = function (myValue) {
		myValue = myValue.trim();
		$(".note-editable").insertHtml(myValue);
		console.log(myValue);
	};

	var img_ids_array = []
	$("#blog_post_form_upload").bind("ajax:success", function (event, data, status, xhr) {
		img ="<div><a href='"+data.img_url+"' data-lightbox='blog_image'><img src='"+data.med_img_url+"' /></a></div>";
		var abc = $("#blog_post_body").val()
		$(".note-editable").html('<img src=' + data.med_img_url + ' >' + abc );
		var img_arr = data["image_id"]
		img_ids_array.push(img_arr)
		// show the scrollbar again and remove padding added to body
		$("body").removeClass("modal-open").css("padding", "0")
		$("#image_ids").val(img_ids_array)
	});


	// if ($("#blog_post_body").length) {
	// 	editor = CKEDITOR.replace( "blog_post_body", {
	// 		removePlugins: ('resize','wsc','scayt'),
	// 		removeButtons: ('Subscript,Superscript,NumberedList,BulletedList,RemoveFormat,Indent,Blocks.Bidi,Forms,Checkbox,Radio,Insert,Links,Cut,Copy,Paste,Undo,Redo,Anchor,Strike,Elements,Save,NewPage,Preview,Templates,Print,Paste,Find,Replace,SelectAll,SpellChecker,PasteFromWord,Form,TextField,Textarea,Selectionfield,Button,ImageButton,HiddenField,Select,Source,PasteText,Outdent,Blockquote,CreateDiv,BidiLtr,BidiRtl,Language,Link,Unlink,Anchor,Image,Flash,Table,HorizontalRule,Smiley,SpecialChar,PageBreak,Iframe,Styles,Font,FontSize,TextColor,BGColor,ShowBlocks,Maximize,About'),
	// 		enterMode: CKEDITOR.ENTER_BR,
	// 		allowedContent:true,
	// 		forcePasteAsPlainText:true,
	// 		extraAllowedContent:'*[*]{*}',
	// 		entities: false,
	// 		basicEntities: false,
	// 		forceSimpleAmpersand: true,
	// 		autoGrow_onStartup: true,
	// 		height: '200px',
	// 	});


	// 	editor.addCommand("mySimpleCommand", {
	// 		exec: function(edt) {
	// 			$("#blog_post_image").click();
	// 		}
	// 	});

	// 	editor.ui.addButton('SuperButton', {
	// 		label: "Add Photos",
	// 		command: 'mySimpleCommand',
	// 		toolbar: 'insert',
	// 		icon: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRiQLfOve0LtgZiIR-FLeQDLCVP6p6PDNZFfy3zo7xhszBrcDbmQw'
	// 	});
	// }

	$('#blog_post_post_category_ids').multiselect();

	// $("#blog_post_image").change(function(){
	// 	$("#blog_post_form_upload").trigger('submit.rails');
	// });

	// $("#blog_post_form_upload").bind("ajax:error", function(e, data){
	// 	console.log(data)
	// })
	$('.my_table').dataTable()

	// $(".form_blog_post").on("submit", function(e){
	// 	e.preventDefault()
	// 	var url = $(this).attr("action")
	// 	var formData = $(this).serialize();
	// 	$.ajax({
	// 		type:'post',
	// 		dataType: "json",
	// 		url:url,
	// 		data: formData,
	// 		dataFilter:function(result){
	// 			var json = JSON.parse(result);
	// 			if (json.status == true) {
	// 				true
	// 			} else {
	// 				return false;
	// 			}
	// 		}
	// 	})
	// })
	// var img_ids_array = []

	// $("#blog_post_form_upload").bind("ajax:success", function(event,data,status,xhr) {
	// 	var img ="<div><a href='"+data.img_url+"' data-lightbox='blog_image'><img src='"+data.med_img_url+"' /></a></div>";
	// 	CKEDITOR.instances["blog_post_body"].insertHtml(img);
	// 	var img_arr = data["image_id"]
	// 	img_ids_array.push(img_arr)
	// 	return $("#image_ids").val(img_ids_array)
	// });

	// $.fn.insertAtCaret = function (myValue) {
	// 	myValue = myValue.trim();
	// 	CKEDITOR.instances[$(this).attr("id")].insertHtml(myValue);
	// 	console.log(myValue);
	// };

	$.validator.addMethod('validatePostBody', function (value, element, param) {
		return validate_post_body(); // return bool here if valid or not.
	}, 'Your error message!');

	$.validator.addMethod('validateAddPhotos', function (value, element, param) {
		return validate_add_photos();
	}, 'Your error message!');

	$(".form_blog_post").validate({
		// ignore: ":hidden:not(.summernote),.note-editable.card-block",
		rules: {
			"blog_post[title]": {
				required: true,
				minlength: 10,
				maxlength: 150
			},
			"blog_post[body]": {
				validatePostBody: true,
			},
			"blog_post[post_category_ids][]": {
				required: true
			},

			// "blog_post[featured_image]":{
			// 	accept: "image/*"
			// },
			"blog_post[slug]": {
	          required: true,
	          remote: true,
	          remote: {
	            url: "/dashboard/validate_blog_post_slug",
	            type: "post",
	            dataType: "json",
	            dataFilter: function (data) {
	              var json = JSON.parse(data);
	              if (json.status == true) {
	                return true;
	              } else {
	                return false;
	              }
	            }
	          }
	        },

		},
		//For custom messages
		messages: {
			"blog_post[title]": {
				required: "Enter a title for Post",
				minlength: "Enter at least 10 characters",
				maxlength: "The characters should be less than 150"
			},
			"blog_post[body]": {
				validatePostBody: "Enter 150 characters",
			},
			"blog_post[post_category_ids][]": {
				required: "You must have to select a category.",
			},
			"blog_post[slug]": {
	    		required: "Enter slug here.",
	    		maxlength: "The characters should be less than 150.",
	    		remote: "Slug is alredy taken"
	    	},

			// "blog_post[featured_image]":{
			// 	accept:'Please upload an image',

			// },
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
		errorPlacement: function (error, blog_post_body) {
			error.appendTo(blog_post_body.parent());
		},
	});

	$("#blog_post_form_upload").validate({
		ignore: [],
		rules: {
			"blog_post_image[:blog_post]": {
				validatePostBody: "image/*"
			},
		},
		messages: {
			"blog_post_image[:blog_post]": {
				validatePostBody: 'Please Upload an image '
			},
		},
	});
	$('#blog_post_title').on("blur", function () {
		var remove_special_char = $(this).val().trim().replace(/[^a-z0-9\s]/gi, '')
		$(this).val(remove_special_char)
	});
	var post_tags = $("#blog_post_tags").val();
	if (post_tags) {
		var chip_tags = [];
		var chip_tags_array = post_tags.split(',')
		for (i = 0; i < chip_tags_array.length; i++) {
			chip_tags.push({tag: chip_tags_array[i]
			});
		}
	}
	$('#blog_post_tags').tagsinput({
		confirmKeys: [44, 32, 13]
	});

	// 	function validate_post_body() {
	//    //$("#blog_post_keywords").hide();
	// //		CKEDITOR.instances["blog_post_body"].updateElement();
	//    var editorcontent = $('#blog_post_body').val().trim().replace(/<[^>]*>/gi, '');
	//    editorcontent = $.trim(editorcontent);
	//    if (!editorcontent || editorcontent.length < 150) {
	//      return false
	//    } else {
	//      return true
	//    }
	// 	}
	$(".form_blog_post").on("keypress", function (e) {
		if (e.keyCode == 13) {
			return false;
		}
	});

	$("body").on("click", "#search_posts", function () {
		var url = "/dashboard/companies/posts"
		$(".my_table").load(url + " .my_table", {company_id: $("#company_id").val(), publish: $("#publish").val(), page: 1});

	})

	$("body").on("click", ".pagination a", function (e) {
		e.preventDefault();
		var url = $(this).attr("href")
		var page = url.split("?")[1]
		url = "/dashboard/companies/posts?" + page
		$(".filtered_content").load(url + " .filtered_content", {company_id: $("#company_id").val(), publish: $("#publish").val(), page: $(".current").text()});
	})

	$('#blog_post_title').on('keyup', function () {
		$('#blog_post_title').val($('#blog_post_title').val().replace(/[^a-z0-9\s]/gi, '').replace(/\s+/g, ' '));
	});

	$('#remove_featured_image').on('click', function () {
		var data_id = $("#blog_post_title").val().trim().toLowerCase().replace(/[^a-z0-9\s]/gi, '').trim().replace(/\s+/g, '-');
		$.ajax({
			type: 'get',
			dataType: "json",
			url: '/dashboard/remove_featured_image/' + data_id,
			dataFilter: function (result) {
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
