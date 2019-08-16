// ターボリンクのロードが終わってから発動する
$(document).on("turbolinks:load", () => {
  $('div.catch_picture').hide().fadeIn(2000);
});
