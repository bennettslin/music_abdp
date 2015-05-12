$(function() {

  // clear modal when it's hidden
  $('#myModal').on('hidden.bs.modal', function() {
    console.log("my modal cleared");
    $(this).removeData('bs.modal');

  });
})