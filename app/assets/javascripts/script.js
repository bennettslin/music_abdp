$(function() {

  // clear modal when it's hidden
  $('#myModal').on('hidden.bs.modal', function() {
    console.log("my modal cleared");
    $(this).removeData('bs.modal');

    // removes modal large class
    // $('#modal-sizing').width('default');
    $('#modal-sizing').removeClass('modal-xl');
  });

  // change favorites modal to large
  $('.ListenList').click(function(){
    $('#modal-sizing').addClass('modal-xl');
  })


  $(document).ready(function(){
    $('input').iCheck({
      checkboxClass: 'icheckbox_flat-red'
    });
  });

})