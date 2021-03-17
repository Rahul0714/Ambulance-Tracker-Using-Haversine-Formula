import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_ambulance/covidTracker/screens/tracker.dart';
import 'package:covid_ambulance/services/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

class DriverHomeScreen extends StatefulWidget {
  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<DriverHomeScreen> { 
  
Position _currentPosition;
final FirebaseAuth auth= FirebaseAuth.instance;
var _currentAddress;
void _getLocation() async{
  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  final coordinates = Coordinates(position.latitude,position.longitude);
  var address = await Geocoder.local.findAddressesFromCoordinates(coordinates);
  driverLocCollection.doc(auth.currentUser.uid).set({
    'id':auth.currentUser.uid,
    'latitude':position.latitude,
    'longitude':position.longitude,
    'address':address.first.addressLine.toString(),
  });
  setState(() {
      _currentPosition = position;
      _currentAddress = address;
    });
  //Navigator.push(context, MaterialPageRoute(builder: (context)=>DrawMap(currentPosition: position)));
}
//check this out!!
Widget _basedOnPastButton(){
  FirebaseFirestore.instance.collection('DriverLoc').get()
  .then((querySnapshot){
    querySnapshot.docs.forEach((result){
      if(FirebaseAuth.instance.currentUser.uid == result.data()['id']){
        print("Done");
        return InkWell(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/2.25,
            child: Center(child:Image.asset("images/search.png",
            width: MediaQuery.of(context).size.width/2,
            height: MediaQuery.of(context).size.height/2,),),
            decoration: BoxDecoration(
              color: Color(0xff031440),
              border: Border.all(color: Colors.white),
            ),
          ),
          onTap: (){
            
          });
      }
    });
  });
  return InkWell(
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
            
          });
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
            _basedOnPastButton(),    
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