import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DrawMap extends StatefulWidget {
  final Position currentPosition;
  LatLng dPosition;
  DrawMap({this.currentPosition,this.dPosition}); 
  @override
  _DrawMapState createState() => _DrawMapState();
}

class _DrawMapState extends State<DrawMap> {
  Set<Marker> _markers = {};
  void _onMapCreated(GoogleMapController controller){
    print("****Current");
    print(widget.dPosition.latitude);
    setState(() {
      _markers.add(
        Marker(markerId: MarkerId("You"),
        position:LatLng(widget.currentPosition.latitude,widget.currentPosition.longitude),
        infoWindow: InfoWindow(title: "You",snippet: "Your current Position")),
      );     
       _markers.add(
         Marker(markerId: MarkerId("Driver"),
         position:LatLng(widget.dPosition.latitude,widget.dPosition.longitude),
         infoWindow: InfoWindow(title: "Driver",snippet: "Nearest Driver's current Position")),
       );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Google "),),
       body:GoogleMap(
         onMapCreated: _onMapCreated,
         markers: _markers,
         initialCameraPosition: 
       CameraPosition(target: LatLng(
         widget.currentPosition.latitude,widget.currentPosition.longitude),
         zoom: 15.0
         ),
      )
    );
  }
}
