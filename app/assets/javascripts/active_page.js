// ターボリンクのロードが終わってから発動する
$(document).on("turbolinks:load", () => {
  var url = window.location.pathname;
  $('.navibar a[href="'+url+'"]').addClass('active');
});
