import 'package:covid_ambulance/covidTracker/screens/tracker.dart';
import 'package:flutter/material.dart';

class UserHomeScreen extends StatefulWidget {
  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> { 
  @override
  Widget build(BuildContext context) {
    return Tracker();
        
  }
}