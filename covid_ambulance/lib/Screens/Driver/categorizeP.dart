import 'dart:convert';
import 'package:covid_ambulance/Screens/Driver/wayToHospital.dart';
import 'package:vector_math/vector_math.dart' as vector;
import 'dart:math' as Math;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class PatientCategory extends StatefulWidget {
  @override
  _PatientCategoryState createState() => _PatientCategoryState();
}

class _PatientCategoryState extends State<PatientCategory> {
  @override
  var jsonRes;
  final Position dPosition = null;
  //double minDist;
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        InkWell(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
            color: Color(0xff031440),
            child: Center(
              child: Image.asset(
                "images/ventilator.png",
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 2,
              ),
            ),
          ),
          onTap: () {
            _fetchData(1);
          },
        ),
        Divider(
          color: Colors.white,
          height: 1,
        ),
        InkWell(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2.005,
            color: Color(0xff031440),
            child: Center(
              child: Image.asset(
                "images/medical-mask.png",
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 2,
              ),
            ),
          ),
          onTap: () {
            _fetchData(2);
          },
        ),
      ],
    ));
  }

  Future _fetchData(int value) async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    LatLng hospitalCoordinates;
    Position dPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var res = await http.get("API TO FIND HOSPITALS");
    jsonRes = json.decode(res.body);
    if (value == 1) {
      double minDist = 1000.00;
      jsonRes.forEach((hospital) {
        if (hospital['ventilators'] != 0) {
          print(hospital['name']);
          double actDist = _haversine(
              LatLng(dPosition.latitude, dPosition.longitude),
              LatLng(hospital['x_coordinate'], hospital['y_coordinate']));
          print("Actual Dist" + hospital['name'] + " " + actDist.toString());
          if (actDist < minDist) {
            minDist = actDist;
            setState(() {
              hospitalCoordinates =
                  LatLng(hospital['x_coordinate'], hospital['y_coordinate']);
            });
            print("Min" + minDist.toString() + " " + hospital['name']);
          }
        }
      });
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WayToHospital(
                    hPosition: hospitalCoordinates,
                    dPosition: position,
                  )));
    } else if (value == 2) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      double minDist = 1000.0;
      jsonRes.forEach((hospital) {
        print(hospital['name']);
        double actDist = _haversine(
            LatLng(dPosition.latitude, dPosition.longitude),
            LatLng(hospital['x_coordinate'], hospital['y_coordinate']));
        print("Actual Dist" + hospital['name'] + " " + actDist.toString());
        if (actDist < minDist) {
          minDist = actDist;
          setState(() {
            hospitalCoordinates =
                LatLng(hospital['x_coordinate'], hospital['y_coordinate']);
          });
          print("Min" + minDist.toString() + " " + hospital['name']);
        }
      });
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WayToHospital(
                    hPosition: hospitalCoordinates,
                    dPosition: position,
                  )));
    }
  }

  double _haversine(LatLng latLng, LatLng latLng2) {
    int radius = 6371;
    var dlat = vector.radians(latLng.latitude - latLng2.latitude);
    var dlon = vector.radians(latLng.longitude - latLng2.longitude);
    var a = Math.sin(dlat / 2) * Math.sin(dlat / 2) +
        Math.cos(vector.radians(latLng.latitude)) *
            Math.cos(vector.radians(latLng2.latitude)) *
            Math.sin(dlon / 2) *
            Math.sin(dlon / 2);
    var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    var d = radius * c;
    return d;
  }
}
