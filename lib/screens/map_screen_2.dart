import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong2/latlong.dart" as latLng;
import 'package:provider/provider.dart';

import '../providers/location_provider_2.dart';

class MapScreen2 extends StatefulWidget {

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen2> {
  int _times = 0;
  MapController _mapController = MapController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _times++;
    print('I changed dependancies $_times times');
  }
  @override
  Widget build(BuildContext context) {
    LocationProvider2 _locData = Provider.of<LocationProvider2>(context, listen: true);
    _locData.initLocation();




    return !_locData.loaded
      ? CircularProgressIndicator()
      : FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          center: latLng.LatLng(_locData.location.latitude!, _locData.location.longitude!),
          zoom: 13.0,
        ),
        layers: [
          TileLayerOptions(
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
                point: latLng.LatLng(_locData.location.latitude!, _locData.location.longitude!),
                builder: (ctx) =>
                Container(
                  child: FlutterLogo(),
                ),
              ),
            ],
          ),
        ],
    );
  }
}