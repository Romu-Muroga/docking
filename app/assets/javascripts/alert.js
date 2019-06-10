<<<<<<< HEAD
$(document).on("turbolinks:load", () => {
=======
// ターボリンクのロードが終わってから発動する
$(document).on('turbolinks:load', () => {
>>>>>>> Improved the symptom that the slide show of ranking list page is not displayed
  setTimeout("$('.alert').fadeOut('slow')", 3000)
});
