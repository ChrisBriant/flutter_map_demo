import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationScreen5 extends StatefulWidget {


  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen5> {
  Location _location = new Location();
  late LocationData _locationData;
  bool _locationLoaded = false;

  Future<dynamic> _initLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

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

  Future<LocationData> _getLocationData() async {

    if(!_locationLoaded) {
      _locationData = await _initLocation();
      //Add Location listener
      _location.onLocationChanged.listen((LocationData currLoc) {
        // Use current location
        print('Location Changed');
        _locationData = currLoc;
       });
      _locationLoaded = true;
      return _locationData;
    } else {
      return _locationData;
    }
  }


  @override
  void initState() {
    super.initState();
    // _locationData = await _initLocation();
    // setState(() {
     
    //  _locationLoaded = true;
    // });

    //Add Location listener
    // _location.onLocationChanged.listen((LocationData currentLocation) {
    //   // Use current location
    //   print('Location Changed');
    //   setState(() {
    //     _locationData = currentLocation;
    //   });
    // });
  }


  @override
  Widget build(BuildContext context) {

    //Add Location listener
    // _location.onLocationChanged.listen((LocationData currentLocation) {
    //   // Use current location
    //   print('Location Changed');
    //   setState(() {
    //     _locationData = currentLocation;
    //   });
    // });
    
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
            future: _getLocationData(),
            builder: (ctx,snapshot) => snapshot.connectionState == ConnectionState.waiting 
            ? CircularProgressIndicator()
            : snapshot.data == null 
              ? Text('Unable to retrieve location')
              : Text(
                 'Latitude ${_locationData.latitude.toString()}, Longitude: ${_locationData.longitude.toString()}' )
          )
        ],
      ),
    );
  }
}