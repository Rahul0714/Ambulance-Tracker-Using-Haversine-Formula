import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PoliceHomeScreen extends StatefulWidget {
  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<PoliceHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text(FirebaseAuth.instance.currentUser.uid,style: TextStyle(fontSize: 20.0),)),
          RaisedButton(onPressed: (){
            FirebaseAuth.instance.signOut();
          },
          child: Text("Sign Out"),
          ),
        ],
      ),
    );
  }
}