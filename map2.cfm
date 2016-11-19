    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <style>
      html, body {
        height: 50%;
        margin: 0;
        padding: 20;
      }
      ##map {
        height: 100%;
      }
    </style>
  
    <div id="map" style="height:500px;"></div>
	
<script>
jlat = '#resource.lat#';
jlng = '#resource.lng#';

var map = new google.maps.Map(document.getElementById('map'), {
          center: {lat: -34.397, lng: 150.644},
          zoom: 15
        });
        var infoWindow = new google.maps.InfoWindow({map: map});
		
if (jlat.length == 0){
	alert('0');
	
	$.get( "https://maps.googleapis.com/maps/api/geocode/json?address=#use_street#,+#use_city#,+#use_state#&key=AIzaSyBp1_uutb0Me0nhVbjcp_2oGZ2VfycAnHM", function( data ) {
		jdata = data;
		jlat = jdata.results[0].geometry.location.lat;
		jlng = jdata.results[0].geometry.location.lng;
	
	 $.get("update_lat_long.cfm?item_id=#resource.item_id#&lat=" + jlat + "&lng=" + jlng, function(data, status){
       // alert("Data: " + data + "\nStatus: " + status);
		});
		alert(jlat + ' ' + jlng);
	
	
        // Try HTML5 geolocation.
        if (navigator.geolocation) {
			 navigator.geolocation.getCurrentPosition(function(position) {
            var pos = {
              lat: jlat,
              lng: jlng
            };

            infoWindow.setPosition(pos);
            infoWindow.setContent('Location found.');
            map.setCenter(pos);
			 }, function() {
            handleLocationError(true, infoWindow, map.getCenter());
          
		  })
         
        } else {
          // Browser doesn't support Geolocation
          handleLocationError(false, infoWindow, map.getCenter());
        }
	});
	} else {
		alert('not 0');
	jlat = #resource.lat#;
	jlng = #resource.lng#;
	alert(jlat + ' ' + jlng);
	var map = new google.maps.Map(document.getElementById('map'), {
          center: {lat: -34.397, lng: 150.644},
          zoom: 15
        });
        var infoWindow = new google.maps.InfoWindow({map: map});
	
        // Try HTML5 geolocation.
        if (navigator.geolocation) {
			 navigator.geolocation.getCurrentPosition(function(position) {
            var pos = {
              lat: jlat,
              lng: jlng
            };

            infoWindow.setPosition(pos);
            infoWindow.setContent('Location found.');
            map.setCenter(pos);
			 }, function() {
            handleLocationError(true, infoWindow, map.getCenter());
          
		  })
         
        } else {
          // Browser doesn't support Geolocation
          handleLocationError(false, infoWindow, map.getCenter());
        }
	}
	
</script>