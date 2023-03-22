import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_ambulance/services/locModel.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class PoMap extends StatefulWidget {
  LatLng poPosition;
  PoMap({this.poPosition});
  @override
  _PoMapState createState() => _PoMapState();
}

class _PoMapState extends State<PoMap> {
  BitmapDescriptor policeIcon;
  BitmapDescriptor driverLocationIcon;
  //LatLng _po_position;
  LatLng p2, p1;
  var po1, po2, po3, po4;
  //LatLng _dposition;
  String googleApiKey = "GOOGLE MAP API KEY";
  Set<Marker> _markers = {};
  Completer<GoogleMapController> _controller = Completer();
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    setMapPoints();
  }

  void setMapPoints() {
    setState(() {
      // _markers.add(
      //   Marker(markerId: MarkerId("You"),
      //   icon: policeIcon,
      //   position: widget.poPosition,
      //   infoWindow: InfoWindow(title: "You",snippet: "Your current Position")),
      // );
      _markers.add(
        Marker(
            markerId: MarkerId("Driver"),
            icon: driverLocationIcon,
            position: Provider.of<LocProvider>(context, listen: false).point,
            infoWindow: InfoWindow(
                title: "Driver", snippet: "Driver's current Position")),
      );
    });
  }

  void setCustomIcon() async {
    // policeIcon = await BitmapDescriptor.fromAssetImage(
    //   ImageConfiguration(),
    //   'images/agent.png');
    driverLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'images/ambulanceIcon.png');
  }

  @override
  void initState() {
    super.initState();
    setCustomIcon();
  }

  @override
  Widget build(BuildContext context) {
    //var locprovider = Provider.of<LocProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Google "),
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          markers: _markers,
          mapType: MapType.normal,
          initialCameraPosition:
              CameraPosition(target: widget.poPosition, zoom: 15.0),
        ));
  }
}
