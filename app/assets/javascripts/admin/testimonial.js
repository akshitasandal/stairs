/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function () {
  // Validate the form
  $("#new_testimonial").validate({
    rules: {
      "testimonial[title]": {
        required: true
      },
      "testimonial[content]": {
        required: true,
        url: true
      }
    },
    //For custom messages
    messages: {
      "testimonial[title]": {
        required: "Enter title for testimonial"
      },
      "testimonial[content]": {
        required: "Enter a Youtube, Vimeo or Video url",
        url: "Please enter a valid url"
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
  });

  // Handle the paste event
  $("#testimonial_content").on("paste change", function() {
    window.setTimeout(function() {
      var url = $("#testimonial_content").val()
      if( validateURL(url) ) {
        var embedUrl = convertURL(url)
        if( embedUrl ){
          $("iframe.testimonial_video").attr("src", embedUrl).removeClass("hide")
          $("#testimonial_content").val(embedUrl)
        } else
          return false
      } else {
        return false
      }
    }, 300)
  });
});

function validateURL(str) {
  return true
  var pattern = /^((https?):\/\/)?([w|W]{3}\.)+[a-zA-Z0-9\-\.]{3,}\.[a-zA-Z]{2,}(\.[a-zA-Z]{2,})?$/
  if(!pattern.test(str)) {
    return false;
  } else {
    return true
  }
}

function convertURL( url ) {
  var embedUrl = ""
  if( matchYoutubeUrl(url) ) {
    embedUrl = "//youtube.com/embed/"+matchYoutubeUrl(url)
  } else if (  matchVimeoUrl(url) ) {
    embedUrl = "//player.vimeo.com/video/"+matchVimeoUrl(url)
  } else if ( matchMp4Url(url) ) {
    embedUrl = url
  } else {
    alert("Video format not supported")
    return false
  }
  return embedUrl
}

function matchYoutubeUrl(url) {
  var p = /^(?:https?:\/\/)?(?:m\.|www\.)?(?:youtu\.be\/|youtube\.com\/(?:embed\/|v\/|watch\?v=|watch\?.+&v=))((\w|-){11})(?:\S+)?$/;
  if(url.match(p)) {
    return url.match(p)[1]
  }
  return false
}

function matchVimeoUrl(url) {
  var regExp = /^.*(vimeo\.com\/)((channels\/[A-z]+\/)|(groups\/[A-z]+\/videos\/))?([0-9]+)/;

  var match = url.match(regExp)
  if ( match ){
      return match[5]
  }
  return false
}

function matchMp4Url(url){
  var ext = url.split(".")
  if( ext[ext.length-1] == "mp4" ){
    return true
  }
  return false
}