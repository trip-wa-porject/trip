import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gpx/gpx.dart';
import 'package:location/location.dart';
import 'package:tripflutter/screens/gpx_page/gpx_controller.dart';

class MapWidget extends StatefulWidget {
  MapWidget({Key? key, this.gpxController}) : super(key: key);

  GpxController? gpxController;

  @override
  State<StatefulWidget> createState() => _MapState();
}

class _MapState extends State<MapWidget> {
  String googleAPiKey = 'AIzaSyAR4ABOvlLdPyaC4T_nyRHXVpCJPVSeOMU';
  late GoogleMapController mapController;

  /// GPX PolyLine Point List
  List<LatLng> points = [];

  /// Map Initial Position
  final double _originLatitude = 25.16171788826669,
      _originLongitude = 121.68912739863931;

  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polyLines = {};
  List<DateTime> routeRequireTime = [];

  @override
  void initState() {
    super.initState();
    // 載入GPX檔案路線
    loadGpxPointsData();

    widget.gpxController?.locationCallback = getCurrentLocation;
    widget.gpxController?.routeDistanceCallback = addStraightPolyLine;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GoogleMap(
          initialCameraPosition: CameraPosition(
              target: LatLng(_originLatitude, _originLongitude), zoom: 10),
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          tiltGesturesEnabled: true,
          compassEnabled: true,
          scrollGesturesEnabled: true,
          zoomGesturesEnabled: true,
          onMapCreated: onMapCreated,
          mapType: widget.gpxController != null
              ? widget.gpxController!.mapType.value!
              : MapType.normal,
          markers: Set<Marker>.of(markers.values),
          polylines: Set<Polyline>.of(polyLines.values),
          zoomControlsEnabled: GetPlatform.isWeb ? true : false,
        ),
      ),
    );
  }

  void onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  void getCurrentLocation() async {
    LocationData? locationData;
    try {
      locationData = await Location().getLocation();
    } on Exception {
      locationData = null;
    }
    zoomCameraPosition(locationData!.latitude!, locationData.longitude!);
  }

  void loadGpxPointsData() async {
    String gpxData =
        await DefaultAssetBundle.of(context).loadString('assets/gpx.txt');
    Gpx gpx = GpxReader().fromString(gpxData);
    for (var track in gpx.trks) {
      track.trksegs.asMap().forEach((index, value) => {
            value.trkpts.asMap().forEach((pointIndex, point) {
              points.add(LatLng(point.lat!, point.lon!));

              if (pointIndex == 0 || pointIndex == value.trkpts.length - 1) {
                routeRequireTime.add(point.time!);
              }
            })
          });
    }
    addOriginMarker();
    addPolyLine();

    var distance = getStraightLineDistance();
    var time = routeRequireTime.last.difference(routeRequireTime.first);
    widget.gpxController!.saveDistance(distance.toStringAsFixed(2));
    widget.gpxController!.saveTotalTime('${time.inHours}:${time.inMinutes - (time.inHours*60)}');
    widget.gpxController!
        .saveSpeed((distance / time.inHours).toStringAsFixed(2));
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

  void addStraightPolyLine() {
    Polyline polyline = Polyline(
        polylineId: const PolylineId("straightPolyLine"),
        width: 1,
        color: Colors.red,
        points: [
          LatLng(points.first.latitude, points.first.longitude),
          LatLng(points.last.latitude, points.last.longitude),
        ]);
    polyLines[const PolylineId("straightPolyLine")] = polyline;

    /// Update Map
    setState(() {});
  }

  void addPolyLine() {
    Polyline polyline = Polyline(
        polylineId: const PolylineId("mainPolyLine"),
        width: 3,
        color: Colors.red,
        points: points);
    polyLines[const PolylineId("mainPolyLine")] = polyline;

    /// Update Map
    setState(() {});

    /// Zoom to Route Atsrt Position
    zoomCameraPosition(points[0].latitude, points[0].longitude);
  }

  void zoomCameraPosition(double latitude, double longitude) {
    Timer(const Duration(milliseconds: 3000), () async {
      await mapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(latitude, longitude), zoom: 12)));
    });
  }

  double getStraightLineDistance() {
    var R = 6371; // Radius of the earth in km
    var dLat = deg2rad(points.first.latitude - points.last.latitude);
    var dLon = deg2rad(points.first.longitude - points.last.longitude);
    var a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(deg2rad(points.last.latitude)) *
            math.cos(deg2rad(points.first.latitude)) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);
    var c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    var d = R * c; // Distance in km
    return d; // Distance in km
  }

  dynamic deg2rad(deg) {
    return deg * (math.pi / 180);
  }
}
