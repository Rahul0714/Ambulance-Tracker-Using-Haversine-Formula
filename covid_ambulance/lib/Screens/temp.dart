import 'package:covid_ambulance/Screens/Driver/driver_signin.dart';
import 'package:covid_ambulance/Screens/User/user_signin.dart';
import 'package:flutter/material.dart';

import 'Police/police_signin.dart';

class AuthDecide extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<AuthDecide> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
      SizedBox(width: double.infinity,
        height: MediaQuery.of(context).size.height/10,
        child: RaisedButton(
          onPressed: (){
            Navigator.push(context,MaterialPageRoute(builder: (context)=>SignIn()));
          },
          child: Text("Users",style: TextStyle(color: Colors.white,fontSize: 19.0),),
            color: Colors.blue,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            ),
          ),
      SizedBox(height: 20.0,),
      SizedBox(width: double.infinity,
        height: MediaQuery.of(context).size.height/10,
        child: RaisedButton(
          onPressed: (){
            Navigator.push(context,MaterialPageRoute(builder: (context)=>DriverSignIn()));
          },
          child: Text("Drivers",style: TextStyle(color: Colors.white,fontSize: 19.0),),
            color: Colors.blue,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            ),
          ),
          SizedBox(height: 20.0,),
      SizedBox(width: double.infinity,
        height: MediaQuery.of(context).size.height/10,
        child: RaisedButton(
          onPressed: (){
            Navigator.push(context,MaterialPageRoute(builder: (context)=>PoliceSignIn()));
          },
          child: Text("Police",style: TextStyle(color: Colors.white,fontSize: 19.0),),
            color: Colors.blue,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            ),
          ),
        ],
      ),      
    );
  }
}