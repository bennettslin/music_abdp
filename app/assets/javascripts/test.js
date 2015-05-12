var persistResults = function(score) {
  console.log("Here are the results");
  $.ajax({
    url:'/persist_results',
    method: 'POST',
    data:{"score": score}

  }).done(function() {

  }).error(function(err){

    console.log(err);
  })
}

$(document).ready(function(){

  var count = 0;

  $("#q1").click(function(){
    count += 1;
    $(this).css("background-color", "#00b200").delay(1000);
    $(".incorrect1").css('opacity', '0').delay(1000);
    setTimeout(function() {
    }, 1000);
    $("#question1").delay(1000).fadeOut("fast", function() {
      $(this).delay(1000).hide();
    });
    $("#question2").delay(400).fadeIn(1000, function() {
      $(this).show();
    });
  });

  $(".incorrect1").click(function(){
    $(this).css("background-color", "#ff0000").delay(1000);
    setTimeout(function() {
      $(".incorrect1").css('opacity', '0');
    }, 1000);
    $("#q1").css("background-color", "#00b200").delay(1000);
    setTimeout(function() {
      $("#question1").delay(1000).fadeOut("fast", function() {
        $(this).hide();
      });
      $("#question2").delay(1000).fadeIn(1000, function() {
        $(this).show();
      });
    }, 1000);
  })

  $("#q2").click(function(){
    count += 2;
    $(this).css("background-color", "#00b200").delay(1000);
    $(".incorrect2").css('opacity', '0').delay(1000);
    setTimeout(function() {
    }, 1000);
    $("#question2").delay(1000).fadeOut("fast", function() {
      $(this).hide();
    });
    $("#question3").delay(400).fadeIn(1000, function() {
      $(this).show();
    });
  });

  $(".incorrect2").click(function(){
    $(this).css("background-color", "#ff0000").delay(1000);
    setTimeout(function() {
      $(".incorrect2").css('opacity', '0');
    }, 1000);
    $("#q2").css("background-color", "#00b200").delay(1000);
    setTimeout(function() {
      $("#question2").delay(1000).fadeOut("fast", function() {
        $(this).hide();
      });
      $("#question3").delay(1000).fadeIn(1000, function() {
        $(this).show();
      });
    }, 1000);
  })


  $("#q3").click(function(){
    count += 4;
    console.log(count);
    $(this).css("background-color", "#00b200").delay(1000);
    $(".incorrect3").css('opacity', '0').delay(1000);
    setTimeout(function() {
    }, 1000);
    $("#question3").delay(700).fadeOut("fast", function() {
      $(this).hide();
    });
    $("#song-cover").delay(800).animate({opacity: 1.0}, 800);
    $("#score").text(count);
    $("#results").show();
    persistResults(count);
  });


  $(".incorrect3").click(function(){
    console.log(count);
    $(this).css("background-color", "#ff0000").delay(1000);
    setTimeout(function() {
      $(".incorrect3").css('opacity', '0');
    }, 1000);
    $("#q3").css("background-color", "#00b200").delay(1000);
    setTimeout(function() {
      $("#question3").delay(500).fadeOut("fast", function() {
        $(this).hide();
      });
    }, 800);
    $("#song-cover").delay(1200).animate({opacity: 1.0}, 800);
    $("#score").text(count);
    $("#results").show();
    persistResults(count);
  });

});