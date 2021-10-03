import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/location_provider.dart';

class LocationScreen2 extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    final _locationData = Provider.of<LocationProvider>(context, listen: true);
    //_locationData.initLocationTrack();

    return Scaffold(
      appBar: AppBar(title: Text('My Locaiton')),
      body: Column(children: [
        Text('My Location Is'),
        FutureBuilder(
          future: _locationData.initLocation(),
          builder: (ctx,snapshot) => snapshot.connectionState == ConnectionState.waiting 
          ? CircularProgressIndicator()
          : Consumer<LocationProvider>(
            builder: (ctx,locData,_) => Text( 'Latitude: ${locData.location.latitude}, Longitude: ${locData.location.longitude}')
          ),
        )
      ],),
      
    );
  }
}