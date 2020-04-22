// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready(function () {

 
  var enableSubmit = function (ele) {
    $(ele).removeAttr("disabled");
  }
  $(document).on('turbolinks:load', function () {
    // $("#follow_button").click(function () {
    //   if ($(this).attr('disabled') == "disabled") {
    //     return false;
    //   }
    //   var that = this;
    //   $('#follow_button').attr("disabled", true);
    //   setTimeout(function () {
    //     enableSubmit(that)
    //   }, 300);
    // });

    // $('body').on("click", "#follow_button", function () {
    //   var ele = $(this)
    //   var company_id = $(this).data('company');
    //   var url = (ele.hasClass("subscribe")) ? "subscribe" : "unsubscribe"
    //   $.ajax({
    //     type: (ele.hasClass("subscribe")) ? "POST" : "PATCH",
    //     url: "/companies/" + url,
    //     dataType: 'json',
    //     data: {'status': status, 'company_id': company_id},
    //     success: function (data) {
    //       if (data.status == 1) {
    //         var follow_text = (ele.hasClass("subscribe")) ? "unsubscribe" : "subscribe"
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
    //     url: "/companies/" + url,
    //     dataType: 'json',
    //     data: {'status': status, 'company_id': company_id},
    //     success: function (data) {
    //       if (data.status == 1) {
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
    $(".card-class").hide();
      $('.read-more').on('click', function(e) {
        e.preventDefault()
        $(this).hide();
        $(".word-limit-overview").hide()
        $(".card-class").show();
        $(".read-less").show()
      });
      
    $(".read-less").hide()
      $('.read-less').on('click', function(e) {
        e.preventDefault()
        $(this).hide();
        $(".card-class").hide()
        $(".word-limit-overview").show();
        $(".read-more").show()
      });

    // Create form validations
    $("#new_company").validate({
      meta: "validate",
      rules: {
        "company[name]": {
          required: true,
        },
        "company[owner_name]": {
          required: true,
        },
        "company[website]": {
          required: true,
          url: true,
          remote: true,
          remote: {
            url: "/validate_slug",
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
        "company[overview]": {
          required: true,
        },
        "company[size]": {
          required: true,
        },
        "company[founded]": {
          required: true,
        },
        "company[primary_email]": {
          required: true,
          email: true,
        },
        "company[secondary_email]": {
          required: true,
          email: true
        },
        "company[primary_contact_number]": {
          required: true,
          number: true,
          minlength: 5
        },
        "company[secondary_contact_number]": {
          required: true,
          number: true,
          minlength: 5
        },
        "company[contact_person]": {
          required: true,
        },
        "company[city]": {
          required: true,
        },
      },
      //For custom messages
      messages: {
        "company[name]": {
          required: "Enter a company name",
        },
        "company[owner_name]": {
          required: "Enter a Owner name",
        },
        "company[website]": {
          required: "Enter a Website name",
          remote: (" Slug is already taken")
        },
        "compnay[overview]": {
          required: "Enter a Overview",
        },
        "company[size]": {
          required: "Enter a size",
        },
        "company[founded]": {
          required: "Enter company founded",
        },
        "company[primary_email]": {
          required: "Enter a Primary Email",
          email: "Enter a valid Email",
          remote: "Enter valid new email"
        },
        "company[secondary_email]": {
          required: "Enter a Secondary Email",
          email: "Enter a valid Email"
        },
        "company[primary_contact_number]": {
          required: "Enter a primary Contact Number",
          number: "Enter a valid Number",
          minlength: "Enter at least 5 characters"
        },
        "company[secondary_contact_number]": {
          required: "Enter a secondary Contact Number",
          number: "Enter a valid Number",
          minlength: "Enter at least 5 characters"
        },
        "company[contact_person]": {
          required: "Enter a Contact person",
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
      }
    });


    // Edit Form validations
    $(".edit_company").validate({
      rules: {
        "company[name]": {
          required: true,
        },
        "company[owner_name]": {
          required: true,
        },
        "company[website]": {
          required: true,
        },
        "company[latitude]": {
          required: true,
        },
        "company[overview]": {
          required: true,
        },
        "company[size]": {
          required: true,
        },
        "company[founded]": {
          required: true,
        },
        "company[primary_email]": {
          required: true,
          email: true,
        },
        "company[secondary_email]": {
          required: true,
          email: true
        },
        "company[primary_contact_number]": {
          required: true,
          number: true,
          minlength: 5
        },
        "company[secondary_contact_number]": {
          required: true,
          number: true,
          minlength: 5
        },
        "company[contact_person]": {
          required: true,
        },
        "company[city]": {
          required: true,
        },
      },
      //For custom messages
      messages: {
        "company[name]": {
          required: "Enter a company name",
        },
        "company[owner_name]": {
          required: "Enter a Owner name",
        },
        "company[primary_email]": {
          required: "Enter a Primary Email",
          email: "Enter a valid Email"
        },
        "company[secondary_email]": {
          required: "Enter a Secondary Email",
          email: "Enter a valid Email"
        },
        "company[primary_contact_number]": {
          required: "Enter a primary Contact Number",
          number: "Enter a valid Number",
          minlength: "Enter at least 5 characters"
        },
        "company[website]": {
          required: "Enter a Website name",
        },
        "company[latitude]": {
          required: "Please Select latitude Longitude.",
        },
        "company[overview]": {
          required: "Enter a Overview",
        },
        "company[size]": {
          required: "Enter a Size",
        },
        "company[founded]": {
          required: "Enter a Company founded",
        },
        "company[secondary_contact_number]": {
          required: "Enter a secondary Contact Number",
          number: "Enter a valid Number",
          minlength: "Enter at least 5 characters"
        },
        "company[contact_person]": {
          required: "Enter a Contact person",
        },
        "company[city]": {
          required: "Enter a City",
        }
      },
      errorElement: 'div',
      errorPlacement: function (error, element) {
        var placement = $(element).data('error');
        if (placement) {
          $(placement).append(error)
        } else {
          error.insertAfter(element);
        }
      }
    })
  })

//     $("#generate-url").click(function(){
//       var city = $("#city_id").val().split(" ").join("-")
//       var city = city.toLowerCase();
//       var functional_area = $("#functional_area_id").val().split(" ").join("-")
//       var functional_area = functional_area.toLowerCase();
//       var sort_search = $("#sort_search_id").val().split(" ").join("-")
//       var sort_search = sort_search.toLowerCase();
//       if (city == "" && functional_area == "" && sort_search == "") {
//         city = "location" 
//         functional_area = "category"
//         sort_search = "sort"
//         var url = "/view/"+ functional_area +"-in-"+city 
//         window.location = "http://"+window.location.host+url
//       }
//       else if (city == "" && functional_area && sort_search == "") {
//         city = "location" 
//         sort_search = "sort"
//         var url = "/view/"+ functional_area +"-in-"+city 

//         window.location = "http://"+window.location.host+url
//       }
//       else if (city && functional_area == "" && sort_search == "") {
//         functional_area = "category"
//         sort_search = "sort"
//         var url = "/view/"+ functional_area +"-in-"+city 
//         window.location = "http://"+window.location.host+url
//       }
//       else if (sort_search && functional_area && city == "") {
//         city = "location"
//         sort_search = "sort"
//         var url = "/view/"+ functional_area +"-in-"+city +"?sort="+sort_search
//         window.location = "http://"+window.location.host+url
//       }
//       else if (city && functional_area && sort_search == "") {
//         sort_search = "sort"
//         var url = "/view/"+ functional_area +"-in-"+city 
//         window.location = "http://"+window.location.host+url
//       }
//       else if (city == "" && functional_area == "" && sort_search ) {
//         city = "location" 
//         functional_area = "category"
//         var url = "/view/"+ functional_area +"-in-"+city +"?sort="+sort_search
//         window.location = "http://"+window.location.host+url
//       }
//       else if (city  && functional_area == "" && sort_search ) {
//         functional_area = "category"
//         var url = "/view/"+ functional_area +"-in-"+city +"?sort="+sort_search
//         window.location = "http://"+window.location.host+url
//       }
//       else if (city  && functional_area && sort_search ) {
//         var url = "/view/"+ functional_area +"-in-"+city +"?sort=" +sort_search
//         window.location = "http://"+window.location.host+url
//       }
//       else {
//         var url = "/view/"
//         window.location = "http://"+window.location.host+url
//       }
//       return false;
//     });
   
   
});

// // function show_map(latitude, longitude) {
// //   var zoom = 12;
// //   var LatLng = new google.maps.LatLng(latitude,longitude);
// //   var mapOptions = {
// //     mapTypeControl: true,
// //     mapTypeControlOptions: {
// //         style: google.maps.MapTypeControlStyle.HORIZONTAL_BAR,
// //         position: google.maps.ControlPosition.BOTTOM_LEFT
// //     },
// //     zoom: zoom,
// //     center: LatLng,
// //     panControl: true,
// //     zoomControl: true,
// //     scaleControl: true,
// //     mapTypeId: google.maps.MapTypeId.ROADMAP
// //   }
// //   var map = new google.maps.Map(document.getElementById('map'), mapOptions);
// //   $('#map_location').on('click', function () {
// //     setTimeout(function () {
// //       google.maps.event.trigger(map, 'resize');
// //       map.setZoom(12); //You need to reset zoom
// //       map.setCenter(LatLng);
// //     }, 100);
// //   });
// //   var marker = new google.maps.Marker({
// //     position: LatLng,
// //     map: map,
// //     title: 'Set lat/lng values for this property',
// //     draggable: true
// //   });
  
// //   $latitude = document.getElementById("latitude")
// //   $longitude = document.getElementById("longitude")
// //   if ($latitude && $longitude) {
// //     google.maps.event.addListener(marker, 'dragend', function (marker) {
// //       var latLng = marker.latLng;
// //       $latitude.value = latLng.lat();
// //       $longitude.value = latLng.lng();
// //     });
// //     var searchBox = new google.maps.places.SearchBox(document.getElementById('pac-input'));
// //     map.controls[google.maps.ControlPosition.TOP_CENTER].push(document.getElementById('pac-input'));
// //     google.maps.event.addListener(searchBox, 'places_changed', function () {
// //       searchBox.set('map', null);
// //       var places = searchBox.getPlaces();
// //       var data = $("#pac-input").val();
// //       $("#company_address").val(data)    
// //       var bounds = new google.maps.LatLngBounds();
// //       var i, place;
// //       for (i = 0; place = places[i]; i++) {
// //         (function (place) {
         
// //           var marker = new google.maps.Marker({
// //             position: place.geometry.location,
// //             map: place.geometry.location,
// //             title: 'Drag Me!',
// //             draggable: true
// //           });
// //           $latitude.value = place.geometry.location.lat();
// //           $longitude.value = place.geometry.location.lng();
// //           marker.bindTo('map', searchBox, 'map');

// //           google.maps.event.addListener(marker, 'dragend', function (marker) {
// //             var latLng = marker.latLng;
// //             $latitude.value = latLng.lat();
// //             $longitude.value = latLng.lng();
// //           });
// //           bounds.extend(place.geometry.location);
// //         }
// //         (place));

// //       }
// //       map.fitBounds(bounds);
// //       searchBox.set('map', map);
// //       map.setZoom(Math.min(map.getZoom(), 12));
// //     });
// //   }
// // }
// // function init_map() {
// //   var $latitude = $('#latitude');
// //   var $longitude = $('#longitude');
// //   var field = $("#company_address").val()
// //   if ($latitude.val() && $longitude.val()) {
// //     $("#pac-input").val(field)
// //     show_map($latitude.val(), $longitude.val())
// //   } else {
// //     var abc ="Chandigarh, India"
// //     $("#pac-input").val(abc)
// //     show_map( 30.741482 , 76.768066)
// //   }
// }


