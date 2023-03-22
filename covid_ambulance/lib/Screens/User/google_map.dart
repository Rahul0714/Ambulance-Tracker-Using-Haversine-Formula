import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class DrawMap extends StatefulWidget {
  final Position currentPosition;
  LatLng dPosition;
  DrawMap({this.currentPosition, this.dPosition});
  @override
  _DrawMapState createState() => _DrawMapState();
}

class _DrawMapState extends State<DrawMap> {
  String googleApiKey = "GOOGLE MAP API KEY";
  Completer<GoogleMapController> _controller = Completer();
  //GoogleMapPolyline googleMapPolyline = googleMapPolyline(a);
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  BitmapDescriptor patientLocationIcon;
  BitmapDescriptor driverLocationIcon;
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    setMapPoints();
    setPolylines();
  }

  void setPolylines() async {
    LatLng uPosition = LatLng(
        widget.currentPosition.latitude, widget.currentPosition.longitude);
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey,
        PointLatLng(uPosition.latitude, uPosition.longitude),
        PointLatLng(widget.dPosition.latitude, widget.dPosition.longitude));
    if (result.points.isNotEmpty) {
      print(result);
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    setState(() {
      Polyline polyline = Polyline(
        polylineId: PolylineId("track1"),
        color: Colors.blue,
        points: polylineCoordinates,
      );
      _polylines.add(polyline);
    });
  }

  void setMapPoints() {
    setState(() {
      _markers.add(
        Marker(
            markerId: MarkerId("You"),
            icon: patientLocationIcon,
            position: LatLng(widget.currentPosition.latitude,
                widget.currentPosition.longitude),
            infoWindow:
                InfoWindow(title: "You", snippet: "Your current Position")),
      );
      _markers.add(
        Marker(
            markerId: MarkerId("Driver1"),
            icon: driverLocationIcon,
            position:
                LatLng(widget.dPosition.latitude, widget.dPosition.longitude),
            infoWindow: InfoWindow(
                title: "Driver", snippet: "Nearest Driver's current Position")),
      );
    });
  }

  void setCustomIcon() async {
    patientLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'images/userIcon.png');
    driverLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'images/ambulanceIcon.png');
  }

  @override
  void initState() {
    setCustomIcon();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Google "),
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          markers: _markers,
          polylines: _polylines,
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
              target: LatLng(widget.currentPosition.latitude,
                  widget.currentPosition.longitude),
              zoom: 15.0),
        ));
  }
}
