function smooth_scroll(target, duration) {
	var target = document.querySelector(target);
	var targetPos = target.getBoundingClientRect().top;
	var startPos = window.pageYOffset;
	var distance = targetPos - startPos;
	var startTime = null;
	
	function animation(currentTime) {
		if (startTime === null) startTime = currentTime;
		var timeElapsed = currentTime - startTime;
		var run = ease(timeElapsed, startPos, distance, duration);
		window.scrollTo(0, run);
		if (timeElapsed < duration) requestAnimationFrame(animation);
	}

	function ease(t, b, c, d) {
		t /= d / 2;
		if (t < 1) return c / 2 * t * t + b;
		t--;
		return -c / 2 * (t * (t - 2) - 1) + b;
	}

	requestAnimationFrame(animation);
}


var scrolltodogs = document.querySelector('.scrolltodogs');
scrolltodogs.addEventListener('click', function() {
	smooth_scroll('.dogs', 1000);
})

var next1 = document.querySelector('.next1');
next1.addEventListener('click', function() {
	smooth_scroll('.dogs', 1000);
})

var scrolltocooking = document.querySelector('.scrolltocooking');
scrolltocooking.addEventListener('click', function() {
	smooth_scroll('.food', 1000);
})

// var next2 = document.querySelector('.next2');
// next2.addEventListener('click', function() {
// 	smooth_scroll('.food', 1000);
// })

var scrolltomusic = document.querySelector('.scrolltomusic');
scrolltomusic.addEventListener('click', function() {
	smooth_scroll('.music', 1000);
})

// var next3 = document.querySelector('.next3');
// next3.addEventListener('click', function() {
// 	smooth_scroll('.music', 1000);
// })

//Get the button:
mybutton = document.getElementById("myBtn");

// When the user scrolls down 20px from the top of the document, show the button
window.onscroll = function() {scrollFunction()};

function scrollFunction() {
  if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
    mybutton.style.display = "block";
  } else {
    mybutton.style.display = "none";
  }
}

// When the user clicks on the button, scroll to the top of the document
function topFunction() {
  document.body.scrollTop = 0; // For Safari
  document.documentElement.scrollTop = 0; // For Chrome, Firefox, IE and Opera
} 

