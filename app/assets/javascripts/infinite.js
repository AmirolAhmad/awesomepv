var SigInfinite = SigInfinite || {};
var lastLoadAt, loadNextPageAt, isLoadingNextPage;

SigInfinite.setup = function(opts){
  $(window).scroll(function() {
    if (SigInfinite.approaching()) {
      SigInfinite.loadNext(opts);
    }
  });
}

SigInfinite.approaching = function() {
  return ($(window).scrollTop() > $(document).height() - $(window).height() - 200);
}

SigInfinite.loadNext = function(opts) {
  var url = $(".js-page a.next_page").attr('href');
  if (isLoadingNextPage || !url){
    return;
  }else{
  }
  
  isLoadingNextPage = true;

  $.ajax({
    url: url,
    method: 'GET',
    data: opts,
    dataType: 'script',
    success: function() {
      isLoadingNextPage = false;
    }
  })
};