import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:covid_ambulance/Screens/Driver/categorizeP.dart';
import 'package:covid_ambulance/Screens/Driver/driverMap.dart';
import 'package:covid_ambulance/covidTracker/screens/tracker.dart';
import 'package:covid_ambulance/services/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DriverHomeScreen extends StatefulWidget {
  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<DriverHomeScreen> {
  List uid = [];
  int count = 0;
  Position _currentPosition;
  final FirebaseAuth auth = FirebaseAuth.instance;
  var _currentAddress;
  void _getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    final coordinates = Coordinates(position.latitude, position.longitude);
    var address =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    driverLocCollection.doc(auth.currentUser.uid).set({
      'id': auth.currentUser.uid,
      'phone': auth.currentUser.phoneNumber,
      'latitude': position.latitude,
      'longitude': position.longitude,
      'address': address.first.addressLine.toString(),
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
  void _getUserLocation() async {
    setState(() {
      count = 1;
    });
    FirebaseFirestore.instance
        .collection('DPaHistory')
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        histUid.add(result.data()['did']);
        setState(() {
          patLoc =
              LatLng(result.data()['plattitude'], result.data()['plongitude']);
          patUid = result.data()['pid'];
        });
      });
    });
    sleep(const Duration(seconds: 5));
    //print(patUid+" "+"What????");
    if (histUid.contains(FirebaseAuth.instance.currentUser.uid))
      print("****DONE BROTHER");
    initstate();
  }

  void initstate() async {
    FirebaseFirestore.instance
        .collection('DriverLoc')
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        uid.add(result.data()['id']);
      });
    });
  }

  void navigate() {
    setState(() {
      count = 0;
    });
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DriverMap(
                initialPosition: _currentPosition, patientPosition: patLoc)));
    //Navigator.push(context,MaterialPageRoute(builder: (context)=>PatientCategory()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff031440),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                int _count = 0;
                FirebaseAuth.instance.signOut();
                Navigator.popUntil(context, (route) {
                  return _count++ == 2;
                });
              },
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            (uid.contains(FirebaseAuth.instance.currentUser.uid) && count == 0
                ? InkWell(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2.25,
                      child: Center(
                        child: Image.asset(
                          "images/search.png",
                          width: MediaQuery.of(context).size.width / 2,
                          height: MediaQuery.of(context).size.height / 2,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xff031440),
                        border: Border.all(color: Colors.white),
                      ),
                    ),
                    onTap: () {
                      _getUserLocation();
                    })
                : (histUid.contains(FirebaseAuth.instance.currentUser.uid) &&
                        count == 1
                    ? InkWell(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 2.25,
                          child: Center(
                            child: Image.asset(
                              "images/navigation.png",
                              width: MediaQuery.of(context).size.width / 2,
                              height: MediaQuery.of(context).size.height / 2,
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xff031440),
                            border: Border.all(color: Colors.white),
                          ),
                        ),
                        onTap: () {
                          navigate();
                        })
                    : InkWell(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 2.25,
                          child: Center(
                            child: Image.asset(
                              "images/placeholder.png",
                              width: MediaQuery.of(context).size.width / 2,
                              height: MediaQuery.of(context).size.height / 2,
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xff031440),
                            border: Border.all(color: Colors.white),
                          ),
                        ),
                        onTap: () {
                          _getLocation();
                        }))),
            InkWell(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.22,
                child: Center(
                  child: Image.asset(
                    "images/diagram.png",
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height / 2,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color(0xff031440),
                  border: Border.all(color: Colors.white),
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Tracker()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
//kkkkkkkkkkkkkkkkkk//
// import 'package:covid_ambulance/Screens/Driver/driver_signin.dart';
// import 'package:covid_ambulance/Screens/User/user_signin.dart';
// import 'package:flutter/material.dart';

// import 'Police/police_signin.dart';

// class AuthDecide extends StatefulWidget {
//   @override
//   _SignUpPageState createState() => _SignUpPageState();
// }

// class _SignUpPageState extends State<AuthDecide> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//         InkWell(
//           child: Container(
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height/3.019,
//             color: Color(0xff031440),
//             child: Center(child:Image.asset("images/man.png",
//             width: MediaQuery.of(context).size.width/2,
//             height: MediaQuery.of(context).size.height/2,),),
//           ),
//           onTap: (){
//             Navigator.push(context,MaterialPageRoute(builder: (context)=>SignIn()));
//           },),
//           Divider(height: 0.5,),
//           InkWell(
//           child: Container(
//             width: MediaQuery.aof(context).size.width,
//             height: MediaQuery.of(context).size.height/3,
//             color: Color(0xff031440),
//             child: Center(child:Image.asset("images/ambulance.png")),
//           ),
//           onTap: (){
//             Navigator.push(context,MaterialPageRoute(builder: (context)=>DriverSignIn()));
//           },),
//           Divider(height: 0.5,),
//           InkWell(
//           child: Container(
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height/3,
//             color: Color(0xff031440),
//             child: Center(child:Image.asset("images/policeman.png")),
//           ),
//           onTap: (){
//             Navigator.push(context,MaterialPageRoute(builder: (context)=>PoliceSignIn()));
//           },)
//       ],),      
//     );

// TextStyle(
//                         fontFamily: 'roboto',
//                         fontSize: 21,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white),
//   }
// }
//jslkfjsldkflksdjf//
// import 'package:covid_ambulance/Screens/User/home_screen.dart';
// import 'package:covid_ambulance/Screens/User/user_phone.dart';
// import 'package:covid_ambulance/Screens/User/user_sign_up.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';


// class SignIn extends StatefulWidget {
//   @override
//   _SignUpPageState createState() => _SignUpPageState();
// }

// class _SignUpPageState extends State<SignIn> {
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//   bool _obscureText = true;
//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _passwordcontroller = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       //backgroundColor: Color,
//       key: _scaffoldKey,
//       body: SingleChildScrollView(
//               child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             SizedBox(height: MediaQuery.of(context).size.height/7),
//               Padding(
//                 padding: const EdgeInsets.only(left:25.0),
//                 child: Text("Let's Sign You In",style: TextStyle(fontSize: 35.0,color: Colors.blue[900]),),
//               ),
//               SizedBox(height: 15.0,),
//                Padding(
//                  padding: const EdgeInsets.only(left:25.0),
//                  child: Text("Welcome!",style: TextStyle(fontSize: 17.0,color: Colors.lightBlue),),
//                ),
//                SizedBox(height: 35.0,),
//                Center(
//                  child: Column(
//                    children: [
//                      Container(
//                        width: MediaQuery.of(context).size.width/1.1,
//                        child: Card(
//                            child:TextField(
//                              keyboardType: TextInputType.emailAddress,
//                              controller: _emailController,
//                              decoration: InputDecoration(
//                                 labelText: "E-mail",
//                                 labelStyle: TextStyle(color: Colors.black,fontSize: 17),
//                                 floatingLabelBehavior: FloatingLabelBehavior.auto,
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.all(Radius.circular(10.0)), 
//                                   ),
//                                 prefixIcon: Icon(Icons.email),
//                              ),
//                            ),
//                           ),
//                         ),
//                        SizedBox(height: 35.0,),
//                        Container(
//                          width: MediaQuery.of(context).size.width/1.1,
//                          child: Card(
//                            child: TextField(
//                              controller: _passwordcontroller,
//                              decoration: InputDecoration(
//                                 labelText: "Password",
//                                 labelStyle: TextStyle(color: Colors.black,fontSize: 17),
//                                 floatingLabelBehavior: FloatingLabelBehavior.auto,
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.all(Radius.circular(10.0)), 
//                                   ),
//                                 prefixIcon: Icon(Icons.lock),
//                                 suffixIcon: IconButton(
//                                   icon:Icon(_obscureText?Icons.visibility:Icons.visibility_off),
//                                   onPressed: (){
//                                     setState(() {
//                                       _obscureText = !_obscureText;
//                                     });
//                                   },
//                                 ), 
//                              ),
//                              obscureText: _obscureText,
//                            ),
//                          ),
//                        ),
//                    //),
//                    SizedBox(height: 35.0,),
//                    SizedBox(width: MediaQuery.of(context).size.width/1.1,
//                    height: MediaQuery.of(context).size.height/13,
//                    child: RaisedButton(
//                     onPressed: (){
//                       try{
//                         FirebaseAuth.instance.signInWithEmailAndPassword(
//                           email: _emailController.text, 
//                           password: _passwordcontroller.text);
//                           Navigator.push(context, MaterialPageRoute(builder: (context)=>UserHomeScreen()));
//                       }catch(e){
//                         print(e);
//                         var snackbar = SnackBar(content: Text(e.toString()));
//                         _scaffoldKey.currentState.showSnackBar(snackbar);
//                       }
//                     },
//                     child: Text("Sign In",style: TextStyle(color: Colors.white,fontSize: 19.0),),
//                     color: Colors.blue,
//                     ),),
//                     SizedBox(height: 25.0,),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Text("Don't have an account?"),
//                         FlatButton(onPressed: (){
//                           Navigator.push(context, MaterialPageRoute(builder: (context)=>UserSignUp()));
//                         }, child: Text("Sign Up"),),
//                       ],
//                     ),
//                     SizedBox(height: 35.0,),
//                    SizedBox(width: MediaQuery.of(context).size.width/1.1,
//                    height: MediaQuery.of(context).size.height/13,
//                    child: RaisedButton(
//                     onPressed: (){
//                       Navigator.push(context, MaterialPageRoute(builder: (context)=>UserPhone()));
//                     },
//                     child: Text("Log In Phone",style: TextStyle(color: Colors.white,fontSize: 19.0),),
//                     color: Colors.blue,
//                     ),),
//                   ],
//                  ), 
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }