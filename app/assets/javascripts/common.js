/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).on('turbolinks:load', function () {
  
  $( function() {
    // Code that makes pagination links ajax based
    $("body").on("click", ".pagination a" ,function() {
      $(".pagination").html("Page is loading...");
      $.getScript(this.href);
      return false;
    });

    // Code for adding custom video player to video tags
    $('video').mediaelementplayer({
      alwaysShowControls: false,
      videoVolume: 'horizontal',
      features: ['playpause','progress','volume','fullscreen']
    });
  });
 
  // Materialize labels and select
  $('select').material_select();
//  $('.modal-trigger').leanModal();
  //$('.modal').modal();
  Materialize.updateTextFields();
  // Company page tabs
  $('ul.tabs').tabs();
  // homepage paralax
  $('.parallax').parallax();
  $('.single_image').fancybox({
      parent: 'body',
      padding: 0,
      openEffect: 'elastic',
      closeBtn: false,
      arrows: false,
      afterLoad: function () {
        var url = $(this.element).data("url")
        $.get(url, {}, function (data) {})
      }
    })
    $('.recent_add').fancybox({
      parent: 'body',
      padding: 0,
      openEffect: 'elastic',
      closeBtn: false,
      arrows: false,
    })
  });
//       var run ;
//    run = function (){
//       var $latitude_new = document.getElementById('latitude_new');
//      var $longitude_new = document.getElementById('longitude_new');
//       var myLatlng_new = new google.maps.LatLng($latitude_new.value, $longitude_new.value);
//      alert("run");
//      var myOptions = {
//        zoom: 8,
//        center: myLatlng_new,
//        mapTypeId: google.maps.MapTypeId.ROADMAP
//      }
//      var map_new = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
//      map2 = new google.maps.Map(document.getElementById("map_canvas2"), myOptions);
//        var marker = new google.maps.Marker({
//        position: myLatlng_new,
//        map: map_new,
//        title: 'Set lat/lng values for this property',
//    });
//    }
//    run();
