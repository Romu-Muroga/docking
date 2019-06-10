// ターボリンクのロードが終わってから発動する
$(document).on('turbolinks:load', () => {
  setTimeout("$('.alert').fadeOut('slow')", 3000)
});
