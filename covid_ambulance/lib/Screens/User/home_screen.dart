import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_ambulance/Screens/User/google_map.dart';
import 'package:vector_math/vector_math.dart' as vector;
import 'dart:math' as Math;
import 'package:covid_ambulance/covidTracker/screens/tracker.dart';
import 'package:covid_ambulance/services/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserHomeScreen extends StatefulWidget {
  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> { 
// ignore: unused_field
Position _currentPosition;
LatLng driverPosition;
var driverId;
final FirebaseAuth auth= FirebaseAuth.instance;
// ignore: unused_field
var _currentAddress;
double _haversine(LatLng curPosition, LatLng drivPosition){
  int radius = 6371;
  var dlat = vector.radians(curPosition.latitude - drivPosition.latitude);
  var dlon = vector.radians(curPosition.longitude - drivPosition.longitude);

  var a = Math.sin(dlat/2) * Math.sin(dlat/2) + Math.cos(vector.radians(curPosition.latitude)) *Math.cos(vector.radians(drivPosition.latitude))*Math.sin(dlon/2)*Math.sin(dlon/2);
  var c = 2 * Math.atan2(Math.sqrt(a),Math.sqrt(1-a));
  var d = radius * c;
  return d;
}
void _getLocation() async{
  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  final coordinates = Coordinates(position.latitude,position.longitude);
  var address = await Geocoder.local.findAddressesFromCoordinates(coordinates);
  // userLocCollection.doc(auth.cur rentUser.uid).set({
  //   'id':auth.currentUser.uid,
  //   'latitude':position.latitude,
  //   'longitude':position.longitude,
  //   'address':address.first.addressLine.toString(),
  // });
  FirebaseFirestore.instance.collection('DriverLoc').get()
  .then((querySnapshot){
    querySnapshot.docs.forEach((result){
      print(result.data()['id'].toString()+" "+ result.data()['latitude'].toString()+" "+result.data()['longitude'].toString());
      double minDist = 1000.00;
      double actDist = _haversine(LatLng(position.latitude,position.longitude),LatLng(result.data()['latitude'],result.data()['longitude']));
      if(actDist<minDist){
        minDist = actDist;
        setState(() {
          driverPosition = LatLng(result.data()['latitude'],result.data()['longitude']);
          driverId = result.data()['id'];       
        });
      }
    });
  });
  setState(() {
      _currentPosition = position;
      _currentAddress = address;
    });
    Navigator.push(context, MaterialPageRoute(builder: (context)=>DrawMap(currentPosition: position,dPosition: driverPosition)));
}
  @override
  Widget build(BuildContext context) {
    return Container(
      height:100,
    child:Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff031440),
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
            child: Center(child:Image.asset("images/ambulance_call.png",
            width: MediaQuery.of(context).size.width/2,
            height: MediaQuery.of(context).size.height/2,),),
            decoration: BoxDecoration(
              color: Color(0xff031440),
              border: Border.all(color: Colors.white),
            ),
          ),
          onTap: (){
            _getLocation();
            print("****Currenta");
            print(driverPosition);
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