jQuery(function() {
  // if ($('#infinite-scrolling').size() > 0) {
    return $(window).on('scroll', function() {
      var more_posts_url; // <- /events?page=2
      more_posts_url = $('.pagination .next_page a').attr('href');
      console.log(more_posts_url);
      if (more_posts_url && $(window).scrollTop() > $(document).height() - $(window).height() - 250) {
        $('.pagination').html('<i class="fa-li fa fa-spinner fa-spin">');
        $.getScript(more_posts_url);
      }
      return;
    });
  // }
});