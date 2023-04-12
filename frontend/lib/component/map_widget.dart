import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';

import '../models/schedule_model.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({Key? key, required this.keywordList}) : super(key: key);

  final List<Area> keywordList;

  @override
  State<StatefulWidget> createState() => _MapState();
}

class _MapState extends State<MapWidget> {
  late GoogleMapController mapController;

  final Map<String, Marker> _markers = {};

  //center 設定台灣玉山？
  final LatLng _center = const LatLng(25.0474428, 121.5170955);

  Future<void> _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    var googlePlace = GooglePlace('AIzaSyAR4ABOvlLdPyaC4T_nyRHXVpCJPVSeOMU');
    var response = await googlePlace.search.getTextSearch(widget.keywordList[0].city);
    final results = response!.results;

    setState(() {
      _markers.clear();
      if (results != null) {
        // for (final result in results) {
        final marker = Marker(
          markerId: MarkerId(results[0].name!),
          position: LatLng(results[0].geometry!.location!.lat!,
              results[0].geometry!.location!.lng!),
          infoWindow: InfoWindow(
              title: results[0].name, snippet: results[0].formattedAddress),
        );
        _markers[results[0].name!] = marker;
        // }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green[700],
      ),
      home: Scaffold(
        body: GoogleMap(
          mapType: MapType.none,
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 15.0,
          ),
          markers: _markers.values.toSet(),
        ),
      ),
    );
  }
}
