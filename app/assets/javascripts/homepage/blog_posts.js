$(document).ready(function(){
	$(".all-latest-posts-div").hide()
  	$(".load-more-btn").on("click" , function(){

  		$(".load-more-btn").hide()
  		$(".four-latest-posts-div").hide();
  		$(".all-latest-posts-div").show()
  	$(".post-left-section").mCustomScrollbar({
  			theme:"dark-3"  
  		});
  	})



})