import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_ambulance/Screens/Police/po_map.dart';
import 'package:covid_ambulance/covidTracker/screens/tracker.dart';
import 'package:covid_ambulance/services/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PoliceHomeScreen extends StatefulWidget {
  @override
  _PoliceHomeScreen createState() => _PoliceHomeScreen();
}

class _PoliceHomeScreen extends State<PoliceHomeScreen> { 
// ignore: unused_field
Position _currentPosition;
String phone;
final FirebaseAuth auth= FirebaseAuth.instance;
// ignore: unused_field
var _currentAddress;
void _getLocation() async{
  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  final coordinates = Coordinates(position.latitude,position.longitude);
  var address = await Geocoder.local.findAddressesFromCoordinates(coordinates);
  policeLocCollection.doc(auth.currentUser.uid).set({
    'id':auth.currentUser.uid,
    'phone':auth.currentUser.phoneNumber,
    'latitude':position.latitude,
    'longitude':position.longitude,
    'address':address.first.addressLine.toString(),
   });
  setState(() {
      _currentPosition = position;
      _currentAddress = address;
    });
    Navigator.push(context, MaterialPageRoute(builder: (context)=>PoMap(poPosition:LatLng(position.latitude,position.longitude))));
}
  @override
  Widget build(BuildContext context) {
    return Container(
      height:100,
    child:Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(icon: Icon(Icons.logout),onPressed: (){
            int _count =0;
            FirebaseAuth.instance.signOut();
            Navigator.popUntil(context, (route) {
            return _count++ ==2;
          });
          },)
        ],),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
                InkWell(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/2.245,
            child: Center(child:Image.asset("images/radar.png",
            width: MediaQuery.of(context).size.width/2,
            height: MediaQuery.of(context).size.height/2,),),
            decoration: BoxDecoration(
              color: Color(0xff031440),
              border: Border.all(color: Colors.white),
            ),
          ),
          onTap: (){
            _getLocation();
          },),
              InkWell(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/2.22,
            child: Center(child:Image.asset("images/diagram.png",
            width: MediaQuery.of(context).size.width/2,
            height: MediaQuery.of(context).size.height/2,),),
            decoration: BoxDecoration(
              color: Color(0xff031440),
              border: Border.all(color: Colors.white),
            ),
          ),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Tracker()));
          },),
          ],
        ),
    ),
    );
  }
}