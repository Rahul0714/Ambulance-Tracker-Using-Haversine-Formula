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
                      "your template",
                  additionalOptions: {
                    'accessToken':
                        'your token',
                    'id': 'your id'
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
