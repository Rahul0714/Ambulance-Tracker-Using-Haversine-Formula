import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_ambulance/Screens/Driver/finsh.dart';
import 'package:covid_ambulance/main_method.dart';
import 'package:covid_ambulance/services/collection.dart';
import 'package:covid_ambulance/services/geolocator_service.dart';
import 'package:covid_ambulance/services/locModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map_polyutil/google_map_polyutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class WayToHospital extends StatefulWidget {
  final Position dPosition;
  final LatLng hPosition;
  WayToHospital({this.hPosition, this.dPosition});
  @override
  _WayToHospitalState createState() => _WayToHospitalState();
}

class _WayToHospitalState extends State<WayToHospital> {
  String googleApiKey = "GOOGLE MAP API KEY";
  Set<Marker> _markers = {};
  var polices;
  var p1, p2;
  BitmapDescriptor hospitalLocationIcon, policeLocationIcon, driverLocationIcon;
  //List polices = [];
  Set<Polyline> _polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  final GeolocatorService _geolocatorService = GeolocatorService();
  Completer<GoogleMapController> _controller = Completer();
  LatLng pLatLng;
  void setMapPoints() {
    setState(() {
      _markers.add(
        Marker(
            markerId: MarkerId("Hospital1"),
            icon: hospitalLocationIcon,
            position: LatLng(18.531565128340304, 73.87635964140719),
            infoWindow: InfoWindow(title: "Hospital")),
      );
      _markers.add(
        Marker(
            markerId: MarkerId("Hospital2"),
            icon: hospitalLocationIcon,
            position: LatLng(18.5316646732801, 73.86909508373486),
            infoWindow: InfoWindow(title: "Hospital")),
      );
      _markers.add(
        Marker(
            markerId: MarkerId("Hospital3"),
            icon: hospitalLocationIcon,
            position: LatLng(18.62597016002665, 73.7747652683917),
            infoWindow: InfoWindow(title: "Hospital")),
      );
      _markers.add(
        Marker(
            markerId: MarkerId("Hospital4"),
            icon: hospitalLocationIcon,
            position: LatLng(18.637660638498495, 73.79028469722805),
            infoWindow: InfoWindow(title: "Hospital")),
      );
      _markers.add(
        Marker(
            markerId: MarkerId("Hospital5"),
            icon: hospitalLocationIcon,
            position: LatLng(18.654771747298035, 73.76970484140925),
            infoWindow: InfoWindow(title: "Hospital")),
      );
      _markers.add(
        Marker(
            markerId: MarkerId("Hospital6"),
            icon: hospitalLocationIcon,
            position:
                LatLng(widget.hPosition.latitude, widget.hPosition.longitude),
            infoWindow: InfoWindow(title: "Hospital")),
      );
      _markers.add(
        Marker(
            markerId: MarkerId("Driver"),
            icon: driverLocationIcon,
            position:
                LatLng(widget.dPosition.latitude, widget.dPosition.longitude),
            infoWindow: InfoWindow(title: "Ambulance Driver")),
      );
    });
  }

  void setPolylines() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey,
        PointLatLng(widget.dPosition.latitude, widget.dPosition.longitude),
        PointLatLng(widget.hPosition.latitude, widget.hPosition.longitude));
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
      FirebaseFirestore.instance
          .collection('PoliceLoc')
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((polices) {
          GoogleMapPolyUtil.isLocationOnPath(
                  point: LatLng(
                      polices.data()['latitude'], polices.data()['longitude']),
                  polygon: polylineCoordinates)
              .then((torf) {
            if (torf) {
              pdrivahistory.doc(polices.data()['id']).set({
                'poid': polices.data()['id'],
                'did': FirebaseAuth.instance.currentUser.uid,
                'polatitude': polices.data()['latitude'],
                'polongitude': polices.data()['longitude'],
                'dlatitude': widget.dPosition.latitude,
                'dlongitude': widget.dPosition.longitude,
              });
              pLatLng = LatLng(
                  polices.data()['latitude'], polices.data()['longitude']);
              p1 = polices.data()['latitude'];
              p2 = polices.data()['longitude'];
              mainMethod(polices.data()['phone'],
                  "Ambulance will be using this route kindly log in to app to know the exact location of Ambulance");
            }
            //   print("olala"+polices.data()['phone']);
            // torf?mainMethod(polices.data()['phone'],"Ambulance will be using this route kindly log in to app to know the exact location of Ambulance"):print("Not on Road");
          });
        });
      });
    });
  }

  Future<void> centerScreen(Position position) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
          target: LatLng(position.latitude, position.longitude), zoom: 15),
    ));
  }

  void initState() {
    _geolocatorService.getCurrentLocation().listen((position) {
      centerScreen(position);
    });
    setCustomIcon();
    super.initState();
  }

  void setCustomIcon() async {
    hospitalLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'images/mapHosp1.png');
    policeLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'images/agent.png');
    driverLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'images/ambulanceIcon.png');
  }

  @override
  Widget build(BuildContext context) {
    var locProvider = Provider.of<LocProvider>(context);
    return Scaffold(
        body: Center(
      child: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
                target: LatLng(
                    widget.dPosition.latitude, widget.dPosition.longitude),
                zoom: 15),
            myLocationEnabled: true,
            mapType: MapType.normal,
            polylines: _polylines,
            markers: _markers,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              setMapPoints();
              setPolylines();
              locProvider.setLatLng(
                  widget.dPosition.latitude, widget.dPosition.longitude);
            },
          ),
          //Center(child: Text("Yeah Brother!"),),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Align(
              alignment: Alignment.topRight,
              child: FloatingActionButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NewPage())),
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
}
