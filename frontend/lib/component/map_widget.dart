import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gpx/gpx.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MapState();
}

class _MapState extends State<MapWidget> {
  String googleAPiKey = 'AIzaSyAR4ABOvlLdPyaC4T_nyRHXVpCJPVSeOMU';
  late GoogleMapController mapController;
  MapType _mapType = MapType.normal;

  /// GPX PolyLine Point List
  List<LatLng> points = [];
  String totalDistance = '';
  String totalTime = '';
  String speed = '';

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

    //載入GPX檔案後,儲存起點和終點的 LATLNG > 繪製一條直距離線
    // getRouteStraightDistance();

    //載入GPX檔案後,開始導航路線
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
        mapType: _mapType,
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
    // addStraightPolyLine();

    var distance = getStraightLineDistance();
    var time = routeRequireTime.last.difference(routeRequireTime.first);
    totalDistance = getStraightLineDistance().toStringAsFixed(2);
    totalTime =
        routeRequireTime.last.difference(routeRequireTime.first).toString();
    speed = (distance / time.inHours).toStringAsFixed(2);
    // print('distance: $totalDistance km');
    // print('distance(小數點後兩位): ${totalDistance.toStringAsFixed(2)} km');
    // print('endTime - startTime: hr: $time');
    // print('speed: m/hr: ${totalDistance / time.inHours}');
    // print('speed(小數點後兩位): m/hr: ${(totalDistance / time.inHours).toStringAsFixed(2)}');
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

  void changeMapType(MapType type) {
    _mapType = type;

    /// Update Map
    setState(() {});
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
