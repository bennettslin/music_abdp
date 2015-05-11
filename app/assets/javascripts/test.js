$(document).ready(function(){


  $("#q1").click(function(){
    $("#question1").fadeOut("slow", function() {
      $(this).hide();
    });
    $("#question2").delay(400).fadeIn(1000, function() {
      $(this).show();
    });
  });

  $("#q2").click(function(){
    $("#question2").fadeOut("slow", function() {
      $(this).hide();
    });
    $("#question3").delay(400).fadeIn(1000, function() {
      $(this).show();
    });
  });

  $("#q3").click(function(){
    $("#question3").fadeOut("slow", function() {
      $(this).hide();
    });
    $("#song-cover").delay(400).animate({opacity: 1.0}, 800);
  });

});