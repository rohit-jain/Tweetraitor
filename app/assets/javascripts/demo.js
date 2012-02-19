$(document).ready(function() {
		
	var timeouts = [];
	
	$("#dstart").click(function () {
		$('section').height(670);
		$('#cover').height(800);
	  $("#game_img").show("fast");
	  $('#dtweet').show("fast");
	  $('#cover').fadeTo("slow", 0.80);
	  $("#cover").show("slow");
	  $('#dstart').hide();
	  $("#dend").show();
	  $('#dend').css('z-index',2);
	  start();
	});
	
	$('#dstart_on').click(function (){
		start();
	});
	
	$('#show_game').click(function (){
		play();
	});
	
	function start(){
	  $("#dstart_on").hide("slow");
	  $("#show_game").hide("fast");
	  $('#dtweet').fadeIn(2000).css('z-index',2);
	  $('#read').css('margin-left',370).css('margin-top',170);
	  $('#read').html("Read the tweet.").fadeIn(200).delay(1000);
	  $('#read').css('z-index',2).delay(1000);
	  timeouts.push(setTimeout(spam, 5000 ));
	
	}
	function spam(){		
	  $('#dtweet').fadeIn(2000).css('z-index',1);
	  //$('#spam').show("fast");
	  $('#spam').fadeIn(2000).css('z-index',2);
	  $('#read').css({'margin-left':200 , 'margin-top':170, 'text-align':'center'});
	  $('#read').html("If it does not give any useful info.<br >Then TYPE the red word.").fadeIn(200);
	  $('#read').css('z-index',2).delay(1000);
	  timeouts.push(setTimeout(notspam, 5000 ));
	}
	function notspam(){		
	  $('#spam').fadeIn(2000).css('z-index',1);
	  $('#notspam').fadeIn(1000).css('z-index',2);
	  $('#read').css('z-index',0).delay(1000);
	  $('#read').css({'margin-left':260 , 'margin-top':350, 'text-align':'center'});
	  $('#read').html("If it is something useful.<br >Type the green word before the meteor hits the ship.").fadeIn(200).delay(1000);
	  $('#read').css('z-index',2).delay(1000);
	  timeouts.push(setTimeout(life, 5000 ));
	}
	function life(){		
	  $('#read').css('z-index',0).delay(1000);
	  $('#read').css('margin-left',305).css('margin-top',200);
	  $('#read').html("Make sure you dont run out of lives.").fadeIn(200).delay(1000);
	  $('#read').css('z-index',2).delay(1000);
	  $('#notspam').fadeIn(2000).css('z-index',1);
	  //$('#life').show("fast");
	  $('#life').fadeIn(1000).css('z-index',2);
	  timeouts.push(setTimeout(end, 2000));
	}
	function end(){				
	  $('#read').css('z-index',0).delay(1000);
	  $('#life').fadeIn(2000).css('z-index',0);
	  $("#dstart_on").show("fast");
	  $("#show_game").show("fast");
	}
	
	function play(){
		$('#read').css('z-index',2);
	  $('#read').css({'margin-left':386 , 'margin-top':492, 'text-align':'center'});
	  $('#read').html("Choose");
		$('#cric').show();
		$('#fball').show();
	}
	
	$("#dend").click(function (event) {
		event.stopPropagation();
		for(var i=0; i<timeouts.length; i++) clearTimeout(timeouts[i]);
		timeouts = []; //quick reset of the timer array you just cleared
		
		//Clear queue
		$('#spam').stop();
		$('#read').stop();
		$('#notspam').stop();
		$('#dtweet').stop();
		$('#life').stop();
	  
	  $('#read').hide();
	  $('#dtweet').hide();
	  $('#game_img').hide();
	  $('#spam').hide();
	  $('#notspam').hide();
	  $('#life').hide();
	  $('#dend').hide();
	  $('#dstart').show();
	  
	  //Get rid of buttons
	  $("#dstart_on").hide();
	  $("#show_game").hide();
		$('#cric').hide();
		$('#fball').hide();
		
	  $("#cover").fadeOut(1000);
	  $("#read").hide();
	  
	  $('section').height("");
		$('#cover').height("");
	});
});