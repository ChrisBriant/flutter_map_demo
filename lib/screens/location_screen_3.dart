import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/location_provider_2.dart';

class LocationScreen3 extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    Provider.of<LocationProvider2>(context, listen: true).initLocation();
    // bool _loadedLocation = false;

    // Future<void> _getLocation() async {
    //   await _locationData.initLocation();
    //   _loadedLocation = true;
    // }
    

    return Scaffold(
      appBar: AppBar(title: Text('My Locaiton')),
      body: Column(children: [
        Text('My Location Is'),
        Consumer<LocationProvider2>(
            builder: (ctx,locData,_) => locData.loaded
            ? Text( 'Latitude: ${locData.location.latitude}, Longitude: ${locData.location.longitude}')
            : Text('Location not loaded yet')
          ),
        ])
    );
  }
}