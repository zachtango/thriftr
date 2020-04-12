import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/product.dart';

class MapView extends StatefulWidget {
  final List<Map> coords;
  final List<Product> products;

  MapView(this.coords, this.products);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {


  GoogleMapController mapController;

  final LatLng _center = const LatLng(33.0648016 + 0.0005, -96.7495247 + 0.0005);
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  MarkerId selectedMarker;
  int _markerIdCounter = 1;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;

    print('WIDGETS');
    print(widget.products.toString());

    widget.products.forEach((product){
      String markerIdVal = 'marker_id_$_markerIdCounter';
      _markerIdCounter++;
      MarkerId markerId = MarkerId(markerIdVal);

      String name = product.name;
      String address = product.address;

      // Create a marker (in the future, increment markerIdCounter so that you can use it to generate IDs)
      Marker marker = Marker(
        markerId: markerId,
        position: LatLng(
            product.coords['lat'],
            product.coords['lng']
        ),
        infoWindow: InfoWindow(title: name, snippet: address),
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