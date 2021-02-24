import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';

class DrawMap extends StatefulWidget {
  final Position currentPosition;
  DrawMap({this.currentPosition}); 
  @override
  _DrawMapState createState() => _DrawMapState();
}

class _DrawMapState extends State<DrawMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("MapBox"),),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(widget.currentPosition.latitude, widget.currentPosition.longitude), minZoom: 17.0),
           layers: [
              new TileLayerOptions(
                  urlTemplate:
                      "https://api.mapbox.com/styles/v1/rahbro14/ckk8crurb18mp17nzpxyfy5nq/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoicmFoYnJvMTQiLCJhIjoiY2trODI0a3V4MGdvMzJvbXN5ZHU3N3NzMyJ9.14tcA5htpCyTcgBQiSEIqA",
                  additionalOptions: {
                    'accessToken':
                        'pk.eyJ1IjoicmFoYnJvMTQiLCJhIjoiY2trODI0a3V4MGdvMzJvbXN5ZHU3N3NzMyJ9.14tcA5htpCyTcgBQiSEIqA',
                    'id': 'mapbox.satellite'
            }),
            MarkerLayerOptions(
              markers:[
                Marker(
                  width: 45.0,
                  height: 45.0,
                  point: LatLng(widget.currentPosition.latitude, widget.currentPosition.longitude),
                  builder: (context)=> Container(
                    child: IconButton(
                      icon:Icon(Icons.location_on),
                      color: Colors.red,
                      iconSize: 45.0,
                      onPressed: (){
                        print("Marker Tapped");
                      },
                    ),
                  ),
                ),
              ]
            ),
          ]
      ),
    );
  }
}