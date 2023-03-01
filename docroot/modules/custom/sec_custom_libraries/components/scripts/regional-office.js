jQuery(function($) {
  $(document).ready(function() {

    //check if mapboxgl is enabled
    if (mapboxgl === undefined || !mapboxgl.supported()){
      $('#regionalOfficeMap').before("<p>This map is not available on Chrome. Please use Safari or Microsoft Edge to view.</p>");
        return;
    }

    mapboxgl.accessToken = drupalSettings.mapboxToken;
    if (drupalSettings.isRegionalOfficesLandingPage) {
      // Main Regional Office Map - use custom markers/popups from mapbox
      var map = new mapboxgl.Map({
        container: 'regionalOfficeMap',
        style: drupalSettings.styleUrl,
        center: [drupalSettings.map.center.longitude, drupalSettings.map.center.latitude],
        zoom: drupalSettings.map.zoom
      });

      var popup = new mapboxgl.Popup({offset: [0, -15]});
      map.on('click', 'regional-offices', function(e) {
        window.open(e.features[0].properties.url, '_self');
      });
      map.on('mouseenter', 'regional-offices', function(e) {
        map.getCanvas().style.cursor = 'pointer';
        var feature = e.features[0];
        popup.setLngLat(feature.geometry.coordinates)
          .setHTML('<span>' + feature.properties.title + '</span>')
          .setLngLat(feature.geometry.coordinates)
          .addTo(map);
      });
      map.on('mouseleave', 'regional-offices', function(e) {
        map.getCanvas().style.cursor = 'grab';
        popup.remove();
      });
    } else {
      // Individual Office Map - use long/lat given in settings
      var map = new mapboxgl.Map({
        container: 'regionalOfficeMap',
        style: 'mapbox://styles/mapbox/streets-v11',
        center: [drupalSettings.map.center.longitude, drupalSettings.map.center.latitude],
        zoom: drupalSettings.map.zoom
      });

      // create the marker
      $('head').append('<style type="text/css">.mapboxgl-marker{width:12px;height:12px;background:#ffc236;border-radius:50%;border-color:white;border:solid 1px white;}</style>');
      var el = document.createElement('div');
      el.id = 'marker';
      new mapboxgl.Marker(el)
        .setLngLat([drupalSettings.map.center.longitude, drupalSettings.map.center.latitude])
        .addTo(map);
    }

  });
});
