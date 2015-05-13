$(function() {

  // clear modal when it's hidden
  $('#myModal').on('hidden.bs.modal', function() {
    console.log("my modal cleared");
    $(this).removeData('bs.modal');

    // removes modal large class
    $('#modal-sizing').removeClass('modal-lg');
  });

  // change favorites modal to large
  $('.ListenList').click(function(){
    $('#modal-sizing').addClass('modal-lg');
  })

})