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
        children: [
        InkWell(
          child: Row(
    children: <Widget>[
      Container(
        color: Color(0xff031440),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height/3.015,
        child: Stack(
          //fit: StackFit.expand,
          children: <Widget>[
            Center(
              child: Image(
                height: 200,
                width: 200,
                //fit: BoxFit.fitHeight,
                image: AssetImage('images/man.png'),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Column(
                children: <Widget>[
                  Text(
                    "Covid-19 Patients",
                    style: TextStyle(
                        fontFamily: 'AirbnbCereal',
                        fontSize: 21,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ],),
    onTap: (){
      Navigator.push(context,MaterialPageRoute(builder: (context)=>SignIn()));
    },),
          Divider(height: 0.5,),
          InkWell(
          child: Row(
    children: <Widget>[
      Container(
        color: Color(0xff031440),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height/3.015,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Center(
              child: Image(
                height: 200,
                width: 200,
                //fit: BoxFit.fitHeight,
                image: AssetImage('images/ambulance.png'),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Column(
                children: <Widget>[
                  Text(
                    "Ambulance Driver",
                    style: TextStyle(
                        fontFamily: 'AirbnbCereal',
                        fontSize: 21,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ],),
    onTap: (){
      Navigator.push(context,MaterialPageRoute(builder: (context)=>DriverSignIn()));
    },),
          Divider(height: 0.5,),
          InkWell(
          child: Row(
    children: <Widget>[
      Container(
        color: Color(0xff031440),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height/3.015,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Center(
              child: Image(
                height: 200,
                width: 200,
                //fit: BoxFit.fitHeight,
                image: AssetImage('images/policeman.png'),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Column(
                children: <Widget>[
                  Text(
                    "Traffic Police",
                    style: TextStyle(
                        fontFamily: 'AirbnbCereal',
                        fontSize: 21,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ],),
    onTap: (){
      Navigator.push(context,MaterialPageRoute(builder: (context)=>PoliceSignIn()));
    },)
      ],),      
    );
  }
}