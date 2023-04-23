import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gpx/gpx.dart';
import '../models/schedule_model.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({Key? key, required this.keywordList}) : super(key: key);

  final List<Area> keywordList;

  @override
  State<StatefulWidget> createState() => _MapState();
}

class _MapState extends State<MapWidget> {
  String googleAPiKey = 'AIzaSyAR4ABOvlLdPyaC4T_nyRHXVpCJPVSeOMU';
  late GoogleMapController mapController;

  /// PolyLine Point List
  List<LatLng> points = List.empty();
  /// Start Position
  final double _originLatitude = 25.16171788826669,
      _originLongitude = 121.68912739863931;

  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polyLines = {};

  @override
  void initState() {
    super.initState();
    loadGpxPointsData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: GoogleMap(
        initialCameraPosition: CameraPosition(
            target: LatLng(_originLatitude, _originLongitude), zoom: 10),
        myLocationEnabled: true,
        tiltGesturesEnabled: true,
        compassEnabled: true,
        scrollGesturesEnabled: true,
        zoomGesturesEnabled: true,
        onMapCreated: onMapCreated,
        markers: Set<Marker>.of(markers.values),
        polylines: Set<Polyline>.of(polyLines.values),
      )),
    );
  }

  void onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  void loadGpxPointsData() async {
    String gpxData =
    await DefaultAssetBundle.of(context).loadString('assets/gpx.txt');
    Gpx gpx = GpxReader().fromString(gpxData);
    for (var track in gpx.trks) {
      for (var segment in track.trksegs) {
        points = segment.trkpts
            .map((point) => LatLng(point.lat!, point.lon!))
            .toList();
      }
    }
    addOriginMarker();
    addPolyLine();
  }

  void addOriginMarker() {
    /// origin marker
    addMarker(LatLng(points[0].latitude, points[0].longitude), "origin",
        BitmapDescriptor.defaultMarker);

    /// destination marker
    addMarker(
        LatLng(points[points.length - 1].latitude,
            points[points.length - 1].longitude),
        "destination",
        BitmapDescriptor.defaultMarkerWithHue(90));
  }

  void addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  void addPolyLine() {
    Polyline polyline = Polyline(
        polylineId: const PolylineId("poly"),
        width: 3,
        color: Colors.red,
        points: points);
    polyLines[const PolylineId("poly")] = polyline;

    /// Update Map
    setState(() {});

    /// Zoom to Start Position
    Timer(const Duration(milliseconds: 1000), () async {
      await mapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(points[0].latitude, points[0].longitude),
              zoom: 12)));
    });
  }
}
