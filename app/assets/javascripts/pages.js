// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

	function geo_error(err) {
		if (err.message == 'User denied Geolocation') {
			window.location.href = '/error/user-denied';
		} else if ((err.message == 'Unable to Start') || (err.message.substr(0, 20) == "The operation couldn")) {
			window.location.href = '/error/geo-off';
		} else {
			alert("Geolocation Error: " + err.message);
			console.log(err);
			window.location.href = '/error?msg=' + err.message;
		}
	}

	function relocate_success(position) {
		window.location.href = '/located?lat=' + position.coords.latitude + '&lng=' + position.coords.longitude + '&accuracy=' + position.coords.accuracy;
	}

	function relocate() {
		//console.log('hi');
		if (geo_position_js.init()) {
		  geo_position_js.getCurrentPosition(relocate_success, geo_error);
		} else {
	  	error('Your browser does not support geolocation.');
		}
		return false;
	};
	
	$(function() {
		$('a.geo-location').tipsy({fade: true, gravity: 'e'});
		$('#pagination a').tipsy({fade: true, gravity: 's'});
	});
	