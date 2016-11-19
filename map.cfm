
   

    <script>
		
      // Note: This example requires that you consent to location sharing when
      // prompted by your browser. If you see the error "The Geolocation service
      // failed.", it means you probably did not give permission for the browser to
      // locate you.

      function handleLocationError(browserHasGeolocation, infoWindow, pos) {
        infoWindow.setPosition(pos);
        infoWindow.setContent(browserHasGeolocation ?
                              'Error: The Geolocation service failed.' :
                              'Error: Your browser doesn\'t support geolocation.');
      }
	  
	  function set_lat_lng(lat,lng){
	    navigator.geolocation.getCurrentPosition(function(position) {
            var pos = {
              lat: lat,
              lng: lng
            };

            infoWindow.setPosition(pos);
            infoWindow.setContent('Location found.');
            map.setCenter(pos);
			 }, function() {
            handleLocationError(true, infoWindow, map.getCenter());
          
		  })
		  }
		  
    </script>
    
	


