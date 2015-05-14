var persistResults = function(score) {
  $.ajax({
    url:'/persist_results',
    method: 'POST',
    data:{"score": score}

  }).done(function() {

  }).error(function(err){

    console.log(err);
  })
}

var trueScoreFromBinaryScore = function(binaryScore) {

  var trueScore = 0;
  var exponent = 2;

  for (var i = 2; i >= 0; i--) {
    if (binaryScore >= Math.pow(2, i)) {
      binaryScore -= Math.pow(2, i);
      trueScore += 1
    }
  }

  return trueScore;
}

$(document).ready(function(){

  $("#question1").fadeIn("slow");

  // for testing the trueScoreFromBinaryScore method
  // for (var i = 0; i < 8; i++ ) {
  //   var result = trueScoreFromBinaryScore(i);
  //   console.log("result is " + result + " for " + i);
  // }
  // return;

  var binaryScore = 0;

  $("#q1").click(function(){
    binaryScore += 1;
    $(this).css({"background-color": "#00b200", "color": "#ffffff"}).delay(1000);
    $(".incorrect1").css('opacity', '0').delay(1000);
    setTimeout(function() {
    }, 1000);
    $("#question1").delay(1000).fadeOut("fast", function() {
      $(this).delay(1000).hide();
    });
    $("#question2").delay(1000).fadeIn(1000, function() {
      $(this).show();
    });
  });

  $(".incorrect1").click(function(){
    $(".incorrect1").css("opacity", "0");
    $(this).css({"opacity": ".9", "background-color": "#B20912"}).delay(1000);
    setTimeout(function() {
      $(".incorrect1").css('opacity', '0');
    }, 1000);
    $("#q1").css({"background-color": "#00b200", "color": "#ffffff"}).delay(500);
    setTimeout(function() {
      $("#question1").delay(500).fadeOut("fast", function() {
        $(this).hide();
      });
      $("#question2").delay(700).fadeIn(1000, function() {
        $(this).show();
      });
    }, 1000);
  })

  $("#q2").click(function(){
    binaryScore += 2;
    $(this).css({"background-color": "#00b200", "color": "#ffffff"}).delay(1000);
    $(".incorrect2").css('opacity', '0').delay(1000);
    setTimeout(function() {
    }, 1000);
    $("#question2").delay(1000).fadeOut("fast", function() {
      $(this).delay(1000).hide();
    });
    $("#question3").delay(1000).fadeIn(1000, function() {
      $(this).show();
    });
  });

  $(".incorrect2").click(function(){
    $(".incorrect2").css("opacity", "0");
    $(this).css({"opacity": ".9", "background-color": "#B20912"}).delay(1000);
    setTimeout(function() {
      $(".incorrect2").css('opacity', '0');
    }, 1000);
    $("#q2").css({"background-color": "#00b200", "color": "#ffffff"}).delay(500);
    setTimeout(function() {
      $("#question2").delay(500).fadeOut("fast", function() {
        $(this).hide();
      });
      $("#question3").delay(700).fadeIn(1000, function() {
        $(this).show();
      });
    }, 1000);
  })


  $("#q3").click(function(){
    binaryScore += 4;
    console.log(binaryScore);
    $(this).css({"background-color": "#00b200", "color": "#ffffff"}).delay(1000);
    $(".incorrect3").css('opacity', '0').delay(1000);
    setTimeout(function() {
    }, 1000);
    $("#question3").delay(1000).fadeOut("fast", function() {
      $(this).hide();
    });
    $("#song-cover").delay(1200).animate({opacity: 1.0}, 800);

    var trueScore = trueScoreFromBinaryScore(binaryScore);
    if (trueScore > 1) {
      plural = "points";
    } else if (trueScore == 1) {
      plural = "point";
    }

    $("#score").text(trueScore);
    $("#plural").text(plural);
    $("#results").delay(3000).fadeIn()
    persistResults(binaryScore);
  });


  $(".incorrect3").click(function(){
    console.log(binaryScore);
    $(".incorrect3").css("opacity", "0");
    $(this).css({"opacity": ".9", "background-color": "#B20912"}).delay(1000);
    setTimeout(function() {
      $(".incorrect3").css('opacity', '0');
    }, 1000);
    $("#q3").css({"background-color": "#00b200", "color": "#ffffff"}).delay(500);
    setTimeout(function() {
      $("#question3").delay(500).fadeOut("fast", function() {
        $(this).hide();
      });
    }, 800);
    $("#song-cover").delay(1300).animate({opacity: 1.0}, 800);
    var trueScore = trueScoreFromBinaryScore(binaryScore);
    if (trueScore > 1) {
      plural = "points";
    } else if (trueScore == 1) {
      plural = "point";
    } else if (trueScore == 0) {
      plural = "points";
    }

    $("#score").text(trueScore);
    $("#plural").text(plural);
    $("#results").delay(3000).fadeIn()
    persistResults(binaryScore);
  });


  $("#AddedtoListenList").click(function(){
    $(this).html("<i class='fa fa-check'></i>&nbsp; Added to Listen List")
  })


});