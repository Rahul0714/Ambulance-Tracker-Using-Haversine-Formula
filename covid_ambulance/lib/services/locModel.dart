import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocProvider with ChangeNotifier{
  LatLng _point;
  LocProvider(){
    _point = LatLng(19,22);
  }
  //Getters
  LatLng get point => _point;

  //Setters
  void setLatLng(var lat, var long){
    _point = LatLng(lat,long);
      notifyListeners();
  }
}