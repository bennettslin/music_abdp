$(function(){

  // clear modal when it's hidden
  $('#myModal').on('hidden.bs.modal', function() {
      $(this).removeData('bs.modal');
  });

  $('#myModal').on('submit','form',function(e) {
    e.preventDefault();
    var form = $(this);

    $.ajax({
      url:form.attr('action'),
      method:form.attr('method'),
      data:form.serialize()

    }).done(function(data){
      $('#myModal').modal('hide')
      console.log(data);

    }).error(function(err){
      alert('something broke.');
      console.log(err);
    })
  })
})