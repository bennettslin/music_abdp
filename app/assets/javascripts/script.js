// var myModalSubmit = function (e, form) {
//   e.preventDefault();

//   $.ajax({
//     url:form.attr('action'),
//     method:form.attr('method'),
//     data:form.serialize()

//   }).done(function(data) {
//     $('#myModal').modal('hide');

//   }).error(function(err){
//     alert('Something broke.');
//     console.log(err);
//   })
// }

$(function() {

  // clear modal when it's hidden
  $('#myModal').on('hidden.bs.modal', function() {
    console.log("my modal cleared");
    $(this).removeData('bs.modal');

  });

  // $('#myModal').on('submit','form', function(e) {
  //   console.log("my modal submitted");
  //   var form = $(this);
  //   myModalSubmit(e, form);
  // })
})