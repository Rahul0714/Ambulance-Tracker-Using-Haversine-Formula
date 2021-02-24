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
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/3,
            color: Color(0xff031440),
            child: Center(child:Image.asset("images/man.png",
            width: MediaQuery.of(context).size.width/2,
            height: MediaQuery.of(context).size.height/2,),),
          ),
          onTap: (){
            Navigator.push(context,MaterialPageRoute(builder: (context)=>SignIn()));
          },),
          InkWell(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/3,
            color: Color(0xff031440),
            child: Center(child:Image.asset("images/ambulance.png",
            width: MediaQuery.of(context).size.width/2,
            height: MediaQuery.of(context).size.height/2,),),
          ),
          onTap: (){
            Navigator.push(context,MaterialPageRoute(builder: (context)=>DriverSignIn()));
          },),
          InkWell(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/3,
            color: Color(0xff031440),
            child: Center(child:Image.asset("images/policeman.png",
            width: MediaQuery.of(context).size.width/2,
            height: MediaQuery.of(context).size.height/2,),),
          ),
          onTap: (){
            Navigator.push(context,MaterialPageRoute(builder: (context)=>PoliceSignIn()));
          },)
      ],),      
    );
  }
}