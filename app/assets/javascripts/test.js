$(document).ready(function(){


  $("#q1").click(function(){
    $(this).css("background-color", "#00b200").delay(1000);
    $(".incorrect1").css('opacity', '0').delay(1000);
    setTimeout(function() {
    }, 9000);
    $("#question1").delay(1000).fadeOut("fast", function() {
      $(this).delay(1000).hide();
    });
    $("#question2").delay(400).fadeIn(1000, function() {
      $(this).show();
    });
  });

  $(".incorrect1").click(function(){
    $(".incorrect1").css('opacity', '0').delay(1000);
    $("#q1").css("background-color", "#00b200").delay(1000);
    setTimeout(function() {
    }, 9000);
    $("#question1").delay(1000).fadeOut("fast", function() {
      $(this).hide();
    });
    $("#question2").delay(400).fadeIn(1000, function() {
      $(this).show();
    });
  })

  $("#q2").click(function(){
    $(this).css("background-color", "#00b200").delay(1000);
    $(".incorrect2").css('opacity', '0').delay(1000);
    setTimeout(function() {
    }, 9000);
    $("#question2").delay(1000).fadeOut("fast", function() {
      $(this).hide();
    });
    $("#question3").delay(400).fadeIn(1000, function() {
      $(this).show();
    });
  });

  $(".incorrect2").click(function(){
    $(this).css("background-color", "#888888").delay(1000);
    $("#q2").css("background-color", "#00b200").delay(1000);
    $(".incorrect2").css('opacity', '0').delay(1000);
    setTimeout(function() {
    }, 9000);
    $("#question2").delay(1000).fadeOut("fast", function() {
      $(this).hide();
    });
    $("#question3").delay(400).fadeIn(1000, function() {
      $(this).show();
    });
  })

  $("#q3").click(function(){
    $(this).css("background-color", "#00b200").delay(1000);
    $(".incorrect3").css('opacity', '0').delay(1000);
    setTimeout(function() {
    }, 9000);
    $("#question3").delay(700).fadeOut("fast", function() {
      $(this).hide();
    });
    $("#song-cover").delay(800).animate({opacity: 1.0}, 800);
  });

  $(".incorrect3").click(function(){
    $(this).css("background-color", "#888888").delay(1000);
    $("#q3").css("background-color", "#00b200").delay(1000);
    $(".incorrect3").css('opacity', '0').delay(1000);
    setTimeout(function() {
    }, 9000);
    $("#question3").delay(700).fadeOut("fast", function() {
      $(this).hide();
    });
    $("#song-cover").delay(800).animate({opacity: 1.0}, 800);
  });

});