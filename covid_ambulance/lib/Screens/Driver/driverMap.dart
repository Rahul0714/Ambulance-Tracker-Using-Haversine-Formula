import 'dart:async';

import 'package:covid_ambulance/Screens/Driver/categorizeP.dart';
import 'package:covid_ambulance/services/geolocator_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DriverMap extends StatefulWidget {
  final Position initialPosition;
  final LatLng patientPosition;
  DriverMap({this.initialPosition, this.patientPosition});
  @override
  _DriverMapState createState() => _DriverMapState();
}

class _DriverMapState extends State<DriverMap> {
  String googleApiKey = "GOOGLE API KEY";
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  BitmapDescriptor patientLocationIcon;
  final GeolocatorService _geolocatorService = GeolocatorService();
  Completer<GoogleMapController> _controller = Completer();
  void setMapPoints() {
    setState(() {
      _markers.add(
        Marker(
            markerId: MarkerId("Patient"),
            icon: patientLocationIcon,
            position: LatLng(widget.patientPosition.latitude,
                widget.patientPosition.longitude),
            infoWindow: InfoWindow(
                title: "Patient", snippet: "Patient's current Position")),
      );
    });
  }

  void setPolylines() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey,
        PointLatLng(
            widget.initialPosition.latitude, widget.initialPosition.longitude),
        PointLatLng(
            widget.patientPosition.latitude, widget.patientPosition.longitude));
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

  void initState() {
    _geolocatorService.getCurrentLocation().listen((position) {
      centerScreen(position);
    });
    setCustomIcon();
    super.initState();
  }

  void setCustomIcon() async {
    patientLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'images/userIcon.png');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
                target: LatLng(widget.initialPosition.latitude,
                    widget.initialPosition.longitude),
                zoom: 15),
            myLocationEnabled: true,
            mapType: MapType.normal,
            polylines: _polylines,
            markers: _markers,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              setMapPoints();
              setPolylines();
            },
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Align(
              alignment: Alignment.topRight,
              child: FloatingActionButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PatientCategory())),
                materialTapTargetSize: MaterialTapTargetSize.padded,
                backgroundColor: Colors.blue,
                child: const Icon(Icons.done, size: 36.0),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Future<void> centerScreen(Position position) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
          target: LatLng(position.latitude, position.longitude), zoom: 15),
    ));
  }
}
