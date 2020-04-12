import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  final List<Map> coords;

  MapView(this.coords);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {


  GoogleMapController mapController;

  final LatLng _center = const LatLng(32.521563, -95.677433);
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  MarkerId selectedMarker;
  int _markerIdCounter = 1;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;

    print('WIDGETS');
    print(widget.coords);

    widget.coords.forEach((coord){
      String markerIdVal = 'marker_id_$_markerIdCounter';
      _markerIdCounter++;
      MarkerId markerId = MarkerId(markerIdVal);

      // Create a marker (in the future, increment markerIdCounter so that you can use it to generate IDs)
      Marker marker = Marker(
        markerId: markerId,
        position: LatLng(
            coord['lat'],
            coord['lng']
        ),
        infoWindow: InfoWindow(title: "Hello there", snippet: "Snippet"),
        onTap: () {
          _onMarkerTapped(markerId);
        },
      );

      setState(() {
        markers[markerId] = marker;
      });
    });
  }

  void _onMarkerTapped(MarkerId markerId) {
    // Do nothing
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: _center,
        zoom: 11.0,
      ),
      markers: Set<Marker>.of(markers.values),
    );
  }
}