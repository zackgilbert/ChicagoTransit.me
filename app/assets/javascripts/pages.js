// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

	function geo_error(err) {
		alert("Error: " + err.message);
		console.log(err);
	}

	function relocate_success(position) {
		window.location.href = '/locate?lat=' + position.coords.latitude + '&lng=' + position.coords.longitude + '&accuracy=' + position.coords.accuracy;
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
	});
	