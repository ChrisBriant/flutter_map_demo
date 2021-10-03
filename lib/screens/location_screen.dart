import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    Location _location = new Location();

    Future<dynamic> _initLocation() async {
      

      bool _serviceEnabled;
      PermissionStatus _permissionGranted;
      LocationData _locationData;

      _serviceEnabled = await _location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await _location.requestService();
        if (!_serviceEnabled) {
          print('Service is not enabled');
          return;
        }
      }

      _permissionGranted = await _location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        print('I should ask permission');
        _permissionGranted = await _location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          print('Permission is not granted');
          return;
        }
      }



      return await _location.getLocation();
    }


    _location.onLocationChanged.listen((LocationData currentLocation) {
      // Use current location
      print('Location Changed');
    });


    return Scaffold(
      appBar: AppBar(
        title: Text('Location'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('My Location'),
          FutureBuilder(
            future: _initLocation(),
            builder: (ctx,snapshot) => snapshot.connectionState == ConnectionState.waiting 
            ? CircularProgressIndicator()
            : snapshot.data == null 
              ? Text('Unable to retrieve location')
              : Text(
                 'Latitude ${(snapshot.data as LocationData).latitude.toString()}, Longitude: ${(snapshot.data as LocationData).longitude.toString()}' )
          )
        ],
        
      ),
    );
  }
}