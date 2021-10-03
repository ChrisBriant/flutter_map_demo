import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong2/latlong.dart" as latLng;
import 'package:provider/provider.dart';

import '../providers/location_provider_2.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<LocationProvider2>(context, listen: true).initLocation();


    return Consumer<LocationProvider2>(
      builder: (ctx,locData,_) => !locData.loaded
      ? CircularProgressIndicator()
      : FlutterMap(
        options: MapOptions(
          center: latLng.LatLng(locData.location.latitude!, locData.location.longitude!),
          zoom: 13.0,
        ),
        layers: [
          TileLayerOptions(
            //https://tile.osm.ch/switzerland/14/8544/5827.png
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
            attributionBuilder: (_) {
              return Text(
                "© OpenStreetMap contributors",
                style: TextStyle(color:Colors.blue[800], fontSize: 20)
              
              );
            },
          ),
          MarkerLayerOptions(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: latLng.LatLng(locData.location.latitude!, locData.location.longitude!),
                builder: (ctx) =>
                Container(
                  child: FlutterLogo(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}