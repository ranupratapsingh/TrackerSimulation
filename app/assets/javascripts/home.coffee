config =
  zoom: 16

class MapWidget
  constructor: ()->
    @markers = []
    @map = null
  initialize: (markerArray)->
    num_markers = markerArray.length
    myLatLng = new (google.maps.LatLng)(markerArray[(num_markers-1)/2].x, markerArray[(num_markers-1)/2].y)
    myOptions =
      zoom: config.zoom
      center: myLatLng
      mapTypeId: google.maps.MapTypeId.ROADMAP
    @map = new (google.maps.Map)(document.getElementById('map-canvas'), myOptions)
    map = @map
    i = 0
    while i < num_markers
      coords = markerArray[i]
      myLatLng = new (google.maps.LatLng)(coords.x, coords.y)
      i++
      marker = new google.maps.Marker
        position: myLatLng
        icon: "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=#{i}|FF0000|000000"
        animation: google.maps.Animation.DROP
        map: map
      marker.setMap map
      @markers.push(marker)
    return

  moveMarkers: (markerArray)->
    i = 0
    num_markers = markerArray.length
    while i < num_markers
      coords = markerArray[i]
      marker = @markers[i]
      myLatLng = new (google.maps.LatLng)(coords.x, coords.y)
      marker.setPosition myLatLng
      i++
    return

  centerTo: (point)->
    myLatLng = new (google.maps.LatLng)(point.x, point.y)
    @map.panTo myLatLng

window.initMap = ->
  widget = null
  i = 0
  simulate = ()->
    success = (markerArray)->
      unless widget
        widget = new MapWidget()
        widget.initialize(markerArray)
      widget.moveMarkers(markerArray)
# logic to move map
      i++
      if i%5 == 0
        num_markers = markerArray.length
        widget.centerTo(markerArray[(num_markers-1)/2])
      simulate()
    $.getJSON('/marker_positions').then success

  simulate()

