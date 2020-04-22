$(document).ready(function(){
// debugger
  // $(document).on('turbolinks:load', function () {
    
    var swiper = new Swiper('.swiper-container', {
      slidesPerView: 3,
    mousewheel: true,
    // spaceBetween: 30,
    scrollbar: {
        el: '.swiper-scrollbar',
        hide: true,
      },
    // Responsive breakpoints
  breakpoints: {
    // when window width is <= 767px
    767: {
      slidesPerView: 1,
      // spaceBetween: 20
    },
    // when window width is <= 998px
    998: {
      slidesPerView: 2,
      // spaceBetween: 20
    }
  },
      freeMode: true,
      navigation: {
        nextEl: '.swiper-button-next',
        prevEl: '.swiper-button-prev',
      },
    });

  // });
// $('.owl-carousel').owlCarousel();
 
    $('body').on("click", "#follow_button", function () {
      var ele = $(this)
      var company_id = $(this).data('company');
      var url = (ele.hasClass("subscribe")) ? "subscribe" : "unsubscribe"
      $.ajax({
        type: (ele.hasClass("subscribe")) ? "POST" : "PATCH",
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').last().attr('content'))},
        url: "/companies/" + url,
        dataType: 'json',
        data: {'status': status, 'company_id': company_id},
        success: function (data) {
          if (data.status == 1) {
            var follow_text = (ele.hasClass("subscribe")) ? "unsubscribe" : "subscribe"
            ele.removeClass(url).addClass(follow_text)
            ele.text(follow_text)
          } else {
            alert("Some error while performing action")
          }
        }
      });
      return false
    });

    $('body').on("click", ".bookmark_button", function () {
      console.log(this);
      var ele = $(this)
      var company_id = $(this).data('company');
      var url = (ele.hasClass("bookmark")) ? "bookmark" : "bookmarked"
      $.ajax({
        type: (ele.hasClass("bookmark")) ? "POST" : "PATCH",
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').last().attr('content'))},
        url: "/companies/" + url,
        dataType: 'json',
        data: {'status': status, 'company_id': company_id},
        success: function (data) {
          if (data.status == 1) {
            var bookmark_text = (ele.hasClass("bookmark")) ? $(".bookmark_button").find("i").attr("class", "fa fa-bookmark")  : $(".bookmark_button").find("i").attr("class", "fa fa-bookmark-o")
            ele.removeClass(url).addClass(bookmark_text)
            // ele.text(bookmark_text)
          } else {
            alert("Some error while performing action")
          }
        }
      });
      return false
    })

    $("#btnSearch").keyup(function(event) {
      var searchBox = $(this).val()
      if (event.keyCode === 13) {
        var location = searchBox.replace(/\s+/g, '-').toLowerCase();
        var url ="/view/"+"category-in-"+ location
        window.location = "http://"+window.location.host+url
        return false;
      }
    });

    $(".comp-categories ul li a").click(function(){
      var category = $(this).text().replace(/\s+/g, '-').toLowerCase();
      var url ="/view/"+category +"-in-location"
      window.location = "http://"+window.location.host+url
      $("this").addClass("active")
      return false;
    })
    
    $(".popular-locations ul li a").click(function(){
      var location = $(this).text().toLowerCase();
      var url ="/view/"+"category-in-" +location
      window.location = "http://"+window.location.host+url
      $("this").addClass("active")
      return false;
    })

    $("#generate-url").click(function(){
      var city = $("#city_id").val().split(" ").join("-")
      var city = city.toLowerCase();
      var functional_area = $("#functional_area_id").val().split(" ").join("-")
      var functional_area = functional_area.toLowerCase();
      var sort_search = $(".mySlides").val().split(" ").join("-")
      var sort_search = sort_search.toLowerCase();
      if (city == "" && functional_area == "" && sort_search == "") {
        city = "location" 
        functional_area = "category"
        sort_search = "sort"
        var url = "/view/"+ functional_area +"-in-"+city 
        window.location = "http://"+window.location.host+url
      }
      else if (city == "" && functional_area && sort_search == "") {
        city = "location" 
        sort_search = "sort"
        var url = "/view/"+ functional_area +"-in-"+city 

        window.location = "http://"+window.location.host+url
      }
      else if (city && functional_area == "" && sort_search == "") {
        functional_area = "category"
        sort_search = "sort"
        var url = "/view/"+ functional_area +"-in-"+city 
        window.location = "http://"+window.location.host+url
      }
      else if (sort_search && functional_area && city == "") {
        city = "location"
        sort_search = "sort"
        var url = "/view/"+ functional_area +"-in-"+city +"?sort="+sort_search
        window.location = "http://"+window.location.host+url
      }
      else if (city && functional_area && sort_search == "") {
        sort_search = "sort"
        var url = "/view/"+ functional_area +"-in-"+city 
        window.location = "http://"+window.location.host+url
      }
      else if (city == "" && functional_area == "" && sort_search ) {
        city = "location" 
        functional_area = "category"
        var url = "/view/"+ functional_area +"-in-"+city +"?sort="+sort_search
        window.location = "http://"+window.location.host+url
      }
      else if (city  && functional_area == "" && sort_search ) {
        functional_area = "category"
        var url = "/view/"+ functional_area +"-in-"+city +"?sort="+sort_search
        window.location = "http://"+window.location.host+url
      }
      else if (city  && functional_area && sort_search ) {
        var url = "/view/"+ functional_area +"-in-"+city +"?sort=" +sort_search
        window.location = "http://"+window.location.host+url
      }
      else {
        var url = "/view/"
        window.location = "http://"+window.location.host+url
      }
      return false;
    });

    $(".read-more-text").hide();
    $(".read-less").hide()

    $(".read-more" ).click(function(){
      $(".read-more-text").show();
      $(".read-less").show()
      $(".read-more" ).hide()
      $(".read-less-text").hide();
    })
    $(".read-less").click(function(){
      $(".read-less-text").show();
      $(".read-more").show()
      $(".read-more-text").hide();
      $(".read-less").hide()
    })
});
function show_map(latitude, longitude) {
  var zoom = 12;
  var LatLng = new google.maps.LatLng(latitude,longitude);
  var mapOptions = {
    mapTypeControl: true,
    mapTypeControlOptions: {
        style: google.maps.MapTypeControlStyle.HORIZONTAL_BAR,
        position: google.maps.ControlPosition.BOTTOM_LEFT
    },
    zoom: zoom,
    center: LatLng,
    panControl: true,
    zoomControl: true,
    scaleControl: true,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  }
  var map = new google.maps.Map(document.getElementById('map'), mapOptions);
  $('#map_location').on('click', function () {
    setTimeout(function () {
      google.maps.event.trigger(map, 'resize');
      map.setZoom(12); //You need to reset zoom
      map.setCenter(LatLng);
    }, 100);
  });
  var marker = new google.maps.Marker({
    position: LatLng,
    map: map,
    title: 'Set lat/lng values for this property',
    draggable: true
  });
  
  $latitude = document.getElementById("latitude")
  $longitude = document.getElementById("longitude")
  if ($latitude && $longitude) {
    google.maps.event.addListener(marker, 'dragend', function (marker) {
      var latLng = marker.latLng;
      $latitude.value = latLng.lat();
      $longitude.value = latLng.lng();
    });
    var searchBox = new google.maps.places.SearchBox(document.getElementById('pac-input'));
    map.controls[google.maps.ControlPosition.TOP_CENTER].push(document.getElementById('pac-input'));
    google.maps.event.addListener(searchBox, 'places_changed', function () {
      searchBox.set('map', null);
      var places = searchBox.getPlaces();
      var data = $("#pac-input").val();
      $("#company_address").val(data)    
      var bounds = new google.maps.LatLngBounds();
      var i, place;
      for (i = 0; place = places[i]; i++) {
        (function (place) {
         
          var marker = new google.maps.Marker({
            position: place.geometry.location,
            map: place.geometry.location,
            title: 'Drag Me!',
            draggable: true
          });
          $latitude.value = place.geometry.location.lat();
          $longitude.value = place.geometry.location.lng();
          marker.bindTo('map', searchBox, 'map');

          google.maps.event.addListener(marker, 'dragend', function (marker) {
            var latLng = marker.latLng;
            $latitude.value = latLng.lat();
            $longitude.value = latLng.lng();
          });
          bounds.extend(place.geometry.location);
        }
        (place));

      }
      map.fitBounds(bounds);
      searchBox.set('map', map);
      map.setZoom(Math.min(map.getZoom(), 12));
    });
  }
}
function init_map() {
  var $latitude = $('#latitude');
  var $longitude = $('#longitude');
  var field = $("#company_address").val()
  if ($latitude.val() && $longitude.val()) {
    $("#pac-input").val(field)
    show_map($latitude.val(), $longitude.val())
  } else {
    var abc ="Chandigarh, India"
    $("#pac-input").val(abc)
    show_map( 30.741482 , 76.768066)
  }
}  