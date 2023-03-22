import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commons/commons.dart';
import 'package:covid_ambulance/Screens/Driver/driverMap.dart';
//import 'package:covid_ambulance/Screens/Driver/categorizeP.dart';
//import 'package:covid_ambulance/Screens/Driver/driverMap.dart';
import 'package:covid_ambulance/Screens/Driver/wayToHospital.dart';
//import 'package:covid_ambulance/Screens/Driver/wayToHospital.dart';
import 'package:covid_ambulance/covidTracker/screens/tracker.dart';
import 'package:covid_ambulance/services/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'categorizeP.dart';

class DriverHomeScreen extends StatefulWidget {
  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<DriverHomeScreen> { 
List uid = [];  
int count =0;
Position _currentPosition;
final FirebaseAuth auth= FirebaseAuth.instance;
var _currentAddress;
void _getLocation() async{
  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  final coordinates = Coordinates(position.latitude,position.longitude);
  var address = await Geocoder.local.findAddressesFromCoordinates(coordinates);
   driverLocCollection.doc(auth.currentUser.uid).set({
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
  initstate();
}
List histUid = [];
LatLng patLoc;
var patUid;
void _getUserLocation()async{
  setState(() {
    count = 1;    
  });
  FirebaseFirestore.instance.collection('DPaHistory').get().then((querySnapshot){
    querySnapshot.docs.forEach((result){
      histUid.add(result.data()['did']);
      setState(() {
      patLoc = LatLng(result.data()['plattitude'],result.data()['plongitude']);
      patUid = result.data()['pid'];       
      });
    });
  });
  sleep(const Duration(seconds: 5));
  //print(patUid+" "+"What????");
  if(histUid.contains(FirebaseAuth.instance.currentUser.uid))
    print("****DONE BROTHER");
    initstate();
}
void initstate()async{
  FirebaseFirestore.instance.collection('DriverLoc').get().then((querySnapshot){
    querySnapshot.docs.forEach((result){
      uid.add(result.data()['id']);
    });
  }); 
  successDialog(
    context,
    "Successfully Logged in!"
  );
}
void navigate(){
  setState(() {
  count = 0;    
  });
  print("Done be!");
  //Navigator.push(context,MaterialPageRoute(builder: (context)=>WayToHospital()));
  Navigator.push(context,MaterialPageRoute(builder: (context)=>DriverMap(initialPosition:_currentPosition,patientPosition:patLoc)));
  //Navigator.push(context,MaterialPageRoute(builder: (context)=>PatientCategory()));
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
          (histUid.contains(FirebaseAuth.instance.currentUser.uid)&&count==1?InkWell(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/2.25,
            child: Center(child:Image.asset("images/route.png",
            width: MediaQuery.of(context).size.width/2,
            height: MediaQuery.of(context).size.height/2,),),
            decoration: BoxDecoration(
              color: Color(0xff031440),
              border: Border.all(color: Colors.white),
            ),
          ),
          onTap: (){
            navigate();
          }):InkWell(
            child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/2.25,
            child: Center(child:Image.asset("images/placeholder.png",
            width: MediaQuery.of(context).size.width/2,
            height: MediaQuery.of(context).size.height/2,),),
            decoration: BoxDecoration(
              color: Color(0xff031440),
              border: Border.all(color: Colors.white),
            ),
          ),
          onTap: (){
            _getLocation();
            _getUserLocation();
          })),  
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