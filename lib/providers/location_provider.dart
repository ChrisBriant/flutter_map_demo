
import 'package:location/location.dart';
import 'package:flutter/widgets.dart';

class LocationProvider with ChangeNotifier{
  Location _location = new Location();
  late LocationData _locationData;

  Future<dynamic> initLocation() async {
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

    // _location.onLocationChanged.listen((LocationData currentLocation) {
    //   // Use current location
    //   print('Location Changed');
    //   _locationData = currentLocation;
    //   //notifyListeners();
    // });

    _locationData = await _location.getLocation();
    return _locationData; 
  }

  initLocationTrack() {
    _location.onLocationChanged.listen((LocationData currentLocation) {
      // Use current location
      print('Location Changed');
      _locationData = currentLocation;
      notifyListeners();
    });
  }

  LocationData get location {
    return _locationData;
  }




}
 
