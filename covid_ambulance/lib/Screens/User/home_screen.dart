import 'package:covid_ambulance/Screens/User/google_map.dart';
import 'package:covid_ambulance/services/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

class UserHomeScreen extends StatefulWidget {
  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> { 
Position _currentPosition;
final FirebaseAuth auth= FirebaseAuth.instance;
var _currentAddress;
void _getLocation() async{
  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  final coordinates = Coordinates(position.latitude,position.longitude);
  var address = await Geocoder.local.findAddressesFromCoordinates(coordinates);
  userLocCollection.doc(auth.currentUser.uid).set({
    'id':auth.currentUser.uid,
    'latitude':position.latitude,
    'longitude':position.longitude,
    'address':address.first.addressLine.toString(),
  });
  setState(() {
      _currentPosition = position;
      _currentAddress = address;
    });
  Navigator.push(context, MaterialPageRoute(builder: (context)=>DrawMap(currentPosition: position)));
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            SizedBox(height: 20.0,),
            SizedBox(width: double.infinity,
              height: MediaQuery.of(context).size.height/10,
              child: RaisedButton(
                onPressed: (){
                  _getLocation();
                },
                child: Text("Call Ambulance",style: TextStyle(color: Colors.white,fontSize: 19.0),),
                color: Colors.blue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
              SizedBox(height: 20.0,),
              Text(_currentPosition==null?"Latitude:-":_currentPosition.latitude.toString()),
              Text(_currentPosition==null?"Longitude:-":_currentPosition.longitude.toString()),
              Text(_currentAddress==null?"-":_currentAddress.first.addressLine.toString()),
              SizedBox(height: 100.0,),
              Text("Covid Info TODO//"),
          ],
        ),
    );
  }
}