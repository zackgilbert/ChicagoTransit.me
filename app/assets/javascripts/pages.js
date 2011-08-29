// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

	function geoError(msg) {
		alert("Error: " + msg);
		//console.log('failed');
	  //console.log(msg);
		//console.log(arguments);
	}

	function relocateSuccess(position) {
		//console.log('success');
		window.location.href = '/?lat=' + position.coords.latitude + '&lng=' + position.coords.longitude + '&accuracy=' + position.coords.accuracy;
	}

	function relocate() {
		//console.log('hi');
		if (navigator.geolocation) {
			//console.log('searching...')
	  	navigator.geolocation.getCurrentPosition(relocateSuccess, geoError);
		} else {
	  	error('Your browser does not support geolocation.');
		}
		return false;
	};
	
	$(function() {
		$('a.geo-location').tipsy({fade: true, gravity: 'e'});
	});
	